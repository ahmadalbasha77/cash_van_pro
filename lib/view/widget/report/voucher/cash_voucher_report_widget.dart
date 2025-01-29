import 'package:cash_van_app/controller/report/voucher/cash_voucher_report_controller.dart';
import 'package:cash_van_app/core/text_style.dart';
import 'package:cash_van_app/view/widget/custom_button.dart';
import 'package:cash_van_app/view/widget/report/data_table_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/route/routes.dart';
import '../../custom_loading_error_widget.dart';

class CashVoucherReportWidget extends StatelessWidget {
  CashVoucherReportWidget({super.key});

  final _controller = CashVoucherReportController.to;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CashVoucherReportController>(
      builder: (logic) {
        return CustomLoadingErrorWidget(
            isLoading: _controller.isLoading,
            list: _controller.cashVoucherReportList,
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
