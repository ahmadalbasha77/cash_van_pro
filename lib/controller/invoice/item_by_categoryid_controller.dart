import 'package:cash_van_app/model/invoice/item_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../network/rest_api.dart';

class ItemByCategoryIdController extends GetxController {
  static ItemByCategoryIdController get to =>
      Get.isRegistered<ItemByCategoryIdController>()
          ? Get.find<ItemByCategoryIdController>()
          : Get.put(ItemByCategoryIdController());

  List<ItemModel> itemList = [];
  bool isLoading = false;
  final RestApi restApi = RestApi();
  int? categoryId;
  final TextEditingController searchController = TextEditingController();

  @override
  void onInit() {
    categoryId = Get.arguments['id'];
    getItem();
    super.onInit();
  }

  void getItem() async {
    isLoading = true;
    update();
    itemList = await restApi.getItemByCategoryId(
        categoryId: categoryId!, search: searchController.text);

    isLoading = false;
    update();
  }
}
