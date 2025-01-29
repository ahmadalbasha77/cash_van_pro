import 'package:cash_van_app/core/text_style.dart';
import 'package:cash_van_app/view/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/app_color.dart';
import '../../widget/report/from_date_widget.dart';

class TransactionHistoryScreen extends StatelessWidget {
  const TransactionHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController data = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transaction History'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                FromDateWidget(
                    fromDateController: data,
                    toDateController: TextEditingController()),
                const SizedBox(width: 20),
                CustomButtonWidget(
                  vertical: 11,
                  textStyle:
                      AppTextStyles.regular16.copyWith(color: Colors.white),
                  title: 'Search',
                  onPressed: () {},
                )
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return const TransactionHistoryWidget();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TransactionHistoryWidget extends StatelessWidget {
  const TransactionHistoryWidget({super.key});

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
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Customer Name',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.black87)),
                SizedBox(height: 6),
                Text(
                  'Type: Sales',
                  style: TextStyle(color: Colors.black54),
                ),
                Text(
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
                IconButton(
                  icon: Icon(Icons.print, color: AppColor.primaryColor),
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
