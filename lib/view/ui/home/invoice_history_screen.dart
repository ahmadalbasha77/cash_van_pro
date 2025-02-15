import 'package:cash_van_app/core/text_style.dart';
import 'package:cash_van_app/view/widget/auth/custom_text_filed.dart';
import 'package:cash_van_app/view/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../core/app_color.dart';

class InvoiceHistoryScreen extends StatelessWidget {
  const InvoiceHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Invoice History'.tr),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: CustomTextFiledWidget(
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      controller: TextEditingController(),
                      label: 'Invoice Number'),
                ),
                // FromDateWidget(
                //     fromDateController: data,
                //     toDateController: TextEditingController()),
                const SizedBox(width: 20),
                CustomButtonWidget(
                  vertical: 11,
                  textStyle:
                      AppTextStyles.regular16.copyWith(color: Colors.white),
                  title: 'search',
                  onPressed: () {},
                )
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return const InvoiceHistoryWidget();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InvoiceHistoryWidget extends StatelessWidget {
  const InvoiceHistoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Customer Name'.tr, style: AppTextStyles.bold18),
                Text('#1000985994 '.tr, style: AppTextStyles.regular14),
                const SizedBox(height: 6),
                Text(
                  'Type: Sales'.tr,
                  style: const TextStyle(color: Colors.black54),
                ),
                const Text(
                  'Amount: 100.00',
                  style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ],
            ),
            Column(
              children: [
                Text(
                  DateFormat.yMMMd().format(DateTime.now()),
                  style: const TextStyle(fontSize: 14, color: Colors.black87),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.info, color: AppColor.primaryColor),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Icon(Icons.print, color: AppColor.primaryColor),
                      onPressed: () {},
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
