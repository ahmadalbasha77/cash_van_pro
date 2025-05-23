import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../../core/pw_font.dart';
import '../../model/invoice/cart_model.dart';

Future<pw.Document> salesInvoicePdf({
  required List<CartModel> cartList,
  required String customerName,
  required int invoiceId,
  required String customerNumber,
  required String representativeName,
  required double totalAmount,
  required String invoiceType,
  required String paymentType,
  required String note,
}) async {
  final pdf = pw.Document();
  const customPageFormat = PdfPageFormat.roll80;
  String wrapText(String text, int maxLength) {
    if (text.length <= maxLength) {
      return text;
    }
    final buffer = StringBuffer();
    for (int i = 0; i < text.length; i += maxLength) {
      buffer.write(text.substring(
          i, i + maxLength > text.length ? text.length : i + maxLength));
      if (i + maxLength < text.length) {
        buffer.write('\n');
      }
    }
    return buffer.toString();
  }

  pw.Font arabicFont = FontManager.arabicFont;
  pdf.addPage(
    pw.Page(
      pageFormat: customPageFormat,
      margin: const pw.EdgeInsets.all(10),
      build: (pw.Context context) {
        return pw
            .Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
          pw.Center(
            child: pw.Text('Royal Shop',
                style: pw.TextStyle(
                  fontSize: 20,
                  fontWeight: pw.FontWeight.bold,
                )),
          ),
          pw.Divider(thickness: 2),

          // Invoice and Payment Type
          pw.SizedBox(height: 10),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text('Invoice Type: $invoiceType',
                  style: const pw.TextStyle(fontSize: 10)),
              pw.Text(' $paymentType', style: const pw.TextStyle(fontSize: 10)),
            ],
          ),

          pw.SizedBox(height: 10),

          // Date and Customer Information
          pw.Text(
            'Invoice Number : $invoiceId',
            style: const pw.TextStyle(fontSize: 10),
          ),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text(
                DateTime.now().toLocal().toString().split(' ')[0],
                style: const pw.TextStyle(fontSize: 10),
              ),
              pw.Text(
                DateTime.now().toLocal().toString().split(' ')[1].split('.')[0],
                style: const pw.TextStyle(fontSize: 10),
              ),
            ],
          ),
          pw.Directionality(
            textDirection: pw.TextDirection.rtl,
            child: pw.Text(
              'Note : $note',
              style: pw.TextStyle(
                fontSize: 10,
                font: FontManager.arabicFont,
              ),
            ),
          ),

          pw.SizedBox(height: 10),
          pw.Container(
            padding: const pw.EdgeInsets.all(8),
            decoration: pw.BoxDecoration(
              border: pw.Border.all(width: 0.5),
              borderRadius: pw.BorderRadius.circular(4),
            ),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.SizedBox(height: 5),
                pw.Directionality(
                  textDirection: pw.TextDirection.rtl,
                  child: pw.Text('Name: $customerName',
                      style: pw.TextStyle(fontSize: 10, font: arabicFont)),
                ),
                pw.Text('Phone: $customerNumber',
                    style: const pw.TextStyle(fontSize: 10)),
              ],
            ),
          ),

          pw.SizedBox(height: 15),

          // Items Section
          pw.Text('Item:',
              style:
                  pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold)),
          pw.SizedBox(height: 5),

          // Items List with Headers
          pw.Directionality(
            textDirection: pw.TextDirection.rtl,
            child: pw.TableHelper.fromTextArray(
              headers: ['Item', 'QTY', 'Tax', 'PBT', 'Total'],
              data: cartList.map((item) {
                return [
                  wrapText(item.itemName, 11),
                  item.quantity.toString(),
                  '16 %',
                  (item.totalPrice / 1.16).toStringAsFixed(2), // السعر قبل الضريبة
                  item.totalPrice.toStringAsFixed(2),
                ];
              }).toList(),
              headerStyle: pw.TextStyle(
                fontWeight: pw.FontWeight.bold,
                fontSize: 10,
                font: FontManager.arabicFont,
              ),
              cellStyle: pw.TextStyle(
                fontSize: 10,
                font: FontManager.arabicFont,
              ),
              border: pw.TableBorder.all(width: 0.5),
            ),
          ),

          pw.SizedBox(height: 10),
          pw.Divider(thickness: 2),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text('Total Before Tax:',
                  style: const pw.TextStyle(
                    fontSize: 11,
                  )),
              pw.Text(totalAmount.toStringAsFixed(2),
                  style: const pw.TextStyle(
                    fontSize: 11,
                  )),
            ],
          ),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text('Discount:',
                  style: const pw.TextStyle(
                    fontSize: 11,
                  )),
              pw.Text('0.0',
                  style: const pw.TextStyle(
                    fontSize: 11,
                  )),
            ],
          ),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text('Tax Amount:',
                  style: const pw.TextStyle(
                    fontSize: 11,
                  )),
              pw.Text('16 %',
                  style: const pw.TextStyle(
                    fontSize: 12,
                  )),
            ],
          ),
          pw.Divider(thickness: 1),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text('Total Amount:',
                  style: pw.TextStyle(
                      fontSize: 12, fontWeight: pw.FontWeight.bold)),
              pw.Text('${totalAmount.toStringAsFixed(2)} JOD',
                  style: pw.TextStyle(
                      fontSize: 12, fontWeight: pw.FontWeight.bold)),
            ],
          ),

          pw.SizedBox(height: 15),

          // Representative Information
          pw.Container(
            padding: const pw.EdgeInsets.all(8),
            decoration: pw.BoxDecoration(
              border: pw.Border.all(width: 0.5),
              borderRadius: pw.BorderRadius.circular(4),
            ),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.SizedBox(height: 5),
                pw.Directionality(
                  textDirection: pw.TextDirection.rtl,
                  child: pw.Text(representativeName,
                      style: pw.TextStyle(
                          fontSize: 10,
                          fontStyle: pw.FontStyle.italic,
                          font: arabicFont)),
                )
              ],
            ),
          ),

          pw.SizedBox(height: 20),

          // Footer Section
          pw.Center(
            child: pw.Text('Thank you for shopping with Royal Shop!',
                textAlign: pw.TextAlign.center,
                style:
                    pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold)),
          ),
        ]);
        // Header Section
      },
    ),
  );

  return pdf;
}
