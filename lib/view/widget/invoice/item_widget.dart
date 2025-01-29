import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/app_color.dart';
import '../../../core/text_style.dart';

class ItemWidget extends StatelessWidget {
  final String itemName;
  final String itemBarcode;
  final double salesPriceBeforeTax;
  final Widget iconButton;

  const ItemWidget(
      {super.key,
      required this.itemName,
      required this.itemBarcode,
      required this.salesPriceBeforeTax,
      required this.iconButton});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    itemName,
                    style: AppTextStyles.bold16,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '${'Barcode'.tr}: $itemBarcode',
                    style: AppTextStyles.regular12,
                  ),
                  const SizedBox(height: 5),
                  Text(
                      '${'Price'.tr}: ${salesPriceBeforeTax.toStringAsFixed(3)}',
                      style: AppTextStyles.bold14.copyWith(color: AppColor.primaryColor)),
                ],
              ),
            ),
            iconButton
          ],
        ),
      ),
    );
  }
}
