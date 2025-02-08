import 'package:cash_van_app/model/invoice/item_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../network/rest_api.dart';

class ItemByCategoryIdProposalController extends GetxController {
  static ItemByCategoryIdProposalController get to =>
      Get.isRegistered<ItemByCategoryIdProposalController>()
          ? Get.find<ItemByCategoryIdProposalController>()
          : Get.put(ItemByCategoryIdProposalController());

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
