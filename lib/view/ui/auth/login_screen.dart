import 'package:cash_van_app/core/app_color.dart';
import 'package:cash_van_app/core/utils.dart';
import 'package:cash_van_app/core/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/auth/login_controller.dart';
import '../../widget/auth/custom_text_filed.dart';
import '../../widget/auth/pin_dialog.dart';
import '../../widget/custom_button.dart';
import '../../widget/custom_icon_button.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final controller = LoginController.to;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: SafeArea(
          child: Form(
            key: controller.formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomIconButton(
                        icon: Icons.language,
                        onPressed: () {
                          Utils.changeLanguage();
                        },
                      ),
                      CustomIconButton(
                        icon: Icons.cell_tower,
                        onPressed: () {
                          Get.dialog(PinDialog());
                        },
                      ),
                    ],
                  ),
                  Image.asset(
                    'assets/images/logo2.png',
                    color: AppColor.primaryColor,
                    // width: 230,
                    width: MediaQuery.sizeOf(context).width * 0.45,
                  ),
                  Text(
                    'Login'.tr,
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 60),
                  CustomTextFiledWidget(
                      prefixIcon: Icons.person,
                      validator: (text) => Validation.isRequired(text),
                      controller: controller.usernameController,
                      label: 'Username',
                      hint: 'Enter Username'),
                  const SizedBox(height: 20),
                  GetBuilder<LoginController>(builder: (logic) {
                    return CustomTextFiledWidget(
                        obscureText: controller.obscureText,
                        suffixIcon: CustomIconButton(
                          color: controller.obscureText
                              ? Colors.black54
                              : AppColor.primaryColor,
                          size: 25,
                          icon: Icons.remove_red_eye_outlined,
                          onPressed: controller.changeObscureText,
                        ),
                        prefixIcon: Icons.lock,
                        validator: (text) => Validation.isRequired(text),
                        controller: controller.passwordController,
                        label: 'Password',
                        hint: 'Enter Password');
                  }),
                  Row(
                    children: [
                      GetBuilder<LoginController>(builder: (logic) {
                        return Checkbox(
                          activeColor: AppColor.primaryColor,
                          value: controller.isLogin,
                          onChanged: (value) {
                            controller.checkLogin(value!);
                          },
                        );
                      }),
                      Text('Keep me logged in'.tr),
                    ],
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                      width: double.infinity,
                      child: CustomButtonWidget(
                        title: 'Login',
                        onPressed: () {
                          controller.login();
                        },
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
