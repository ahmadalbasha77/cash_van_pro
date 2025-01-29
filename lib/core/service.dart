import 'package:cash_van_app/core/pw_font.dart';
import 'package:get/get.dart';

import 'my_shared_preferences.dart';


class MyService extends GetxService {
  Future<MyService> init() async {
    await mySharedPreferences.init();
    await FontManager.initializeFonts();
    return this;
  }
}


Future<void> initialServices() async {
  await Get.putAsync(() => MyService().init());
}
