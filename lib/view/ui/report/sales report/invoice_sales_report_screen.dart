import 'package:cash_van_app/controller/report/sales/sales_invoice_report_controller.dart';
import 'package:cash_van_app/view/widget/report/customer_dropdown_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widget/report/filter_report_widget.dart';
import '../../../widget/report/sales report/invoice_report_widget.dart';

class InvoiceSalesReportScreen extends StatelessWidget {
  InvoiceSalesReportScreen({super.key});

  final _controller = SalesInvoiceReportController.to;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Sales Report'.tr),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: FilterReportWidget(
            formKey: _controller.formKey,
            fromDateController: _controller.fromDateController,
            toDateController: _controller.toDateController,
            widgets: [
              const SizedBox(height: 16),
              // CustomTextFiledWidget(
              //     keyboardType: TextInputType.number,
              //     controller: TextEditingController(),
              //     label: 'Invoice Number',
              //     hint: 'enter invoice number'),
              // const SizedBox(height: 16),
              CustomerDropdownWidget(
                onChanged: (p0) {
                  _controller.customerId = p0!;
                },
              ),
              const SizedBox(height: 24),
            ],
            onTap: () {
              _controller.getSalesInvoiceReport();
            },
            reportWidget: InvoiceReportWidget(),
          ),
        ));
  }
}
