import 'package:cash_van_app/view/widget/report/customer_dropdown_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controller/report/customer/account_statement_report_controller.dart';
import '../../../widget/report/customer/account_statement_widget.dart';
import '../../../widget/report/filter_report_widget.dart';

class AccountStatementsScreen extends StatelessWidget {
  AccountStatementsScreen({super.key});

  final _controller = AccountStatementReportController.to;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Account Statements'.tr),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: FilterReportWidget(
              formKey: _controller.formKey,
              fromDateController: _controller.fromDateController,
              toDateController: _controller.toDateController,
              widgets: [
                const SizedBox(height: 16),
                CustomerDropdownWidget(
                  onChanged: (p0) {
                    _controller.customerId = p0!;
                  },
                ),
                const SizedBox(height: 24),
              ],
              onTap: () {
                _controller.getAccountStatementReport();
              },
              reportWidget: AccountStatementWidget(),
            ),
          ),
        ));
  }
}
