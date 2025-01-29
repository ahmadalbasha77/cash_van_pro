import 'package:get/get.dart';
import 'package:printing/printing.dart';

import '../../core/my_shared_preferences.dart';
import '../../core/utils.dart';
import '../../model/customers/customers_model.dart';
import '../../model/invoice/cart_model.dart';
import '../../network/rest_api.dart';
import '../../view/ui/home/customers_screen.dart';
import '../../view/ui/invoice/sales_and_refund_invoice_pdf.dart';
import '../../view/ui/sales_invoice_pdf.dart';

class SalesAndRefundController extends GetxController {
  final Map<int, CartModel> _salesMap = {};
  final Map<int, CartModel> _refundMap = {};
  final RestApi restApi = RestApi();

  int paymentType = 0;

  List<CartModel> get salesList => _salesMap.values.toList();

  List<CartModel> get refundList => _refundMap.values.toList();

  void updatePaymentType(int value) {
    paymentType = value;
    update();
  }

  void addItemSales(CartModel item) {
    if (_salesMap.containsKey(item.itemId)) {
      _salesMap[item.itemId]!.quantity += item.quantity;
    } else {
      _salesMap[item.itemId] = item;
    }
    update();
  }

  void addItemRefund(CartModel item) {
    if (_refundMap.containsKey(item.itemId)) {
      _refundMap[item.itemId]!.quantity += item.quantity;
    } else {
      _refundMap[item.itemId] = item;
    }
    update();
  }

  void removeItemSales(int itemId) {
    _salesMap.remove(itemId);
    update();
  }

  void removeItemRefund(int itemId) {
    _refundMap.remove(itemId);
    update();
  }

  void increaseQuantitySales(int itemId) {
    if (_salesMap.containsKey(itemId)) {
      final item = _salesMap[itemId]!;
      item.quantity++;
      update();
    }
  }

  void increaseQuantityRefund(int itemId) {
    if (_refundMap.containsKey(itemId)) {
      final item = _refundMap[itemId]!;
      item.quantity++;
      update();
    }
  }

  void decreaseQuantitySales(int itemId) {
    if (_salesMap.containsKey(itemId)) {
      final item = _salesMap[itemId]!;
      if (item.quantity > 1) {
        item.quantity--;
        update();
      }
    }
  }

  void decreaseQuantityRefund(int itemId) {
    if (_refundMap.containsKey(itemId)) {
      final item = _refundMap[itemId]!;
      if (item.quantity > 1) {
        item.quantity--;
        update();
      }
    }
  }

  double calculateTotal(Map<int, CartModel> map) {
    return map.values.fold(0, (sum, item) => sum + item.totalPrice);
  }

  double get totalSalesPrice => calculateTotal(_salesMap);

  double get totalRefundPrice => calculateTotal(_refundMap);

  double get totalPrice => totalSalesPrice - totalRefundPrice;

  Future<void> addSalesAndRefundInvoice(CustomersModel customer) async {
    Get.back();
    Utils.showLoadingDialog();

    String salesJson = _salesMap.values
        .map((item) => {
              "itemId": item.itemId,
              "QTYIN": 0,
              "QTYOUT": item.quantity,
              "PriceAfterTax": item.priceAfterTax,
              "TotalAfterTax": item.totalPrice,
              "DiscountAmount": 0,
              "DiscountPercentage": 0,
              "BranchID": '${mySharedPreferences.getUserData()!.branchId}',
              "StoreID": '${mySharedPreferences.getUserData()!.storeId}'
            })
        .toList()
        .toString();

    String refundJson = _refundMap.values
        .map((item) => {
              "itemId": item.itemId,
              "QTYIN": item.quantity,
              "QTYOUT": 0,
              "PriceAfterTax": item.priceAfterTax,
              "TotalAfterTax": item.totalPrice,
              "DiscountAmount": 0,
              "DiscountPercentage": 0,
              "BranchID": '${mySharedPreferences.getUserData()!.branchId}',
              "StoreID": '${mySharedPreferences.getUserData()!.storeId}'
            })
        .toList()
        .toString();
    bool result;

    if (_salesMap.isEmpty || _refundMap.isEmpty) {
      final apiMethod = _salesMap.isEmpty
          ? restApi.addRefundInvoice
          : restApi.addSalesInvoice;
      result = await apiMethod({
        "ID": '0',
        "InvoiceDate": DateTime.now().toIso8601String(),
        "SettelmentWayID": '$paymentType',
        "CustomerID": '${customer.id}',
        "CashID": '${mySharedPreferences.getUserData()!.cashId}',
        "TaxType": '1',
        "SalesManID": '1',
        "UserID": '${mySharedPreferences.getUserData()!.id}',
        "NumberCar": "",
        "TranactionType": _salesMap.isEmpty ? '14' : '33',
        "BranchID": '${mySharedPreferences.getUserData()!.branchId}',
        "StoreID": '${mySharedPreferences.getUserData()!.storeId}',
        _salesMap.isEmpty ? "ReturnJson" : "SalesJson":
            _salesMap.isEmpty ? refundJson : salesJson,
      });
    } else {
      result = await restApi.addSalesAndRefund({
        "InvoiceDate": DateTime.now().toIso8601String(),
        "SettelmentWayID": '$paymentType',
        "CustomerID": '${customer.id}',
        "CashID": '${mySharedPreferences.getUserData()!.cashId}',
        "TaxType": '1',
        "SalesManID": '1',
        "UserID": '${mySharedPreferences.getUserData()!.id}',
        "NumberCar": "",
        "BranchID": '${mySharedPreferences.getUserData()!.branchId}',
        "StoreID": '${mySharedPreferences.getUserData()!.storeId}',
        "SalesJson": salesJson,
        "ReturnJson": refundJson
      });
    }

    if (result) {
      if (_salesMap.isEmpty || _refundMap.isEmpty) {
        final salesInvoice = await salesInvoicePdf(
            cartList: _salesMap.isEmpty ? refundList : salesList,
            invoiceType: _salesMap.isEmpty ? 'Refund' : 'Sales',
            paymentType: paymentType == 1 ? 'Cash' : 'Credit',
            customerName: customer.aName,
            customerNumber: customer.telephone1,
            representativeName: mySharedPreferences.getUserData()!.eName,
            totalAmount: totalPrice);

        await Printing.layoutPdf(
          onLayout: (format) => salesInvoice.save(),
        );
      } else {
        final invoicePdf = await salesRefundInvoicePdf(
            refundList: refundList,
            totalRefundAmount: totalRefundPrice,
            totalSalesAmount: totalSalesPrice,
            salesList: salesList,
            paymentType: paymentType == 1 ? 'Cash' : 'Credit',
            customerName: customer.aName,
            customerNumber: customer.telephone1,
            representativeName: mySharedPreferences.getUserData()!.eName,
            totalAmount: totalPrice);

        await Printing.layoutPdf(
          onLayout: (format) => invoicePdf.save(),
        );
      }

      paymentType = 0;
      salesList.clear();
      refundList.clear();
      _salesMap.clear();
      _refundMap.clear();
      update();
      Utils.showSnackbar('Success', 'Invoice added successfully');
      Get.offAll(() => CustomersScreen());
    } else {
      Utils.hideLoadingDialog();
      Utils.showSnackbar(
          'Failed', 'An error occurred while adding the Invoice.');
    }
  }
}
