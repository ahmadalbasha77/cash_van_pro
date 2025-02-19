import 'package:cash_van_app/model/invoice/category_model.dart';
import 'package:get/get.dart';

import '../../network/rest_api.dart';
import 'item_by_category_id_quotation_controller.dart';

class CategoryQuotationController extends GetxController {
  static CategoryQuotationController get to =>
      Get.isRegistered<CategoryQuotationController>()
          ? Get.find<CategoryQuotationController>()
          : Get.put(CategoryQuotationController());
  final RestApi restApi = RestApi();

  List<CategoryModel> categoryList = [];
  bool isLoading = false;

  @override
  void onInit() {
    getCategory();
    super.onInit();
  }

  void getCategory() async {
    isLoading = true;
    update();
    categoryList = await restApi.getCategory();
    isLoading = false;
    final controller = ItemByCategoryIdQuotationController.to;
    if (categoryList.isNotEmpty) {
      controller.categoryId = categoryList.first.id;
      controller.getItem();
    }
    update();
  }
}
