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

  if (kReleaseMode) {
    await SentryFlutter.init(
      (options) {
        options.dsn =
            'https://c1bc16137f4e09d341bc4482893e4f66@o4508884569817088.ingest.us.sentry.io/4508884570800128';
        options.tracesSampleRate = 1.0;
        options.profilesSampleRate = 1.0;
      },
      appRunner: () => runApp(
        const SentryWidget(
          child: MyApp(),
        ),
      ),
    );
  } else {
    runApp(
      const MyApp(),
    );
  }
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
          title: 'Cash Van',
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
