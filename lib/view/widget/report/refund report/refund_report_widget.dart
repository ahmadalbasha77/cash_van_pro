import 'package:cash_van_app/controller/report/refund/refund_invoice_report_controller.dart';
import 'package:cash_van_app/core/app_color.dart';
import 'package:cash_van_app/core/text_style.dart';
import 'package:cash_van_app/view/widget/custom_button.dart';
import 'package:cash_van_app/view/widget/report/data_table_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/route/routes.dart';
import '../../custom_loading_error_widget.dart';

class RefundReportWidget extends StatelessWidget {
  RefundReportWidget({super.key});

  final _controller = RefundInvoiceReportController.to;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RefundInvoiceReportController>(
      builder: (logic) {
        return CustomLoadingErrorWidget(
            isLoading: _controller.isLoading,
            list: _controller.refundInvoiceReportList,
            error: 'No Data'.tr,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 30),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10.0),
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: AppColor.primaryColor,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Center(
                    child: Text(
                      "${'Total Invoices:'.tr} ${_controller.getTotalAmount().toStringAsFixed(2)}",
                      style: AppTextStyles.bold20.copyWith(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                DataTableWidget(
                  title: 'Invoice Sales Report :'.tr,
                  data: _controller.formattedData,
                  headers: const [
                    '#',
                    'Date',
                    'Customer Name',
                    'Amount',
                    'Payment Method',
                  ],
                  actions: [
                    CustomButtonWidget(
                      vertical: 5,
                      textStyle: AppTextStyles.semiBold12
                          .copyWith(color: Colors.white),
                      title: 'Export PDF',
                      onPressed: () {
                        Get.toNamed(Routes.pdfPreview, arguments: {
                          'headers': const [
                            '#',
                            'Date',
                            'Customer Name',
                            'Amount',
                            'Payment Method',
                          ],
                          'data': _controller.formattedData
                        });
                        // Get.to(() => PdfPreviewScreen(
                        //       headers: const [
                        //         '#',
                        //         'Date',
                        //         'Customer Name',
                        //         'Amount',
                        //         'Payment Method',
                        //       ],
                        //       data: _controller.formattedData,
                        //     ));
                      },
                    ),
                  ],
                ),
              ],
            ));
      },
    );
  }
}
