import 'package:cash_van_app/core/app_color.dart';
import 'package:cash_van_app/core/text_style.dart';
import 'package:cash_van_app/view/widget/auth/custom_text_filed.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils.dart';

class DailySalesReportScreen extends StatelessWidget {
  const DailySalesReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController fromDateController = TextEditingController();
    final TextEditingController toDateController = TextEditingController();

    return Scaffold(
        appBar: AppBar(
          title: const Text('Daily Sales Report'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextFiledWidget(
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
                label: 'select day',
              ),
              const SizedBox(height: 25),
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
              const SizedBox(
                height: 50,
              ),
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: AppColor.primaryColor,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Center(
                  child: Text("Total Invoices: 2500.50",
                      style:
                          AppTextStyles.bold20.copyWith(color: Colors.white)),
                ),
              ),
            ],
          ),
        ));
  }
}
