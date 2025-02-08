import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utils.dart';
import '../../../model/report/voucher/cheque_voucher_report_model.dart';
import '../../../network/rest_api.dart';

class ChequeVoucherReportController extends GetxController {
  static ChequeVoucherReportController get to =>
      Get.isRegistered<ChequeVoucherReportController>()
          ? Get.find<ChequeVoucherReportController>()
          : Get.put(ChequeVoucherReportController());

  final RestApi restApi = RestApi();

  List<ChequeVoucherReportModel> chequeVoucherReportList = [];

  final TextEditingController fromDateController = TextEditingController();
  final TextEditingController toDateController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey();
  bool isLoading = false;

  String customerId = '0';
  List<Map<String, dynamic>> formattedData = [];

  void updateFormattedData() {
    formattedData = chequeVoucherReportList.map((e) {
      return {
        '#': e.id,
        'Date': Utils.formatDate(e.paymentDate!),
        'Customer Name': e.beneficiaryName,
        'Amount': e.amount,
        'Received': e.beneficiaryName,
        'Cheque Num': e.chequesNumber,
        'Bank': e.bankName,
        'Co': false,
        'First Beneficiary': false,
        'Commit Date': true,
      };
    }).toList();
  }

  void getChequeVoucherReport() async {
    isLoading = true;
    update();
    chequeVoucherReportList = await restApi.getChequeVoucherReport(
        date1: fromDateController.text,
        date2: toDateController.text,
        customerId: customerId);
    if (chequeVoucherReportList.isNotEmpty) {
      updateFormattedData();
    }
    isLoading = false;
    update();
  }
}
