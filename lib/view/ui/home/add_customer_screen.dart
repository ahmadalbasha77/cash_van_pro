import 'package:cash_van_app/controller/customers/add_customer_controller.dart';
import 'package:cash_van_app/core/app_color.dart';
import 'package:cash_van_app/core/text_style.dart';
import 'package:cash_van_app/core/validation.dart';
import 'package:cash_van_app/view/widget/auth/custom_text_filed.dart';
import 'package:cash_van_app/view/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddCustomerScreen extends StatelessWidget {
  AddCustomerScreen({super.key});

  final _controller = AddCustomerController.to;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Customer'.tr),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Form(
          key: _controller.formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20.0),
                Center(
                  child: Text('Add a New Customer'.tr,
                      style: AppTextStyles.bold20.copyWith(color: AppColor.primaryColor)),
                ),
                const SizedBox(height: 20.0),
                CustomTextFiledWidget(
                    validator: (text) => Validation.isRequired(text),
                    controller: _controller.name,
                    label: 'Name',
                    hint: 'enter name'),
                const SizedBox(height: 16.0),
                CustomTextFiledWidget(
                    validator: (text) => Validation.isPhone(text),
                    keyboardType: TextInputType.phone,
                    controller: _controller.phone,
                    label: 'Phone Number',
                    hint: 'enter phone number'),
                const SizedBox(height: 24.0),
                CustomButtonWidget(
                  vertical: 10,
                  title: 'submit',
                  onPressed: () {
                    _controller.addCustomer();
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
