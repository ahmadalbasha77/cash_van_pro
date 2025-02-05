import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';
import 'package:cash_van_app/core/my_shared_preferences.dart';
import 'package:cash_van_app/core/theme/light_theme_app.dart';

import '../core/route/routes.dart';

class SettingsController extends GetxController {
  Color appColor = mySharedPreferences.colorApp;
  double fontSize = mySharedPreferences.fontSize;
  bool isFingerprintActive = mySharedPreferences.fingerPrint;
  bool isWholesalePrice = mySharedPreferences.wholesalePrice;
  ThemeMode themeMode = ThemeMode.system;
  Color selectedColor = mySharedPreferences.colorApp;

  void updateAppColor(Color color) {
    appColor = color;
    mySharedPreferences.colorApp = color;
    Get.changeTheme(lightThemeApp(color));
    Get.offAllNamed(Routes.initial);
    update(['theme']);
  }

  void updateFontSize(double size) {
    fontSize = size;

    log('fontSize: $fontSize');
    log('fontSize: ${mySharedPreferences.fontSize}');

    update(['font']);
  }

  void saveFontSize() {
    mySharedPreferences.fontSize = fontSize;
    Get.offAllNamed(Routes.initial);
    // Get.offAll(() => const SplashScreen());
    update(['font']);
  }

  void toggleFingerprint(bool value) {
    isFingerprintActive = value;
    mySharedPreferences.fingerPrint = value;
    update(['fingerprint']);
  }

  void toggleWholesalePrice(bool value) {
    isWholesalePrice = value;
    mySharedPreferences.wholesalePrice = value;
    update(['wholesalePrice']);
  }

  void updateThemeMode(ThemeMode mode) {
    themeMode = mode;
    update();
  }

  void pickColor() async {
    await Get.dialog(AlertDialog(
      title: const Text('Select Color'),
      content: SingleChildScrollView(
        child: ColorPicker(
          portraitOnly: false,
          displayThumbColor: false,
          enableAlpha: false,
          hexInputBar: false,
          pickerColor: appColor,
          onColorChanged: (color) {
            selectedColor = color;
          },
          // showLabel: false,
          pickerAreaHeightPercent: 0.8,
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('OK'),
          onPressed: () {
            updateAppColor(selectedColor);
            Get.back();
          },
        ),
      ],
    ));
  }
}
