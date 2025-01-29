import 'package:cash_van_app/core/my_shared_preferences.dart';
import 'package:cash_van_app/view/ui/auth/login_screen.dart';
import 'package:cash_van_app/view/ui/home/customers_screen.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class InternetConnectionController extends GetxController {
  static InternetConnectionController get to =>
      Get.isRegistered<InternetConnectionController>()
          ? Get.find<InternetConnectionController>()
          : Get.put(InternetConnectionController());

  bool isLoading = false;

  void checkInternetConnection() async {
    isLoading = true;
    update();
    final bool isConnected =
        await InternetConnectionChecker.instance.hasConnection;
    if (isConnected) {
      isLoading = false;
      update();
      mySharedPreferences.isLogin
          ? Get.offAll(() => CustomersScreen())
          : Get.offAll(() =>  LoginScreen());
    } else {
      isLoading = false;
      update();
    }
  }
}
