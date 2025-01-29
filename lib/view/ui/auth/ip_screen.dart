import 'package:cash_van_app/core/my_shared_preferences.dart';
import 'package:cash_van_app/core/text_style.dart';
import 'package:cash_van_app/view/widget/auth/custom_text_filed.dart';
import 'package:cash_van_app/view/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/route/routes.dart';
import '../../../core/validation.dart';

class IpScreen extends StatelessWidget {
  final bool? isLogin;

  IpScreen({super.key, this.isLogin = false});

  final TextEditingController ip =
      TextEditingController(text: mySharedPreferences.ip);
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Connect IP'.tr,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 100,
                ),
                Text(
                  'Connection IP'.tr,
                  style: AppTextStyles.regular20,
                ),
                const SizedBox(
                  height: 30,
                ),
                Form(
                  key: formKey,
                  child: CustomTextFiledWidget(
                    controller: ip,
                    label: 'ip',
                    hint: 'Enter IP',
                    prefixIcon: Icons.cell_tower,
                    validator: (value) => Validation.isRequired(value),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: double.infinity,
                  child: CustomButtonWidget(
                    title: 'Connect',
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        mySharedPreferences.ip = ip.text;
                        isLogin == false
                            ? Get.back()
                            : Get.offAllNamed(Routes.login);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
