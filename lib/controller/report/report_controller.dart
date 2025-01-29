import 'package:get/get.dart';

class ReportController extends GetxController {
  static ReportController get to => Get.isRegistered<ReportController>()
      ? Get.find<ReportController>()
      : Get.put(ReportController());
  var isActive = false.obs;
  var isActiveRefunds = false.obs;
  var isActiveVouchers = false.obs;
  var isActiveCustomers = false.obs;
  var isActiveStock = false.obs;

  // Toggle functions
  void toggleSalesReports() {
    isActive.value = !isActive.value;
  }

  void toggleRefundsReports() {
    isActiveRefunds.value = !isActiveRefunds.value;
  }

  void toggleVouchersReports() {
    isActiveVouchers.value = !isActiveVouchers.value;
  }

  void toggleCustomersReports() {
    isActiveCustomers.value = !isActiveCustomers.value;
  }

  void toggleStockReports() {
    isActiveStock.value = !isActiveStock.value;
  }
}
