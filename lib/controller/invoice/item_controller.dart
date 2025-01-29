import 'package:cash_van_app/model/invoice/item_model.dart';
import 'package:get/get.dart';

import '../../network/rest_api.dart';

class ItemController extends GetxController {
  static ItemController get to => Get.isRegistered<ItemController>()
      ? Get.find<ItemController>()
      : Get.put(ItemController());

  List<ItemModel> itemList = [];
  bool isLoading = false;
  final RestApi restApi = RestApi();

  @override
  void onInit() {
    getItem();
    super.onInit();
  }

  int categoryId = 0;

  void getItem() async {
    isLoading = true;
    update();
    itemList = await restApi.getItem(categoryId: categoryId);
    isLoading = false;
    update();
  }

  Future<List<String>> getRequestData(String query) async {
    return await Future.delayed(const Duration(seconds: 1), () {
      return itemList
          .where((e) => e.itemName.toLowerCase().contains(query.toLowerCase()))
          .map((e) => e.itemName)
          .toList();
    });
  }
}
