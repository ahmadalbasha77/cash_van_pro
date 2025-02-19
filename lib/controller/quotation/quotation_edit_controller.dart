import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../core/my_shared_preferences.dart';
import '../../core/utils.dart';
import '../../model/customers/customers_model.dart';
import '../../model/invoice/cart_model.dart';
import '../../model/quotation/quotation_info_model.dart';
import '../../network/rest_api.dart';
import '../../view/ui/home/customers_screen.dart';
import '../customers/customers_controller.dart';

class QuotationEditController extends GetxController {
  static QuotationEditController get to =>
      Get.isRegistered<QuotationEditController>()
          ? Get.find<QuotationEditController>()
          : Get.put(QuotationEditController());
  final RestApi restApi = RestApi();

  List<QuotationInfoModel> quotationInfoList = [];
  final Map<int, CartModel> _cartMap = {};

  final GlobalKey<FormState> priceKey = GlobalKey<FormState>();
  final TextEditingController newPriceController = TextEditingController();

  bool isLoading = false;
  int? quotationId;
  String? quotationDate;

  @override
  void onInit() {
    quotationId = Get.arguments['id'];
    quotationDate = Get.arguments['date'];
    getQuotationInfo();
    super.onInit();
  }

  void getQuotationInfo() async {
    isLoading = true;
    update();
    quotationInfoList = await restApi.getQuotationInfo(headerId: quotationId!);
    for (var item in quotationInfoList) {
      _cartMap[item.itemId] = CartModel(
        itemId: item.itemId,
        quantity: item.qtyOut.toInt(),
        priceAfterTax: item.priceAfterTax,
        itemName: item.aName,
      );
    }
    isLoading = false;
    update();
  }

  void changePriceSales(int itemId) {
    if (priceKey.currentState!.validate()) {
      _cartMap[itemId]!.priceAfterTax = double.parse(newPriceController.text);
      newPriceController.clear();
      Get.back();
      update();
    }
  }

  List<CartModel> get cartList => _cartMap.values.toList();

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

  Future<void> editQuotation({
    required int customerId,
  }) async {
    Utils.showLoadingDialog();

    String cartJson = _cartMap.values
        .map((item) => {
              "itemId": item.itemId,
              "QTYIN": 0,
              "QTYOUT": item.quantity,
              "PriceAfterTax": item.priceAfterTax,
              "TotalAfterTax": item.totalPrice,
              "DiscountAmount": 0,
              "DiscountPercentage": 0,
              "BranchID": '${mySharedPreferences.getUserData()!.branchId}',
              "StoreID": '${mySharedPreferences.getUserData()!.storeId}',
            })
        .toList()
        .toString();

    bool result = await restApi.addEditQuotation({
      "ID": '0',
      "SalesID": '$quotationId',
      "InvoiceDate": '$quotationDate',
      "SettelmentWayID": '0',
      "CustomerID": '$customerId',
      "CashID": '${mySharedPreferences.getUserData()!.cashId}',
      "TaxType": '1',
      "SalesManID": '1',
      "UserID": '${mySharedPreferences.getUserData()!.id}',
      "NumberCar": "",
      "TranactionType": '33',
      "BranchID": '${mySharedPreferences.getUserData()!.branchId}',
      "StoreID": '${mySharedPreferences.getUserData()!.storeId}',
      "SalesJson": cartJson,
    });

    if (result == true) {
      // Utils.hideLoadingDialog();

      final controller = CustomersController.to;
      controller.getCustomers();

      cartList.clear();
      _cartMap.clear();
      update();
      Utils.showSnackbar('Success', 'Quotation edited successfully');
      Get.offAll(() => CustomersScreen());
    } else {
      Utils.hideLoadingDialog();
      Utils.showSnackbar(
          'Failed', 'An error occurred while editing the invoice.');
    }
  }
}
