import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/app_color.dart';

class SearchTextFiledWidget extends StatelessWidget {
  final String hintText;
  final void Function(String) onChanged;
  final Color? backgroundColor;
  final TextEditingController? controller;

  const SearchTextFiledWidget(
      {super.key,
      required this.hintText,
      required this.onChanged,
      this.backgroundColor,
      this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      color: backgroundColor ?? Colors.white,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: TextFormField(
          controller: controller,
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: hintText.tr,
            prefixIcon: Icon(Icons.search, color: AppColor.primaryColor),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(vertical: 14),
          ),
        ),
      ),
    );
  }
}
