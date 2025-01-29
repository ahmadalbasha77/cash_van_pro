
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/app_color.dart';
import '../../../core/text_style.dart';

class ReportWidget extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final bool active;

  const ReportWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
    required this.active,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(icon, size: 40, color: Theme.of(context).primaryColor),
              const SizedBox(width: 16),
              Expanded(
                flex: 2,
                child: Text(
                  title.tr,
                  style: AppTextStyles.regular20,
                ),
              ),
              const Spacer(),
              Icon(
                active
                    ? Icons.arrow_drop_up_sharp
                    : Icons.arrow_drop_down_sharp,
                color: AppColor.primaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}