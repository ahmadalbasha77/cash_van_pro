import 'package:cash_van_app/core/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/app_color.dart';

class CustomButtonWidget extends StatelessWidget {
  final String title;
  final void Function() onPressed;
  final double? vertical;
  final double? horizontal;
  final Color? backgroundColor;
  final Color? fontColor;
  final TextStyle? textStyle;

  const CustomButtonWidget(
      {super.key,
      required this.title,
      required this.onPressed,
      this.vertical,
      this.backgroundColor,
      this.horizontal,
      this.fontColor,
      this.textStyle});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: backgroundColor ?? AppColor.primaryColor,
        padding: EdgeInsets.symmetric(
            vertical: vertical ?? 20, horizontal: horizontal ?? 10),
      ),
      onPressed: onPressed,
      child: Text(title.tr,
          style: textStyle ??
              AppTextStyles.semiBold18.copyWith(color: fontColor ?? Colors.white)),
    );
  }
}
