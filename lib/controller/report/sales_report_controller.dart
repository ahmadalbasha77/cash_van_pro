import 'package:get/get.dart';

class SalesReportController extends GetxController {
  static SalesReportController get to => Get.isRegistered<SalesReportController>()
      ? Get.find<SalesReportController>()
      : Get.put(SalesReportController());
}
