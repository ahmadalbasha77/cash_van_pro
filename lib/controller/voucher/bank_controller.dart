import 'package:cash_van_app/model/bank_model.dart';
import 'package:get/get.dart';

import '../../network/rest_api.dart';

class BankController extends GetxController {
  static BankController get to => Get.isRegistered<BankController>()
      ? Get.find<BankController>()
      : Get.put(BankController());
  final RestApi restApi = RestApi();

  List<BankModel> banksList = [];

  bool isLoading = false;

  @override
  void onInit() {
    getBank();
    super.onInit();
  }

  void getBank() async {
    isLoading = true;
    update();
    banksList = await restApi.getBank();
    isLoading = false;
    update();
  }
}
