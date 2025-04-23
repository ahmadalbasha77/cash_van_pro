import 'package:cash_van_app/model/invoice/category_model.dart';
import 'package:get/get.dart';

import '../../network/rest_api.dart';
import 'item_by_categoryid_proposal_controller.dart';

class CategoryProposalController extends GetxController {
  static CategoryProposalController get to =>
      Get.isRegistered<CategoryProposalController>()
          ? Get.find<CategoryProposalController>()
          : Get.put(CategoryProposalController());
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
    final controller = ItemByCategoryIdProposalController.to;
    if (categoryList.isNotEmpty) {
      controller.categoryId = categoryList.first.id;
      controller.getItem();
    }
    update();
  }
}
