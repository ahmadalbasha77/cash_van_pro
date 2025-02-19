import 'package:cash_van_app/model/report/sales/sales_invoice_report_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utils.dart';
import '../../../model/report/customer/account_statement_model.dart';
import '../../../network/rest_api.dart';

class AccountStatementReportController extends GetxController {
  static AccountStatementReportController get to =>
      Get.isRegistered<AccountStatementReportController>()
          ? Get.find<AccountStatementReportController>()
          : Get.put(AccountStatementReportController());

  final RestApi restApi = RestApi();

  AccountStatementModel? accountStatementData;

  final TextEditingController fromDateController = TextEditingController();
  final TextEditingController toDateController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey();
  bool isLoading = false;

  String customerId = '0';
  List<Map<String, dynamic>> formattedData = [];

  void updateFormattedData() {
    formattedData = accountStatementData!.data.map((e) {
      return {
        'Date': Utils.formatDate(e.voucherDate),
        'type': e.voucherTypeEName,
        'note': e.notes,
        'debit': e.debit,
        'credit': e.credit,
        'Amount': e.periodBalance,

      };
    }).toList();
    update();
  }

  void getAccountStatementReport() async {
    isLoading = true;
    update();
    accountStatementData = await restApi.getAccountStatementReport(
        date1: fromDateController.text,
        date2: toDateController.text,
        customerId: customerId);

    if (accountStatementData!.data.isNotEmpty) {
      updateFormattedData();
    }

    isLoading = false;
    update();
  }
}
