import 'package:cash_van_app/controller/voucher/add_cheques_controller.dart';
import 'package:cash_van_app/core/text_style.dart';
import 'package:cash_van_app/model/customers/customers_model.dart';
import 'package:cash_van_app/view/widget/auth/custom_text_filed.dart';
import 'package:cash_van_app/view/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/voucher/bank_controller.dart';
import '../../../core/app_color.dart';
import '../../../core/utils.dart';
import '../../../core/validation.dart';

class ChequeVoucherScreen extends StatelessWidget {
  final CustomersModel customer;

  ChequeVoucherScreen({super.key, required this.customer});

  final _controller = AddChequesController.to;
  final bankController = Get.find<BankController>();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) return;

        bool exit = await Utils.showAreYouSureDialog(
          title: 'Warning'.tr,
        );
        if (exit) {
          Get.back();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('${'Cheque Voucher'.tr} ${customer.aName}'.tr),
          backgroundColor: AppColor.primaryColor,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Beneficiary Name'.tr,
                    style: AppTextStyles.bold16,
                  ),
                  const SizedBox(height: 8),
                  CustomTextFiledWidget(
                      validator: (text) => Validation.isRequired(text),
                      controller: _controller.name,
                      label: 'enter beneficiary name'),
                  const SizedBox(height: 16),
                  Text(
                    'Cheque Amount'.tr,
                    style: AppTextStyles.bold16,
                  ),
                  const SizedBox(height: 8),
                  CustomTextFiledWidget(
                      validator: (text) => Validation.isRequired(text),
                      keyboardType: TextInputType.number,
                      controller: _controller.amount,
                      label: 'enter cheque amount'),
                  const SizedBox(height: 16),
                  Text(
                    'Cheque Number'.tr,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  CustomTextFiledWidget(
                      validator: (text) => Validation.isRequired(text),
                      keyboardType: TextInputType.number,
                      controller: _controller.chequesNumber,
                      label: 'enter cheque number'),
                  const SizedBox(height: 16),
                  Text(
                    'Bank Name'.tr,
                    style: AppTextStyles.bold16,
                  ),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    validator: (text) => Validation.isRequired(text),
                    decoration: InputDecoration(
                      labelText: 'Select bank'.tr,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    value: _controller.selectedBankId.value,
                    // استخدم القيمة المخزنة
                    items: bankController.banksList
                        .map((bank) => DropdownMenuItem(
                              value: bank.id.toString(),
                              child: Text(bank.aName),
                            ))
                        .toList(),
                    onChanged: (value) {
                      if (value != null) {
                        final selectedBank = bankController.banksList
                            .firstWhere((bank) => bank.id.toString() == value);
                        _controller.setSelectedBank(value, selectedBank.aName);
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Options :'.tr,
                          style: AppTextStyles.bold16,
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                GetBuilder<AddChequesController>(
                                  id: 'firstBeneficiary',
                                  builder: (logic) {
                                    return Checkbox(
                                      value: _controller.isFirstBeneficiary,
                                      onChanged: (value) {
                                        _controller
                                            .changeFirstBeneficiary(value!);
                                      },
                                    );
                                  },
                                ),
                                Text('First Beneficiary'.tr,
                                    textAlign: TextAlign.center),
                              ],
                            ),
                            Column(
                              children: [
                                GetBuilder<AddChequesController>(
                                  id: 'co',
                                  builder: (logic) {
                                    return Checkbox(
                                      value: _controller.isCO,
                                      onChanged: (value) {
                                        _controller.changesCO(value!);
                                      },
                                    );
                                  },
                                ),
                                const Text('CO', textAlign: TextAlign.center),
                              ],
                            ),
                            Column(
                              children: [
                                GetBuilder<AddChequesController>(
                                  id: 'commitDate',
                                  builder: (logic) {
                                    return Checkbox(
                                      value: _controller.isCommitDate,
                                      onChanged: (value) {
                                        _controller.changeCommitDate(value!);
                                      },
                                    );
                                  },
                                ),
                                Text('Commit Date'.tr,
                                    textAlign: TextAlign.center),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: CustomButtonWidget(
                      vertical: 15,
                      title: 'Save',
                      onPressed: () {
                        _controller.addChequesVoucher(customer.id);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
