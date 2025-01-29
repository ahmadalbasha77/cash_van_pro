import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/app_color.dart';

class PayWidget extends StatelessWidget {
  final String title;
  final void Function() onTap;
  final int isSelected;
  final int type;

  const PayWidget(
      {super.key,
      required this.title,
      required this.onTap,
      required this.isSelected,
      required this.type});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          border: Border.all(
            width: isSelected == type ? 1.7 : 1,
            color: isSelected == type ? AppColor.primaryColor : Colors.grey,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(title.tr),
      ),
    );
  }
}
