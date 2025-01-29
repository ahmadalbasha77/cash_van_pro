import 'package:cash_van_app/core/my_shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:printing/printing.dart';

import '../../core/utils.dart';
import '../../network/rest_api.dart';
import '../../view/ui/voucher/cash_voucher_pdf.dart';
import '../customers/customers_controller.dart';

class AddCashController extends GetxController {
  static AddCashController get to => Get.isRegistered<AddCashController>()
      ? Get.find<AddCashController>()
      : Get.put(AddCashController());

  final RestApi restApi = RestApi();
  final TextEditingController name = TextEditingController();
  final TextEditingController amount = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();

  void addCashVoucher(int customerId, String customerName) async {
    if (formKey.currentState!.validate()) {
      Get.back();
      Utils.showLoadingDialog();

      bool result = await restApi.addCashVoucher({
        // "ID": 0,
        "VoucherDate": DateTime.now().toIso8601String(),
        "BranchID": ' ${mySharedPreferences.getUserData()!.branchId}',
        "Amount": amount.text,
        "UserID": ' ${mySharedPreferences.getUserData()!.id}',
        "ReceiverName": name.text,
        "CashID": ' ${mySharedPreferences.getUserData()!.cashId}',
        "CustomerID": '$customerId'
      });
      if (result == true) {
        final invoicePdf = await cashVoucherPdf(
          customerName: customerName,
          recipientName: name.text,
          amount: double.parse(amount.text),
        );

        await Printing.layoutPdf(
          onLayout: (format) => invoicePdf.save(),
        );

        final controller = Get.find<CustomersController>();

        controller.getCustomers();

        Utils.showSnackbar('Success', 'Cash Voucher added successfully ');
      } else {
        Utils.showSnackbar(
            'Failed', 'An error occurred while adding the Cash.');
      }
    }
  }
}
