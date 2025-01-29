import 'package:cash_van_app/core/text_style.dart';
import 'package:cash_van_app/view/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class TotalSalesReportWidget extends StatelessWidget {
  const TotalSalesReportWidget({super.key});

  @override
  Widget build(BuildContext context) {

    final List<Map<String, dynamic>> invoices = [
      {
        "invoiceNumber": "INV001",
        "amount": 500.0,
        "date": "2025-01-15",
      },
      {
        "invoiceNumber": "INV001",
        "amount": 500.0,
        "date": "2025-01-15",
      },
      {
        "invoiceNumber": "INV001",
        "amount": 500.0,
        "date": "2025-01-15",
      },
      {
        "invoiceNumber": "INV001",
        "amount": 500.0,
        "date": "2025-01-15",
      },
      {
        "invoiceNumber": "INV001",
        "amount": 500.0,
        "date": "2025-01-15",
      },
      {
        "invoiceNumber": "INV001",
        "amount": 500.0,
        "date": "2025-01-15",
      },
      {
        "invoiceNumber": "INV001",
        "amount": 500.0,
        "date": "2025-01-15",
      },
      {
        "invoiceNumber": "INV001",
        "amount": 500.0,
        "date": "2025-01-15",
      },
      {
        "invoiceNumber": "INV001",
        "amount": 500.0,
        "date": "2025-01-15",
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(
          height: 30,
        ),
        const SizedBox(height: 20.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Total Sales Report :",
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            CustomButtonWidget(
              vertical: 5,
              textStyle: AppTextStyles.semiBold12.copyWith(color: Colors.white),
              title: '',
              onPressed: () => Get.to(() => PdfPreviewScreen(
                    invoices: invoices,
                  )),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        Expanded(
          child: Center(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: const [
                  DataColumn(
                    label: Text(
                      "#",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      "amount",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      "date",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
                rows: invoices.map((invoice) {
                  return DataRow(
                    cells: [
                      DataCell(Text(invoice['invoiceNumber'])),
                      DataCell(Text("${invoice['amount'].toStringAsFixed(2)}")),
                      DataCell(Text(invoice['date'])),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class PdfPreviewScreen extends StatelessWidget {
  final List<Map<String, dynamic>> invoices;

  const PdfPreviewScreen({
    super.key,
    required this.invoices,
  });

  Future<Uint8List> generatePdf() async {
    final pdf = pw.Document();
    final arabicFont =
        pw.Font.ttf(await rootBundle.load('assets/font/Amiri-Regular.ttf'));

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                textDirection: pw.TextDirection.rtl,
                "Invoice Report",
                style: pw.TextStyle(
                  fontSize: 24,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 30),
              pw.Directionality(
                textDirection: pw.TextDirection.rtl,
                child: pw.TableHelper.fromTextArray(
                  cellStyle: pw.TextStyle(
                    font: arabicFont,
                  ),
                  headers: [
                    "#",
                    "Date",
                    "Customer Name",
                    "Amount",
                    "Payment Method"
                  ],
                  data: invoices.map((invoice) {
                    return [
                      invoice['invoiceNumber'],
                      invoice['date'],
                      invoice['recipient'],
                      invoice['amount'].toStringAsFixed(2),
                      invoice['paymentMethod'],
                    ];
                  }).toList(),
                ),
              ),
            ],
          );
        },
      ),
    );

    return pdf.save();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PDF Preview"),
        centerTitle: true,
      ),
      body: PdfPreview(
        canDebug: false,
        build: (format) => generatePdf(),
        allowSharing: true,
        allowPrinting: true,
      ),
    );
  }
}
