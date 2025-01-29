import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../../../core/pw_font.dart';

class PdfPreviewScreen extends StatelessWidget {
  final List<Map<String, dynamic>> data;
  final List<String> headers;

  const PdfPreviewScreen({
    super.key,
    required this.data,
    required this.headers,
  });

  Future<Uint8List> generatePdf() async {
    if (data.isEmpty || headers.isEmpty) {
      throw Exception("No data or headers provided for the PDF.");
    }

    final pdf = pw.Document();
    final arabicFont = FontManager.arabicFont;

    const int rowsPerPage = 15;
    final int totalRows = data.length;
    final int totalPages = (totalRows / rowsPerPage).ceil();

    for (int pageIndex = 0; pageIndex < totalPages; pageIndex++) {
      final startRow = pageIndex * rowsPerPage;
      final endRow = (startRow + rowsPerPage > totalRows)
          ? totalRows
          : startRow + rowsPerPage;

      final currentData = data.sublist(startRow, endRow);

      pdf.addPage(
        pw.Page(
          build: (pw.Context context) {
            return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  textDirection: pw.TextDirection.rtl,
                  "Report - Page ${pageIndex + 1}",
                  style: pw.TextStyle(
                    fontSize: 24,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 20),
                pw.Directionality(
                  textDirection: pw.TextDirection.rtl,
                  child: pw.TableHelper.fromTextArray(
                    cellStyle: pw.TextStyle(
                      font: arabicFont,
                    ),
                    border: pw.TableBorder.all(),
                    cellAlignment: pw.Alignment.center,
                    headers: headers,
                    data: currentData.map((row) {
                      return headers
                          .map((header) => row[header]?.toString() ?? '-')
                          .toList();
                    }).toList(),
                  ),
                ),
              ],
            );
          },
        ),
      );
    }

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
