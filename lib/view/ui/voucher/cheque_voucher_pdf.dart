import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../../core/pw_font.dart';

Future<pw.Document> chequeVoucherPdf({
  required String beneficiaryName,
  required double chequeAmount,
  required String chequeNumber,
  required String bankName,
  // required String customerName,
  required String date,
  required bool isFirstBeneficiary,
  required bool isCO,
  required bool isCommitDate,
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
                    'سند شيك',
                    style: pw.TextStyle(
                      fontSize: 14,
                      font: arabicFont,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ),
                pw.Divider(thickness: 2),

                // Date Section
                pw.SizedBox(height: 10),
                pw.Text(
                  'التاريخ: $date',
                  style: pw.TextStyle(fontSize: 12, font: arabicFont),
                ),
                pw.SizedBox(height: 10),

                // Customer and Beneficiary Details
                pw.Container(
                  padding: const pw.EdgeInsets.all(8),
                  decoration: pw.BoxDecoration(
                    border: pw.Border.all(width: 0.5),
                    borderRadius: pw.BorderRadius.circular(4),
                  ),
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      // pw.Text(
                      //   'اسم العميل: $customerName',
                      //   style: pw.TextStyle(fontSize: 12, font: arabicFont),
                      // ),
                      pw.SizedBox(height: 5),
                      pw.Text(
                        'اسم المستفيد: $beneficiaryName',
                        style: pw.TextStyle(fontSize: 12, font: arabicFont),
                      ),
                    ],
                  ),
                ),

                pw.SizedBox(height: 10),

                // Cheque Details
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
                        'رقم الشيك: $chequeNumber',
                        style: pw.TextStyle(fontSize: 12, font: arabicFont),
                      ),
                      pw.SizedBox(height: 5),
                      pw.Text(
                        'اسم البنك: $bankName',
                        style: pw.TextStyle(fontSize: 12, font: arabicFont),
                      ),
                      pw.SizedBox(height: 5),
                      pw.Text(
                        'قيمة الشيك: ${chequeAmount.toStringAsFixed(2)} دينار اردني',
                        style: pw.TextStyle(fontSize: 12, font: arabicFont),
                      ),
                    ],
                  ),
                ),

                pw.SizedBox(height: 10),

                // Options Section
                pw.Container(
                  padding: const pw.EdgeInsets.all(8.0),
                  decoration: pw.BoxDecoration(
                    border: pw.Border.all(color: PdfColors.grey300),
                    borderRadius: pw.BorderRadius.circular(8),
                  ),
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        'الخيارات:',
                        style: pw.TextStyle(
                            fontSize: 12,
                            fontWeight: pw.FontWeight.bold,
                            font: arabicFont),
                      ),
                      pw.SizedBox(height: 5),
                      pw.Text(
                        'يصرف للمستفيد الاول: ${isFirstBeneficiary ? "نعم" : "لا"}',
                        style: pw.TextStyle(fontSize: 12, font: arabicFont),
                      ),
                      pw.Text(
                        'CO: ${isCO ? "نعم" : "لا"}',
                        style: pw.TextStyle(fontSize: 12, font: arabicFont),
                      ),
                      pw.Text(
                        'يصرف بتاريخه: ${isCommitDate ? "نعم" : "لا"}',
                        style: pw.TextStyle(fontSize: 12, font: arabicFont),
                      ),
                    ],
                  ),
                ),

                pw.SizedBox(height: 20),
                pw.Divider(thickness: 1),

                // Signature Section
                pw.SizedBox(height: 10),
                pw.Text(
                  'توقيع المستفيد:',
                  style: pw.TextStyle(fontSize: 12, font: arabicFont),
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
