import 'package:cash_van_app/model/invoice/item_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../network/rest_api.dart';

class ItemByCategoryIdQuotationController extends GetxController {
  static ItemByCategoryIdQuotationController get to =>
      Get.isRegistered<ItemByCategoryIdQuotationController>()
          ? Get.find<ItemByCategoryIdQuotationController>()
          : Get.put(ItemByCategoryIdQuotationController());

  List<ItemModel> itemList = [];
  bool isLoading = false;
  final RestApi restApi = RestApi();
  int? categoryId;
  final TextEditingController searchController = TextEditingController();

  void getItem() async {
    isLoading = true;
    update();
    itemList = await restApi.getItemByCategoryId(
        categoryId: categoryId!, search: searchController.text);

    isLoading = false;
    update();
  }
}
