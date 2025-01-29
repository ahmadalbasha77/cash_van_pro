
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/my_shared_preferences.dart';
import '../../../core/text_style.dart';

class DrawerWidget extends StatelessWidget {
  final String title;
  final IconData iconData;
  final void Function() onTap;

  const DrawerWidget(
      {super.key,
        required this.title,
        required this.iconData,
        required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
        contentPadding: EdgeInsets.zero,
        leading: Icon(iconData, size: 25 * mySharedPreferences.fontSize),
        title: Text(
          title.tr,
          style: AppTextStyles.regular14,
        ),
        onTap: onTap);
  }
}