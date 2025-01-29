import 'package:cash_van_app/controller/voucher/bank_controller.dart';
import 'package:get/get.dart';

import '../controller/invoice/cart_controller.dart';
import '../controller/invoice/sales_and_refund_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CartController>(() => CartController(), fenix: true);
    Get.lazyPut<SalesAndRefundController>(() => SalesAndRefundController(), fenix: true);
    Get.put(BankController(), permanent: true);
  }
}
