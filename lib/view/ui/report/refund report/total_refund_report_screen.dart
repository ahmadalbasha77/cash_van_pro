import 'package:cash_van_app/core/app_color.dart';
import 'package:cash_van_app/core/utils.dart';
import 'package:cash_van_app/view/widget/auth/custom_text_filed.dart';
import 'package:flutter/material.dart';

import '../../../widget/report/sales report/total_sales_report_widget.dart';

class TotalRefundReportScreen extends StatelessWidget {
  const TotalRefundReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController fromDateController = TextEditingController();
    final TextEditingController toDateController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Total Sales Report'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: CustomTextFiledWidget(
                    readOnly: true,
                    suffixIcon: const Icon(Icons.calendar_today),
                    onTap: () async {
                      String data = await Utils.fromDateSelected(
                          fromDateController, toDateController, context);
                      if (data.isNotEmpty) {
                        fromDateController.text = data;
                      }
                    },
                    controller: fromDateController,
                    label: 'From',
                  ),
                ),
                const SizedBox(width: 15),
                const Icon(
                  Icons.sync_alt,
                  color: Colors.black54,
                  size: 20,
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: CustomTextFiledWidget(
                    readOnly: true,
                    suffixIcon: const Icon(Icons.calendar_today),
                    onTap: () async {
                      String data = await Utils.toDateSelected(
                          fromDateController, toDateController, context);
                      if (data.isNotEmpty) {
                        toDateController.text = data;
                      }
                    },
                    controller: toDateController,
                    label: 'To',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ButtonStyle(
                    padding: const WidgetStatePropertyAll(
                        EdgeInsets.symmetric(vertical: 15)),
                    backgroundColor:
                        WidgetStatePropertyAll(AppColor.primaryColor)),
                onPressed: () {},
                icon: const Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                label: const Text(
                  'Show',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const Expanded(child: TotalSalesReportWidget())
          ],
        ),
      ),
    );
  }
}
