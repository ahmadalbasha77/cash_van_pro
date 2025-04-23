import 'package:cash_van_app/core/my_shared_preferences.dart';
import 'package:cash_van_app/core/utils.dart';
import 'package:cash_van_app/model/customers/customers_model.dart';
import 'package:cash_van_app/view/ui/home/customers_screen.dart';
import 'package:cash_van_app/view/ui/visit/visit_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:printing/printing.dart';
import '../../model/invoice/cart_model.dart';
import '../../model/invoice/invoice_model.dart';
import '../../network/rest_api.dart';
import '../../view/ui/sales_invoice_pdf.dart';
import '../customers/customers_controller.dart';

class CartController extends GetxController {
  final Map<int, CartModel> _cartMap = {};
  final RestApi restApi = RestApi();

  int paymentType = 0;

  List<CartModel> get cartList => _cartMap.values.toList();

  final GlobalKey<FormState> priceKey = GlobalKey<FormState>();

  final TextEditingController newPriceController = TextEditingController();
  final TextEditingController noteController = TextEditingController();

  changePriceProduct(int itemId) {
    if (priceKey.currentState!.validate()) {
      _cartMap[itemId]!.priceAfterTax = double.parse(newPriceController.text);
      newPriceController.clear();

      Get.back();
      update();
    }
  }

  void addItem(CartModel item) {
    if (_cartMap.containsKey(item.itemId)) {
      _cartMap[item.itemId]!.quantity += item.quantity;
    } else {
      _cartMap[item.itemId] = item;
    }
    update();
  }

  void removeItem(int itemId) {
    _cartMap.remove(itemId);
    update();
  }

  void updatePaymentType(int value) {
    paymentType = value;
    update();
  }

  void increaseQuantity(int itemId) {
    if (_cartMap.containsKey(itemId)) {
      _cartMap[itemId]!.quantity++;
      update();
    }
  }

  void decreaseQuantity(int itemId) {
    if (_cartMap.containsKey(itemId) && _cartMap[itemId]!.quantity > 1) {
      _cartMap[itemId]!.quantity--;
      update();
    }
  }

  double get totalCartPrice {
    return _cartMap.values.fold(0, (sum, item) => sum + item.totalPrice);
  }

  Future<void> addInvoice(
      {required CustomersModel customer, required bool isRefund}) async {
    Get.back();
    Utils.showLoadingDialog();

    String cartJson = _cartMap.values
        .map((item) => {
              "itemId": item.itemId,
              "QTYIN": isRefund ? item.quantity : 0,
              "QTYOUT": isRefund ? 0 : item.quantity,
              "PriceAfterTax": item.priceAfterTax,
              "TotalAfterTax": item.totalPrice,
              "DiscountAmount": 0,
              "DiscountPercentage": 0,
              "BranchID": '${mySharedPreferences.getUserData()!.branchId}',
              "StoreID": '${mySharedPreferences.getUserData()!.storeId}',
            })
        .toList()
        .toString();

    final apiMethod =
        isRefund ? restApi.addRefundInvoice : restApi.addSalesInvoice;
    InvoiceModel result = await apiMethod({
      "ID": '0',
      "InvoiceDate": DateTime.now().toIso8601String(),
      "SettelmentWayID": '$paymentType',
      "CustomerID": '${customer.id}',
      "CashID": '${mySharedPreferences.getUserData()!.cashId}',
      "TaxType": '1',
      "SalesManID": '1',
      "UserID": '${mySharedPreferences.getUserData()!.id}',
      "NumberCar": "",
      "Notes": noteController.text.isEmpty ? "" : noteController.text,
      "TranactionType": isRefund ? '14' : '33',
      "BranchID": '${mySharedPreferences.getUserData()!.branchId}',
      "StoreID": '${mySharedPreferences.getUserData()!.storeId}',
      isRefund ? "ReturnJson" : "SalesJson": cartJson,
    });

    if (result.salesId != 0 || result.returnId != 0) {
      // Utils.hideLoadingDialog();

      final invoicePdf = await salesInvoicePdf(
          invoiceId: isRefund ? result.returnId : result.salesId,
          cartList: cartList,
          invoiceType: isRefund ? 'Refund' : 'Sales',
          paymentType: paymentType == 1 ? 'Cash' : 'Credit',
          customerName: customer.aName,
          note: noteController.text,
          customerNumber: customer.telephone1,
          representativeName: mySharedPreferences.getUserData()!.eName,
          totalAmount: totalCartPrice);
      await Printing.layoutPdf(
        onLayout: (format) => invoicePdf.save(),
      );

      final controller = Get.find<CustomersController>();
      controller.getCustomers();

      paymentType = 0;
      noteController.clear();
      cartList.clear();
      _cartMap.clear();
      update();
      Utils.showSnackbar('Success', 'Invoice added successfully');
      Get.offAll(() => const VisitScreen(),arguments: customer);
    } else {
      Utils.hideLoadingDialog();
      Utils.showSnackbar(
          'Failed', 'An error occurred while adding the invoice.');
    }
  }
}
