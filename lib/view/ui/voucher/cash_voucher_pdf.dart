import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../../core/pw_font.dart';

Future<pw.Document> cashVoucherPdf({
  required String recipientName,
  required double amount,
  required String customerName,
}) async {
  final pdf = pw.Document();
  const customPageFormat = PdfPageFormat.roll80;
  final arabicFont = FontManager.arabicFont;

  pdf.addPage(
    pw.Page(
      pageFormat: customPageFormat,
      margin: const pw.EdgeInsets.all(10),
      build: (pw.Context context) {
        return pw.Directionality(
            textDirection: pw.TextDirection.rtl,
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                // Title Section
                pw.Center(
                  child: pw.Text(
                    'Royal Shop',
                    style: pw.TextStyle(
                      fontSize: 20,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ),
                pw.Center(
                  child: pw.Text(
                    'سند قبض',
                    style: pw.TextStyle(
                      fontSize: 14,
                      font: arabicFont,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ),
                pw.Divider(thickness: 2),

                // Date and Time Section
                pw.SizedBox(height: 10),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text(
                      'التاريخ: ${DateTime.now().toLocal().toString().split(' ')[0]}',
                      style:  pw.TextStyle(fontSize: 10, font: arabicFont),
                    ),
                    pw.Text(
                      'الوقت: ${DateTime.now().toLocal().toString().split(' ')[1].split('.')[0]}',
                      style:  pw.TextStyle(fontSize: 10, font: arabicFont),
                    ),
                  ],
                ),

                pw.SizedBox(height: 10),

                // Recipient and Amount Section
                pw.Container(
                  padding: const pw.EdgeInsets.all(8),
                  decoration: pw.BoxDecoration(
                    border: pw.Border.all(width: 0.5),
                    borderRadius: pw.BorderRadius.circular(4),
                  ),
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        'اسم المستلم: $recipientName',
                        style:  pw.TextStyle(fontSize: 12, font: arabicFont),
                      ),
                      pw.SizedBox(height: 5),
                      pw.Text(
                        'اسم العميل: $customerName',
                        style:  pw.TextStyle(fontSize: 12, font: arabicFont),
                      ),
                      pw.SizedBox(height: 5),
                      pw.Text(
                        'المبلغ: ${amount.toStringAsFixed(2)} ',
                        style:  pw.TextStyle(fontSize: 12, font: arabicFont),
                      ),


                    ],
                  ),
                ),

                pw.SizedBox(height: 15),

                pw.Divider(thickness: 2),

                // Signature Section
                pw.SizedBox(height: 20),
                pw.Text(
                  'توقيع المستلم:',
                  style:  pw.TextStyle(fontSize: 12, font: arabicFont),
                ),
                pw.SizedBox(height: 30),
                pw.Divider(thickness: 1),
              ],
            ));
      },
    ),
  );

  return pdf;
}
