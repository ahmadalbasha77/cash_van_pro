import 'package:flutter/services.dart';
import 'package:pdf/widgets.dart' as pw;

class FontManager {
  static late pw.Font arabicFont;

  static Future<void> initializeFonts() async {
    arabicFont =
        pw.Font.ttf(await rootBundle.load('assets/font/Amiri-Regular.ttf'));
  }
}
