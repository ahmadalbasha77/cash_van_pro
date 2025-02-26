import 'package:cash_van_app/core/text_style.dart';
import 'package:cash_van_app/core/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../controller/quotation/quotation_history_controller.dart';
import '../../../core/app_color.dart';
import '../../../model/quotation/quotation_history_model.dart';
import '../../widget/auth/custom_text_filed.dart';
import '../../widget/report/customer_dropdown_widget.dart';
import '../../widget/report/filter_report_widget.dart';
import 'edit_quotation_screen.dart';

class QuotationHistoryScreen extends StatelessWidget {
  QuotationHistoryScreen({
    super.key,
  });

  final _controller = QuotationHistoryController.to;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Quotation History".tr),
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
          CustomerDropdownWidget(
            onChanged: (p0) {
              _controller.customerId = p0!;
            },
          ),
          const SizedBox(height: 24),
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

class QuotationHistoryWidget extends StatelessWidget {
  final QuotationHistoryModel item;

  const QuotationHistoryWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 6,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Client Name
            Row(
              children: [
                Expanded(
                    flex: 6,
                    child: Text(item.eName, style: AppTextStyles.bold18)),
                const Spacer(),
                Icon(
                  Icons.date_range,
                  color: AppColor.primaryColor,
                  size: 18,
                ),
                const SizedBox(
                  width: 7,
                ),
                Text(
                  Utils.formatDate(item.invoiceDate),
                  style: AppTextStyles.regular14,
                ),
              ],
            ),
            const SizedBox(height: 8),

            Row(
              children: [
                Icon(Icons.receipt, color: Colors.grey[700], size: 18),
                const SizedBox(width: 5),
                Text(
                  "# ${item.tranactionNo}",
                  style: AppTextStyles.regular14,
                ),
              ],
            ),
            const SizedBox(height: 5),
            const SizedBox(height: 5),
            Row(
              children: [
                Icon(Icons.attach_money,
                    color: AppColor.primaryColor, size: 20),
                const SizedBox(width: 5),
                Text("${'Amount'.tr}: ${item.totalAfterTax.toStringAsFixed(3)}",
                    style: AppTextStyles.bold16),
              ],
            ),
            const SizedBox(height: 10),

            // Edit Button
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: ElevatedButton.icon(
                onPressed: () {
                  Get.to(
                    () => EditQuotationScreen(
                      customerId: item.customerId,
                      customerName: item.eName,
                    ),
                    arguments: {
                      'id': item.id,
                      'date': '${item.invoiceDate}',
                      'note': item.notes,
                    },
                  );
                },
                icon: const Icon(Icons.edit, size: 20),
                label: Text("Edit".tr),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
