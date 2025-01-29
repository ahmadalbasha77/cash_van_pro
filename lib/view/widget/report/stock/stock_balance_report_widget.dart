import 'package:flutter/material.dart';

class StockBalanceReportWidget extends StatelessWidget {
  const StockBalanceReportWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> invoices = [
      {
        "itemName": 'Item 1',
        "quantityItem": 20,
        'barcodeItem': '123456789',
      },
      {
        "itemName": 'Item 1',
        "quantityItem": 20,
        'barcodeItem': '123456789',
      },
      {
        "itemName": 'Item 1',
        "quantityItem": 20,
        'barcodeItem': '123456789',
      },
      {
        "itemName": 'Item 1',
        "quantityItem": 20,
        'barcodeItem': '123456789',
      },
      {
        "itemName": 'Item 1',
        "quantityItem": 20,
        'barcodeItem': '123456789',
      },
      {
        "itemName": 'Item 1',
        "quantityItem": 20,
        'barcodeItem': '123456789',
      },
      {
        "itemName": 'Item 1',
        "quantityItem": 20,
        'barcodeItem': '123456789',
      },
      {
        "itemName": 'Item 1',
        "quantityItem": 20,
        'barcodeItem': '123456789',
      },
      {
        "itemName": 'Item 1',
        "quantityItem": 20,
        'barcodeItem': '123456789',
      },
      {
        "itemName": 'Item 1',
        "quantityItem": 20,
        'barcodeItem': '123456789',
      },
      {
        "itemName": 'Item 1',
        "quantityItem": 20,
        'barcodeItem': '123456789',
      },
      {
        "itemName": 'Item 1',
        "quantityItem": 20,
        'barcodeItem': '123456789',
      },
      {
        "itemName": 'Item 1',
        "quantityItem": 20,
        'barcodeItem': '123456789',
      },
      {
        "itemName": 'Item 1',
        "quantityItem": 20,
        'barcodeItem': '123456789',
      },
      {
        "itemName": 'Item 1',
        "quantityItem": 20,
        'barcodeItem': '123456789',
      },
      {
        "itemName": 'Item 1',
        "quantityItem": 20,
        'barcodeItem': '123456789',
      },
      {
        "itemName": 'Item 1',
        "quantityItem": 20,
        'barcodeItem': '123456789',
      },
      {
        "itemName": 'Item 1',
        "quantityItem": 20,
        'barcodeItem': '123456789',
      },
      {
        "itemName": 'Item 1',
        "quantityItem": 20,
        'barcodeItem': '123456789',
      },
      {
        "itemName": 'Item 1',
        "quantityItem": 20,
        'barcodeItem': '123456789',
      },
      {
        "itemName": 'Item 1',
        "quantityItem": 20,
        'barcodeItem': '123456789',
      },
      {
        "itemName": 'Item 1',
        "quantityItem": 20,
        'barcodeItem': '123456789',
      },
      {
        "itemName": 'Item 1',
        "quantityItem": 20,
        'barcodeItem': '123456789',
      },
      {
        "itemName": 'Item 1',
        "quantityItem": 20,
        'barcodeItem': '123456789',
      },
      {
        "itemName": 'Item 1',
        "quantityItem": 20,
        'barcodeItem': '123456789',
      },
      {
        "itemName": 'Item 1',
        "quantityItem": 20,
        'barcodeItem': '123456789',
      },
      {
        "itemName": 'Item 1',
        "quantityItem": 20,
        'barcodeItem': '123456789',
      },
      {
        "itemName": 'Item 1',
        "quantityItem": 20,
        'barcodeItem': '123456789',
      },
      {
        "itemName": 'Item 1',
        "quantityItem": 20,
        'barcodeItem': '123456789',
      },
      {
        "itemName": 'Item 1',
        "quantityItem": 20,
        'barcodeItem': '123456789',
      },
      {
        "itemName": 'Item 1',
        "quantityItem": 20,
        'barcodeItem': '123456789',
      },
      {
        "itemName": 'Item 1',
        "quantityItem": 20,
        'barcodeItem': '123456789',
      },
      {
        "itemName": 'Item 1',
        "quantityItem": 20,
        'barcodeItem': '123456789',
      },
      {
        "itemName": 'Item 1',
        "quantityItem": 20,
        'barcodeItem': '123456789',
      },

    ];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20.0),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Stock Balance Report :",
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columnSpacing: MediaQuery.of(context).size.width * 0.06,
                columns: const [
                  DataColumn(
                    label: Text(
                      "#",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      "Item Name",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      "Barcode Item",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      "Quantity Item",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
                rows: invoices.map((invoice) {
                  return DataRow(
                    cells: [
                      DataCell(Text('${invoices.indexOf(invoice) + 1}')),
                      DataCell(ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 150),
                          child: Text(
                              overflow: TextOverflow.ellipsis,
                              softWrap: true,
                              maxLines: 2,
                              invoice['itemName']))),
                      DataCell(Text('${invoice['barcodeItem']}')),
                      DataCell(Text('${invoice['quantityItem']}')),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),

        ],
      ),
    );
  }
}
