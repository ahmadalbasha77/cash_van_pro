import 'package:cash_van_app/model/invoice/category_model.dart';
import 'package:get/get.dart';

import '../../network/rest_api.dart';

class CategoryController extends GetxController {
  static CategoryController get to => Get.isRegistered<CategoryController>()
      ? Get.find<CategoryController>()
      : Get.put(CategoryController());
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
    update();
  }
}
