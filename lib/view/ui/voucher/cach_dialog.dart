import 'package:cash_van_app/core/text_style.dart';
import 'package:cash_van_app/core/validation.dart';
import 'package:cash_van_app/model/customers/customers_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/voucher/add_cash_controller.dart';
import '../../../core/app_color.dart';
import '../../widget/auth/custom_text_filed.dart';
import '../../widget/custom_button.dart';

class CashDialog extends StatelessWidget {
  final CustomersModel customer;

  CashDialog({super.key, required this.customer});

  final controller = AddCashController.to;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
        child: Form(
          key: controller.formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                textAlign: TextAlign.center,
                '${'Cash Voucher for'.tr} ${customer.aName}'.tr,
                style: AppTextStyles.bold18,
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextFiledWidget(
                  controller: controller.name,
                  validator: (text) => Validation.isRequired(text),
                  label: 'Name Receiver'.tr,
                  hint: 'Enter name receiver'.tr),
              const SizedBox(
                height: 20,
              ),
              CustomTextFiledWidget(
                  keyboardType: TextInputType.number,
                  controller: controller.amount,
                  validator: (text) => Validation.isRequired(text),
                  label: 'Amount',
                  hint: 'Enter amount'),
              const SizedBox(
                height: 20,
              ),
              CustomTextFiledWidget(
                  // keyboardType: TextInputType.text,
                  controller: controller.note,
                  // validator: (text) => Validation.isRequired(text),
                  label: 'Note (optional)',
                  hint: 'Enter Note'),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
                child: Row(
                  children: [
                    CustomButtonWidget(
                      vertical: 8,
                      title: 'confirm',
                      onPressed: () {
                        controller.addCashVoucher(customer.id, customer.aName);
                      },
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
