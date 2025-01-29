import 'package:cash_van_app/core/my_shared_preferences.dart';
import 'package:flutter/material.dart';

class AppTextStyles {
  // الحصول على حجم الخط من SharedPreferences
  static double get fontSize => mySharedPreferences.fontSize;

  /// دالة عامة لإنشاء `TextStyle` بناءً على الحجم والوزن.
  static TextStyle getTextStyle({
    required double size,
    FontWeight weight = FontWeight.w400, // القيمة الافتراضية هي Regular
  }) {
    return TextStyle(
      fontSize: size * fontSize,
      fontWeight: weight,
      height: 1.5,
      fontFamily: 'tejwal', // اسم الخط
    );
  }

  // الأنماط Bold
  static TextStyle get bold48 => getTextStyle(size: 48, weight: FontWeight.w700);
  static TextStyle get bold40 => getTextStyle(size: 40, weight: FontWeight.w700);
  static TextStyle get bold32 => getTextStyle(size: 32, weight: FontWeight.w700);
  static TextStyle get bold30 => getTextStyle(size: 30, weight: FontWeight.w700);
  static TextStyle get bold28 => getTextStyle(size: 28, weight: FontWeight.w700);
  static TextStyle get bold24 => getTextStyle(size: 24, weight: FontWeight.w700);
  static TextStyle get bold22 => getTextStyle(size: 22, weight: FontWeight.w700);
  static TextStyle get bold20 => getTextStyle(size: 20, weight: FontWeight.w700);
  static TextStyle get bold18 => getTextStyle(size: 18, weight: FontWeight.w700);
  static TextStyle get bold16 => getTextStyle(size: 16, weight: FontWeight.w700);
  static TextStyle get bold14 => getTextStyle(size: 14, weight: FontWeight.w700);
  static TextStyle get bold12 => getTextStyle(size: 12, weight: FontWeight.w700);

  // الأنماط SemiBold
  static TextStyle get semiBold48 =>
      getTextStyle(size: 48, weight: FontWeight.w600);
  static TextStyle get semiBold40 =>
      getTextStyle(size: 40, weight: FontWeight.w600);
  static TextStyle get semiBold32 =>
      getTextStyle(size: 32, weight: FontWeight.w600);
  static TextStyle get semiBold30 =>
      getTextStyle(size: 30, weight: FontWeight.w600);
  static TextStyle get semiBold24 =>
      getTextStyle(size: 24, weight: FontWeight.w600);
  static TextStyle get semiBold22 =>
      getTextStyle(size: 22, weight: FontWeight.w600);
  static TextStyle get semiBold20 =>
      getTextStyle(size: 20, weight: FontWeight.w600);
  static TextStyle get semiBold18 =>
      getTextStyle(size: 18, weight: FontWeight.w600);
  static TextStyle get semiBold16 =>
      getTextStyle(size: 16, weight: FontWeight.w600);
  static TextStyle get semiBold14 =>
      getTextStyle(size: 14, weight: FontWeight.w600);
  static TextStyle get semiBold12 =>
      getTextStyle(size: 12, weight: FontWeight.w600);

  // الأنماط Medium
  static TextStyle get medium48 =>
      getTextStyle(size: 48, weight: FontWeight.w500);
  static TextStyle get medium40 =>
      getTextStyle(size: 40, weight: FontWeight.w500);
  static TextStyle get medium32 =>
      getTextStyle(size: 32, weight: FontWeight.w500);
  static TextStyle get medium24 =>
      getTextStyle(size: 24, weight: FontWeight.w500);
  static TextStyle get medium20 =>
      getTextStyle(size: 20, weight: FontWeight.w500);
  static TextStyle get medium16 =>
      getTextStyle(size: 16, weight: FontWeight.w500);
  static TextStyle get medium14 =>
      getTextStyle(size: 14, weight: FontWeight.w500);
  static TextStyle get medium12 =>
      getTextStyle(size: 12, weight: FontWeight.w500);

  // الأنماط Regular
  static TextStyle get regular32 =>
      getTextStyle(size: 32, weight: FontWeight.w400);
  static TextStyle get regular24 =>
      getTextStyle(size: 24, weight: FontWeight.w400);
  static TextStyle get regular20 =>
      getTextStyle(size: 20, weight: FontWeight.w400);
  static TextStyle get regular18 =>
      getTextStyle(size: 18, weight: FontWeight.w400);
  static TextStyle get regular16 =>
      getTextStyle(size: 16, weight: FontWeight.w400);
  static TextStyle get regular14 =>
      getTextStyle(size: 14, weight: FontWeight.w400);
  static TextStyle get regular12 =>
      getTextStyle(size: 12, weight: FontWeight.w400);
  static TextStyle get regular10 =>
      getTextStyle(size: 10, weight: FontWeight.w400);
}
