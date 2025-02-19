import 'package:cash_van_app/core/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../network/rest_api.dart';
import '../../model/quotation/quotation_history_model.dart';

class QuotationHistoryController extends GetxController {
  static QuotationHistoryController get to =>
      Get.isRegistered<QuotationHistoryController>()
          ? Get.find<QuotationHistoryController>()
          : Get.put(QuotationHistoryController());

  final RestApi restApi = RestApi();
  String customerId = '0';

  @override
  void onInit() {
    customerId = Get.arguments['id'] ?? '0';
    getQuotation();
    super.onInit();
  }

  List<QuotationHistoryModel> quotationHistoryList = [];
  final TextEditingController fromDateController = TextEditingController(
      text: Utils.formatDate(DateTime.now().subtract(const Duration(days: 1))));
  final TextEditingController toDateController =
      TextEditingController(text: Utils.formatDate(DateTime.now()));

  final GlobalKey<FormState> formKey = GlobalKey();
  bool isLoading = false;

  void getQuotation() async {
    isLoading = true;
    update();
    quotationHistoryList = await restApi.getQuotation(
        dateFrom: fromDateController.text,
        dateTo: toDateController.text,
        customerId: customerId);

    isLoading = false;
    update();
  }
}
