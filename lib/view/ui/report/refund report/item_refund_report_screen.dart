import 'package:flutter/material.dart';

import '../../../widget/report/filter_item_widget.dart';
import '../../../widget/report/sales report/item_report_widget.dart';

class ItemRefundReportScreen extends StatelessWidget {
  const ItemRefundReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Item Refund Report'),
        centerTitle: true,
      ),
      body: const SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            FilterItemReport(),
            SizedBox(height: 24),
            ItemReportWidget()
          ],
        ),
      ),
    );
  }
}
