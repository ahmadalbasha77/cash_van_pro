import 'package:cash_van_app/core/text_style.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'app_color.dart';
import 'my_shared_preferences.dart';

class Utils {
  static bool isNotEmpty(String? s) => s != null && s.isNotEmpty;

  static bool isEmpty(String? s) => s == null || s.isEmpty;

  static showSnackbar(String title, String message) {
    hideLoadingDialog();
    Get.snackbar(
      title.tr,
      message.tr,
      duration: const Duration(seconds: 4),
      backgroundColor: Colors.grey[100],
      margin: const EdgeInsets.only(top: 20, left: 10, right: 10),
    );
  }

  static showLoadingDialog([String? text]) {
    if (Get.isSnackbarOpen) {
      Get.closeAllSnackbars();
    }
    if (!Get.isDialogOpen!) {
      Get.dialog(
        PopScope(
          onPopInvoked: (reason) async => true,
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        ),
        barrierDismissible: false,
        useSafeArea: false,
      );
    }
  }

  static Future<bool> showAreYouSureDialog(
      {required String title, String? message}) async {
    var result = await Get.defaultDialog(
      backgroundColor: Colors.white,
      title: title.tr,
      content: Text(
        textAlign: TextAlign.center,
        message?.tr ?? 'Are you sure?'.tr,
        style: AppTextStyles.regular16,
      ),
      textCancel: 'Cancel'.tr,
      textConfirm: 'Confirm'.tr,
      titleStyle: AppTextStyles.bold18,
      confirmTextColor: Colors.white,
      buttonColor: AppColor.primaryColor,
      cancelTextColor: AppColor.primaryColor,
      onConfirm: () {
        Get.back(result: true);
      },
      barrierDismissible: true,
    );
    return result ?? false;
  }

  static void hideLoadingDialog() {
    if (Get.isDialogOpen!) {
      Get.back();
    }
  }

  static String formatDate(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  static showFlutterToast(String message) {
    Fluttertoast.showToast(
        msg: message.tr,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  static void showBottomSheet(Widget widget) {
    Get.bottomSheet(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: Colors.white,
        isScrollControlled: true,
        widget);
  }

  static Future<void> launchURL(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }

  static Future<void> launchNumber(String url) async {
    launchUrlString("tel://$url");
  }

  static Future<void> openMap(double latitude, double longitude) async {
    final Uri googleUrl = Uri.parse(
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude');

    if (await canLaunchUrl(googleUrl)) {
      await launchUrl(googleUrl, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not open the map.';
    }
  }

  static void changeLanguage() {
    Get.defaultDialog(
      title: 'Language'.tr,
      content: Column(
        children: [
          ListTile(
            onTap: () {
              mySharedPreferences.language = 'en';
              Get.updateLocale(Locale(mySharedPreferences.language));
              Get.back();
            },
            title: const Text('English'),
          ),
          ListTile(
            onTap: () {
              mySharedPreferences.language = 'ar';
              Get.updateLocale(Locale(mySharedPreferences.language));
              Get.back();
            },
            title: const Text('العربية'),
          ),
        ],
      ),
      barrierDismissible: true,
    );
  }

  static Future<String> fromDateSelected(TextEditingController from,
      TextEditingController to, BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: to.text.isNotEmpty
          ? DateFormat('yyyy-MM-dd').parse(from.text)
          : DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: to.text.isNotEmpty
          ? DateFormat('yyyy-MM-dd').parse(to.text)
          : DateTime.now(),
    );

    if (pickedDate != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);

      return formattedDate;
    } else {
      return '';
    }
  }

  static Future<String> toDateSelected(TextEditingController from,
      TextEditingController to, BuildContext context) async {
    if (from.text.isEmpty) {
      Utils.showFlutterToast('Enter the from date first'.tr);
      return '';
    } else {
      DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: to.text.isNotEmpty
            ? DateFormat('yyyy-MM-dd').parse(to.text)
            : DateTime.now(),
        firstDate: from.text.isNotEmpty
            ? DateFormat('yyyy-MM-dd').parse(from.text)
            : DateTime(2000),
        lastDate: DateTime.now(),
      );

      if (pickedDate != null) {
        String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);

        return formattedDate;
      } else {
        return '';
      }
    }
  }
}
