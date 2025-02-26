import 'package:cash_van_app/core/my_shared_preferences.dart';
import 'package:cash_van_app/network/rest_api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/utils.dart';
import 'customers_controller.dart';

class AddCustomerController extends GetxController {
  static AddCustomerController get to =>
      Get.isRegistered<AddCustomerController>()
          ? Get.find<AddCustomerController>()
          : Get.put(AddCustomerController());

  final RestApi restApi = RestApi();
  final TextEditingController name = TextEditingController();

  final TextEditingController phone = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey();

  void addCustomer() async {
    if (formKey.currentState!.validate()) {
      // Get.closeCurrentSnackbar();
      Utils.showLoadingDialog();

      bool? result = await restApi.addCustomer({
        "Name": name.text,
        "Address": "a",
        "Telephone1": phone.text,
        "Telephone2": "a",
        "XLocation": "a",
        "YLocation": "a",
        "UserID": mySharedPreferences.getUserData()!.id.toString(),
        "BranchID": mySharedPreferences.getUserData()!.branchId.toString(),
        "StoreID": mySharedPreferences.getUserData()!.storeId.toString()
      });
      // bool result = true;
      if (result == true) {
        Utils.hideLoadingDialog();

        final controller = CustomersController.to;
        controller.getCustomers();
        Get.back();
        Utils.showSnackbar('Success', 'Customer added successfully');
      } else if (result == false) {
        Utils.hideLoadingDialog();
        Utils.showSnackbar(
            'Failed', 'An error occurred while adding the customer');
      } else {}
    }
  }
}
