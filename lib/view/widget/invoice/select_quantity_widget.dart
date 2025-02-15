import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../controller/invoice/select_quantity_controller.dart';
import '../../../core/app_color.dart';
import '../../../core/text_style.dart';
import '../custom_button.dart';

class SelectQuantityWidget extends StatelessWidget {
  const SelectQuantityWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SelectQuantityController());

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Select Quantity'.tr,
              textAlign: TextAlign.center,
              style: AppTextStyles.bold18,
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: controller.decrease,
                  icon: const Icon(Icons.remove, size: 40),
                ),
                const SizedBox(width: 20),
                SizedBox(
                  width: 60,
                  child: TextField(
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    controller: controller.textController,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    style: AppTextStyles.bold30,
                  ),
                ),
                const SizedBox(width: 20),
                IconButton(
                  onPressed: controller.increase,
                  icon: const Icon(Icons.add, size: 40),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: CustomButtonWidget(
                      vertical: 8,
                      title: 'confirm',
                      onPressed: () {
                        Get.back(result: controller.quantity.value);
                      },
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: CustomButtonWidget(
                      backgroundColor: Colors.grey[50],
                      fontColor: AppColor.primaryColor,
                      vertical: 8,
                      title: 'cancel',
                      onPressed: () {
                        Get.back();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
