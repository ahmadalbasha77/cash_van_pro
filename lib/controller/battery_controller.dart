import 'package:get/get.dart';
import '../../../core/battery_service.dart';

class BatteryController extends GetxController {
  final BatteryService _batteryService = BatteryService();
  var batteryLevel = 0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchBatteryLevel();
  }

  Future<void> fetchBatteryLevel() async {
    int level = await _batteryService.getBatteryLevel();
    batteryLevel.value = level;
  }
}
