import 'package:cash_van_app/core/my_shared_preferences.dart';
import 'package:flutter/material.dart';

class AppColor {
  static Color get primaryColor => mySharedPreferences.colorApp;

  static void setPrimaryColor(Color color) {
    mySharedPreferences.colorApp = color;
  }
}
