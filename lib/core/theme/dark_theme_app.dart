import 'package:flutter/material.dart';


ThemeData darkThemeApp(Color primaryColor) {
  return ThemeData.dark().copyWith(


    drawerTheme: const DrawerThemeData(
      backgroundColor: Colors.black,
    ),
    dialogBackgroundColor: Colors.black,
    primaryColor: primaryColor,
    appBarTheme: AppBarTheme(
      titleTextStyle: const TextStyle(color: Colors.black, fontSize: 17),
      backgroundColor: primaryColor,
      iconTheme: const IconThemeData(color: Colors.black),
    ),
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: primaryColor,
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: primaryColor,
      selectionColor: primaryColor.withOpacity(0.2),
      selectionHandleColor: primaryColor,
    ),
    scaffoldBackgroundColor: Colors.black,
  );
}
