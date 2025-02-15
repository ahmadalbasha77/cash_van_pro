import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../model/customers/customers_model.dart';
import '../../network/rest_api.dart';

class CustomersController extends GetxController {
  static CustomersController get to => Get.isRegistered<CustomersController>()
      ? Get.find<CustomersController>()
      : Get.put(CustomersController());
  final RestApi restApi = RestApi();

  final TextEditingController searchController = TextEditingController();
  List<CustomersModel> customersList = [];
  List<CustomersModel> filteredCustomersList = [];

  bool isLoading = false;

  @override
  void onInit() {
    getCustomers();
    super.onInit();
  }

  void getCustomers() async {
    isLoading = true;
    searchController.clear();
    update();
    customersList = await restApi.getCustomers();
    filteredCustomersList = customersList;
    isLoading = false;
    update();
  }

  void filterCustomers() {
    if (searchController.text.isEmpty) {
      filteredCustomersList = customersList;
    } else {
      filteredCustomersList = customersList
          .where((customer) => customer.aName
              .toLowerCase()
              .contains(searchController.text.toLowerCase()))
          .toList();
    }
    update();
  }
}
