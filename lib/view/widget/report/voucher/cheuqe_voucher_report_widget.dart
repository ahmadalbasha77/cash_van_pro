import 'package:cash_van_app/core/text_style.dart';
import 'package:cash_van_app/view/widget/custom_button.dart';
import 'package:cash_van_app/view/widget/report/data_table_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controller/report/voucher/cheque_voucher_report_controller.dart';
import '../../../../core/route/routes.dart';
import '../../custom_loading_error_widget.dart';

class ChequeVoucherReportWidget extends StatelessWidget {
  ChequeVoucherReportWidget({super.key});

  final _controller = ChequeVoucherReportController.to;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChequeVoucherReportController>(
      builder: (logic) {
        return CustomLoadingErrorWidget(
            isLoading: _controller.isLoading,
            list: _controller.chequeVoucherReportList,
            error: 'No Data'.tr,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 20.0),
                DataTableWidget(
                  title: 'Invoice Sales Report :'.tr,
                  data: _controller.formattedData,
                  headers: const [
                    '#',
                    'Date',
                    'Customer Name',
                    'Amount',
                    'Received',
                    'Cheque Num',
                    'Bank',
                    'Co',
                    'First Beneficiary',
                    'Commit Date'
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
                            'Received',
                            'Cheque Num',
                            'Bank',
                            // 'Co',
                            // 'First Beneficiary',
                            // 'Commit Date'
                          ],
                          'data': _controller.formattedData
                        });
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
