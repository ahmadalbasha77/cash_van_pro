import 'package:cash_van_app/core/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:printing/printing.dart';

import '../../core/my_shared_preferences.dart';
import '../../network/rest_api.dart';
import '../../view/ui/voucher/cheque_voucher_pdf.dart';
import '../customers/customers_controller.dart';

class AddChequesController extends GetxController {
  static AddChequesController get to => Get.isRegistered<AddChequesController>()
      ? Get.find<AddChequesController>()
      : Get.put(AddChequesController());

  final RestApi restApi = RestApi();
  final TextEditingController name = TextEditingController();
  final TextEditingController amount = TextEditingController();
  final TextEditingController chequesNumber = TextEditingController();

  var selectedBankId = Rxn<String>();
  var selectedBankName = Rxn<String>();

  void setSelectedBank(String id, String name) {
    selectedBankId.value = id;
    selectedBankName.value = name;
  }

  final GlobalKey<FormState> formKey = GlobalKey();

  bool isFirstBeneficiary = false;
  bool isCO = false;
  bool isCommitDate = false;

  void changesCO(bool value) {
    isCO = value;
    update(['co']);
  }

  void changeFirstBeneficiary(bool value) {
    isFirstBeneficiary = value;
    update(['firstBeneficiary']);
  }

  void changeCommitDate(bool value) {
    isCommitDate = value;
    update(['commitDate']);
  }

  void addChequesVoucher(int customerId) async {
    if (formKey.currentState!.validate()) {
      Utils.showLoadingDialog();

      bool result = await restApi.addChequesVoucher({
        // "ID": 0,
        "BranchID": '${mySharedPreferences.getUserData()!.branchId}',
        "IsFirstBeneficiary": '$isFirstBeneficiary',
        "IsCO": '$isCO',
        "IsCommitDate": '$isCommitDate',
        "Amount": amount.text,
        "BeneficiaryName": name.text,
        "BankID": '${selectedBankId.value}',
        "ChequesNumber": chequesNumber.text,
        "AccountID": '0',
        "CustomerID": '$customerId',
        "UserID": '${mySharedPreferences.getUserData()!.id}'
      });
      if (result == true) {
        final invoicePdf = await chequeVoucherPdf(
            date: Utils.formatDate(DateTime.now()),
            bankName: selectedBankName.value!,
            chequeNumber: chequesNumber.text,
            beneficiaryName: name.text,
            chequeAmount: double.parse(amount.text),
            isCO: isCO,
            isCommitDate: isCommitDate,
            isFirstBeneficiary: isFirstBeneficiary);

        await Printing.layoutPdf(
          onLayout: (format) => invoicePdf.save(),
        );

        final controller = CustomersController.to;

        controller.getCustomers();

        Utils.hideLoadingDialog();
        Get.back();
        Utils.showSnackbar('Success', 'Cheques Voucher added successfully');
      } else {
        Utils.showSnackbar(
            'Failed', 'An error occurred while adding the Voucher.');
      }
    }
  }
}
