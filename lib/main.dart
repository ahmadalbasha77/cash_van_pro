import 'package:cash_van_app/core/binding.dart';
import 'package:cash_van_app/core/service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:cash_van_app/controller/settings_controller.dart';
import 'package:cash_van_app/core/my_shared_preferences.dart';
import 'package:cash_van_app/core/translations/translations.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'core/route/app_pages.dart';
import 'core/route/routes.dart';
import 'core/theme/light_theme_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initialServices();
    runApp(
      const MyApp(),
    );
  }


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final SettingsController controller = Get.put(SettingsController());

    return GetBuilder<SettingsController>(
      id: 'theme',
      assignId: true,
      builder: (logic) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Cash Van Pro',
          initialBinding: InitialBinding(),
          theme: lightThemeApp(controller.appColor),
          translations: Translation(),
          locale: Locale(mySharedPreferences.language),
          initialRoute: Routes.initial,
          getPages: AppPages.pages,
          // home: ProposalScreen(),
        );
      },
    );
  }
}
