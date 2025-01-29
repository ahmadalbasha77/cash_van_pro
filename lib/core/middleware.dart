import 'package:cash_van_app/core/local_authentication_service.dart';
import 'package:cash_van_app/core/my_shared_preferences.dart';
import 'package:cash_van_app/core/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/route/routes.dart';

class AuthMiddleware extends GetMiddleware {
  final LocalAuthenticationService _authService = LocalAuthenticationService();

  @override
  RouteSettings? redirect(String? route) {
    Future.delayed(const Duration(seconds: 3), () async {
      if (mySharedPreferences.ip.isEmpty || mySharedPreferences.ip == '') {
        Get.offAllNamed(Routes.ip, arguments: true);
      } else if (mySharedPreferences.isLogin == true) {
        if (mySharedPreferences.fingerPrint == true) {
          Get.offAllNamed(Routes.login);
          bool isAuthenticated = await _authService.authenticate();
          if (isAuthenticated) {
            Utils.showLoadingDialog();
            Future.delayed(const Duration(seconds: 1), () async {
              Get.offAllNamed(Routes.customer);
            });
          }
        } else {
          Get.offAllNamed(Routes.customer);
        }
      } else {
        Get.offAllNamed(Routes.login);
      }
    });
    return null;
  }
}
