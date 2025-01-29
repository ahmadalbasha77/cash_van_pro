import 'package:cash_van_app/view/ui/report/sales%20report/chart.dart';
import 'package:cash_van_app/view/widget/custom_button.dart';
import 'package:cash_van_app/view/widget/report/data_table_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItemReportWidget extends StatelessWidget {
  const ItemReportWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> invoices = [
      {
        "invoiceNumber": "INV001",
        "item": 'Item 1',
        "quantitySales": 20,
        "salesAmount": 200.5,
      },
      {
        "invoiceNumber": "INV002",
        "item": 'Item 2',
        "quantitySales": 30,
        "salesAmount": 250.5,
      },
      {
        "invoiceNumber": "INV003",
        "item": 'Item 3',
        "quantitySales": 10,
        "salesAmount": 120,
      },
      {
        "invoiceNumber": "INV004",
        "item": 'Item 4',
        "quantitySales": 15,
        "salesAmount": 170,
      },
      {
        "invoiceNumber": "INV005",
        "item": 'Item 5',
        "quantitySales": 3,
        "salesAmount": 10.5,
      },
      {
        "invoiceNumber": "INV006",
        "item": 'Item 6',
        "quantitySales": 40,
        "salesAmount": 300,
      },
    ];

    return DataTableWidget(
        actions: [
          CustomButtonWidget(
            vertical: 10,
            title: 'View Chart',
            onPressed: () {
              Get.to(() => ItemReportChartWidget(
                items: invoices,
              ));
            },
          )
        ],
        title: 'Item Report:',
        data: invoices,
        headers: const [
          'invoiceNumber',
          'item',
          'quantitySales',
          'salesAmount',
        ]);
  }
}
