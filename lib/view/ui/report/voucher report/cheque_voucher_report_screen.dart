import 'package:cash_van_app/view/widget/auth/custom_text_filed.dart';
import 'package:cash_van_app/view/widget/report/customer_dropdown_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controller/report/voucher/cheque_voucher_report_controller.dart';
import '../../../widget/report/filter_report_widget.dart';
import '../../../widget/report/voucher/cheuqe_voucher_report_widget.dart';

class ChequeVoucherReportScreen extends StatelessWidget {
  ChequeVoucherReportScreen({super.key});

  final _controller = ChequeVoucherReportController.to;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cheque Voucher Report'.tr),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: FilterReportWidget(
          formKey: _controller.formKey,
          fromDateController: _controller.fromDateController,
          toDateController: _controller.toDateController,
          widgets: [
            const SizedBox(height: 16),
            CustomTextFiledWidget(
                keyboardType: TextInputType.number,
                controller: TextEditingController(),
                label: 'Voucher Number',
                hint: 'Enter voucher number'),
            const SizedBox(height: 16),
            CustomerDropdownWidget(
              onChanged: (p0) {
                _controller.customerId = p0!;
              },
            ),
            const SizedBox(height: 24),
          ],
          onTap: () {
            _controller.getChequeVoucherReport();
          },
          reportWidget: ChequeVoucherReportWidget(),
        ),
      ),
    );
  }
}
