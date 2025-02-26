import 'package:cash_van_app/model/customers/customers_model.dart';
import 'package:cash_van_app/view/ui/quotation%20history/quotation_history_screen.dart';
import 'package:cash_van_app/view/ui/quotation/quotation_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../controller/quotation/quotation_history_controller.dart';
import '../../../core/app_color.dart';
import '../../../core/my_shared_preferences.dart';
import '../../widget/auth/custom_text_filed.dart';
import '../../widget/report/filter_report_widget.dart';

class CustomerQuotationHistoryScreen extends StatelessWidget {
  final CustomersModel customer;

  CustomerQuotationHistoryScreen({
    super.key,
    required this.customer,
  });

  final _controller = QuotationHistoryController.to;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Align(
          alignment: AlignmentDirectional.bottomStart,
          child: FloatingActionButton(
              onPressed: () {
                Get.to(() => QuotationScreen(customersData: customer));
              },
              backgroundColor: AppColor.primaryColor,
              child: Icon(
                Icons.add,
                size: 38 * mySharedPreferences.fontSize,
                color: Colors.white,
              )),
        ),
      ),
      appBar: AppBar(
        title: Text("${'Quotation'.tr} ${customer.aName}".tr),
      ),
      body: FilterReportWidget(
        formKey: _controller.formKey,
        fromDateController: _controller.fromDateController,
        toDateController: _controller.toDateController,
        widgets: [
          const SizedBox(height: 16),
          CustomTextFiledWidget(
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              keyboardType: TextInputType.number,
              controller: _controller.invoiceNumberController,
              label: 'Invoice Number',
              hint: 'enter invoice number'),
          const SizedBox(height: 16),
        ],
        onTap: () {
          _controller.getQuotation();
        },
        reportWidget: GetBuilder<QuotationHistoryController>(
            builder: (logic) => _controller.isLoading == true
                ? const Center(child: CircularProgressIndicator())
                : _controller.quotationHistoryList.isEmpty
                    ? const Center(child: Text("No Data"))
                    : Expanded(
                        child: ListView.builder(
                          padding: const EdgeInsets.only(
                              right: 12, left: 12, top: 10, bottom: 10),
                          itemCount: _controller.quotationHistoryList.length,
                          itemBuilder: (context, index) {
                            final item =
                                _controller.quotationHistoryList[index];

                            return QuotationHistoryWidget(item: item);
                          },
                        ),
                      )),
      ),
    );
  }
}
