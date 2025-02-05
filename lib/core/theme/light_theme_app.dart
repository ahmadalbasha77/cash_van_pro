import 'package:cash_van_app/core/app_color.dart';
import 'package:flutter/material.dart';

ThemeData lightThemeApp(Color primaryColor) {
  return ThemeData(
    drawerTheme: const DrawerThemeData(
      backgroundColor: Colors.white,
    ),
    datePickerTheme: DatePickerThemeData(
      backgroundColor: Colors.white,
      headerBackgroundColor: AppColor.primaryColor,
      headerHeadlineStyle: const TextStyle(color: Colors.white, fontSize: 28),
      headerForegroundColor: Colors.white,
      rangeSelectionBackgroundColor: Colors.redAccent,
    ),
    colorScheme: ColorScheme.light(
      primary: AppColor.primaryColor,
      onPrimary: Colors.white,
    ),
    fontFamily: 'tejwal',
    cardTheme: const CardTheme(color: Colors.white),
    checkboxTheme: const CheckboxThemeData(
      checkColor: WidgetStatePropertyAll(Colors.white),
    ),
    dialogBackgroundColor: Colors.white,
    primaryColor: primaryColor,
    appBarTheme: AppBarTheme(
      titleTextStyle: const TextStyle(
          color: Colors.white, fontSize: 17, fontFamily: 'tejwal'),
      backgroundColor: primaryColor,
      iconTheme: const IconThemeData(color: Colors.white),
    ),
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: primaryColor,
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: primaryColor,
      selectionColor: primaryColor.withOpacity(0.2),
      selectionHandleColor: primaryColor,
    ),
    scaffoldBackgroundColor: Colors.white,
  );
}
