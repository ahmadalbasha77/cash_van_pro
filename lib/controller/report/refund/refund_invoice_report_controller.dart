import 'package:cash_van_app/model/report/sales/sales_invoice_report_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utils.dart';
import '../../../network/rest_api.dart';

class RefundInvoiceReportController extends GetxController {
  static RefundInvoiceReportController get to =>
      Get.isRegistered<RefundInvoiceReportController>()
          ? Get.find<RefundInvoiceReportController>()
          : Get.put(RefundInvoiceReportController());

  final RestApi restApi = RestApi();

  List<SalesInvoiceReportModel> refundInvoiceReportList = [];

  final TextEditingController fromDateController = TextEditingController();
  final TextEditingController toDateController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey();
  bool isLoading = false;

  String customerId = '0';
  List<Map<String, dynamic>> formattedData = [];

  void updateFormattedData() {
    formattedData = refundInvoiceReportList.map((e) {
      return {
        '#': e.id,
        'Date': Utils.formatDate(e.invoiceDate),
        'Customer Name': e.sourceName,
        'Amount': e.totalAfterTax,
        'Payment Method': e.settelmentWay,
      };
    }).toList();
    update();
  }

  void getSalesInvoiceReport() async {
    isLoading = true;
    update();
    refundInvoiceReportList = await restApi.getRefundInvoiceReport(
        date1: fromDateController.text,
        date2: toDateController.text,
        customerId: customerId);

    if (refundInvoiceReportList.isNotEmpty) {
      updateFormattedData();
    }

    isLoading = false;
    update();
  }

  double getTotalAmount() {
    return refundInvoiceReportList.fold(
        0, (sum, invoice) => sum + invoice.totalAfterTax);
  }
}
