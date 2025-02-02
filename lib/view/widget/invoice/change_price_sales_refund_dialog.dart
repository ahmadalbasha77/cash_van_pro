import 'package:cash_van_app/core/text_style.dart';
import 'package:cash_van_app/core/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/invoice/sales_and_refund_controller.dart';
import '../../../core/app_color.dart';
import '../../widget/auth/custom_text_filed.dart';
import '../../widget/custom_button.dart';

class ChangePriceSalesRefundDialog extends StatelessWidget {
  final void Function() onConfirm;

  ChangePriceSalesRefundDialog({
    super.key,
    required this.onConfirm,
  });

  final _controller = Get.find<SalesAndRefundController>();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
        child: Form(
          key: _controller.priceKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                textAlign: TextAlign.center,
                'Change Price'.tr,
                style: AppTextStyles.bold18,
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextFiledWidget(
                  keyboardType: TextInputType.number,
                  controller: _controller.newPriceController,
                  validator: (text) => Validation.isRequired(text),
                  label: 'New Price'.tr,
                  hint: 'Enter new price'.tr),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
                child: Row(
                  children: [
                    CustomButtonWidget(
                      vertical: 8,
                      title: 'confirm',
                      onPressed: onConfirm,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    CustomButtonWidget(
                      backgroundColor: Colors.grey[50],
                      fontColor: AppColor.primaryColor,
                      vertical: 8,
                      title: 'cancel',
                      onPressed: () {
                        Get.back();
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
