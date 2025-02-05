import 'package:cash_van_app/view/ui/home/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/app_color.dart';
import '../auth/custom_text_filed.dart';
import '../custom_button.dart';

class PinSettingsDialog extends StatelessWidget {
  PinSettingsDialog({super.key});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController pinController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Pin'.tr,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            Form(
              key: formKey,
              child: CustomTextFiledWidget(
                  controller: pinController,
                  obscureText: true,
                  validator: (p0) {
                    if (p0!.isEmpty) {
                      return 'Enter Pin'.tr;
                    } else if (p0 != '12345') {
                      return 'Wrong Pin';
                    }
                    return null;
                  },
                  label: 'Pin',
                  hint: 'Enter Pin'),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
              child: Row(
                children: [
                  CustomButtonWidget(
                    vertical: 8,
                    title: 'confirm',
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        Get.off(() => SettingsScreen());
                      }
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
    );
  }
}
