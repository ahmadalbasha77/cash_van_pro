import 'package:cash_van_app/model/report/sales/sales_invoice_report_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utils.dart';
import '../../../network/rest_api.dart';

class SalesInvoiceReportController extends GetxController {
  static SalesInvoiceReportController get to =>
      Get.isRegistered<SalesInvoiceReportController>()
          ? Get.find<SalesInvoiceReportController>()
          : Get.put(SalesInvoiceReportController());

  final RestApi restApi = RestApi();

  List<SalesInvoiceReportModel> salesInvoiceReportList = [];
  final TextEditingController fromDateController = TextEditingController();
  final TextEditingController toDateController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey();
  bool isLoading = false;

  String customerId = '0';
  List<Map<String, dynamic>> formattedData = [];

  void updateFormattedData() {
    formattedData = salesInvoiceReportList.map((e) {
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
    salesInvoiceReportList = await restApi.getSalesInvoiceReport(
        date1: fromDateController.text,
        date2: toDateController.text,
        customerId: customerId);

    if (salesInvoiceReportList.isNotEmpty) {
      updateFormattedData();
    }

    isLoading = false;
    update();
  }

  double getTotalAmount() {
    return salesInvoiceReportList.fold(
        0, (sum, invoice) => sum + invoice.totalAfterTax);
  }
}
