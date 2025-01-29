import 'dart:developer';

import 'package:cash_van_app/controller/voucher/bank_controller.dart';
import 'package:cash_van_app/core/my_shared_preferences.dart';
import 'package:cash_van_app/model/auth/login_model.dart';
import 'package:cash_van_app/network/rest_api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/route/routes.dart';
import '../../core/utils.dart';
import '../../model/api_response.dart';

class LoginController extends GetxController {
  static LoginController get to => Get.isRegistered<LoginController>()
      ? Get.find<LoginController>()
      : Get.put(LoginController());

  final RestApi restApi = RestApi();
  final TextEditingController usernameController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey();

  bool obscureText = true;

  bool isLogin = false;

  void changeObscureText() {
    obscureText = !obscureText;
    update();
  }

  void checkLogin(bool value) async {
    isLogin = value;
    update();
  }

  void login() async {
    if (formKey.currentState!.validate()) {
      Utils.showLoadingDialog('Logging in...');
      ApiResponse<List<LoginModel>> result = await restApi.login({
        "UserName": usernameController.text,
        "Password": passwordController.text,
      });

      if (result.isSuccess && result.data != null && result.data!.isNotEmpty) {
        Utils.showLoadingDialog();
        log('$isLogin');
        mySharedPreferences.isLogin = isLogin;
        mySharedPreferences.saveUserData(result.data![0]);
        Get.offAllNamed(Routes.customer);
        final controller = Get.find<BankController>();
        controller.getBank();
      } else {
        Utils.showSnackbar(
            'Login Failed', result.error ?? 'Invalid username or password');
      }
    }
  }
}
