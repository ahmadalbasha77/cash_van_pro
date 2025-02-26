
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
  bool priceQuotation = mySharedPreferences.showPriceInQuotation;
  ThemeMode themeMode = ThemeMode.system;
  Color selectedColor = mySharedPreferences.colorApp;

  // void updateAppColor(Color color) {
  //   if (appColor != color) {
  //     appColor = color;
  //     mySharedPreferences.colorApp = color;
  //     Get.changeTheme(lightThemeApp(color));
  //     update(['theme']);
  //   }
  // }
  void updateAppColor(Color color) {
    appColor = color;
    mySharedPreferences.colorApp = color;
    Get.changeTheme(lightThemeApp(color));
    Get.offAllNamed(Routes.initial);
    update(['theme']);
  }

  void updateFontSize(double size) {
    if (fontSize != size) {
      fontSize = size;
      update(['font']);
    }
  }

  void saveFontSize() {
    mySharedPreferences.fontSize = fontSize;
    Get.offAllNamed(Routes.initial);
    update(['font']);
  }

  void toggleFingerprint(bool value) {
    if (isFingerprintActive != value) {
      isFingerprintActive = value;
      mySharedPreferences.fingerPrint = value;
      update(['fingerprint']);
    }
  }

  void toggleWholesalePrice(bool value) {
    if (isWholesalePrice != value) {
      isWholesalePrice = value;
      mySharedPreferences.wholesalePrice = value;
      update(['wholesalePrice']);
    }
  }

  void togglePriceQuotation(bool value) {
    if (priceQuotation != value) {
      priceQuotation = value;
      mySharedPreferences.showPriceInQuotation = value;
      update(['priceQuotation']);
    }
  }


  void pickColor() async {
    await Get.dialog(AlertDialog(
      title: const Text('Select Color'),
      content: SingleChildScrollView(
        child: ColorPicker(
          pickerColor: appColor,
          onColorChanged: (color) => selectedColor = color,
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
