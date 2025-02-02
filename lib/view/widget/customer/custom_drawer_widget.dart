import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/drawer_controller.dart';
import '../../../core/app_color.dart';
import '../../../core/my_shared_preferences.dart';
import '../../../core/route/routes.dart';
import '../../../core/text_style.dart';
import '../../../core/utils.dart';
import 'drawer_widget.dart';

class CustomDrawerWidget extends StatelessWidget {
  const CustomDrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final BatteryController batteryController = Get.put(BatteryController());

    return Drawer(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 20),
                alignment: Alignment.center,
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: AppColor.primaryColor.withOpacity(0.1),
                  child: Text(
                    mySharedPreferences
                        .getUserData()!
                        .eName
                        .substring(0, 2)
                        .toUpperCase(),
                    style: AppTextStyles.bold32
                        .copyWith(color: AppColor.primaryColor),
                  ),
                ),
              ),
              Text(
                mySharedPreferences.language == 'en'
                    ? mySharedPreferences.getUserData()!.eName
                    : mySharedPreferences.getUserData()!.aName,
                style: AppTextStyles.semiBold22,
              ),
              Text(
                '@${mySharedPreferences.getUserData()!.userName}',
                style:
                    AppTextStyles.regular16.copyWith(color: Colors.grey[500]),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.battery_0_bar,
                    color: AppColor.primaryColor,
                    size: 18,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Obx(() => Text(
                        '${batteryController.batteryLevel.value}%',
                        style: AppTextStyles.regular16
                            .copyWith(color: Colors.black45),
                      )),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text('${mySharedPreferences.getUserData()!.totalCollecting}',
                  style: AppTextStyles.regular18
                      .copyWith(color: AppColor.primaryColor)),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    DrawerWidget(
                      title: 'Reports',
                      iconData: Icons.description_outlined,
                      onTap: () {
                        Get.toNamed(Routes.report);
                      },
                    ),
                    // Divider(color: Colors.grey[300]),
                    // DrawerWidget(
                    //   title: 'Transaction History',
                    //   iconData: Icons.history,
                    //   onTap: () {
                    //     Get.toNamed(Routes.history);
                    //   },
                    // ),
                    Divider(color: Colors.grey[300]),
                    DrawerWidget(
                      title: 'Settings',
                      iconData: Icons.settings_outlined,
                      onTap: () {
                        Get.toNamed(Routes.settings);
                      },
                    ),
                    Divider(color: Colors.grey[300]),
                    DrawerWidget(
                      title: 'Language',
                      iconData: Icons.language_outlined,
                      onTap: () {
                        Utils.changeLanguage();
                      },
                    ),
                    Divider(color: Colors.grey[300]),
                    DrawerWidget(
                      title: 'Logout',
                      iconData: Icons.login_outlined,
                      onTap: () async {
                        if (await Utils.showAreYouSureDialog(
                            title: 'Log out'.tr)) {
                          mySharedPreferences.clearProfile();
                          return Get.offAllNamed(Routes.login);
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
