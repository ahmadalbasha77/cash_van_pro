import 'package:get/get.dart';

import '../../model/customers/customers_model.dart';
import '../../network/rest_api.dart';

class CustomersController extends GetxController {
  static CustomersController get to => Get.isRegistered<CustomersController>()
      ? Get.find<CustomersController>()
      : Get.put(CustomersController());
  final RestApi restApi = RestApi();

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
    update();
    customersList = await restApi.getCustomers();
    filteredCustomersList = customersList;
    isLoading = false;
    update();
  }

  void filterCustomers(String query) {
    if (query.isEmpty) {
      filteredCustomersList = customersList;
    } else {
      filteredCustomersList = customersList
          .where((customer) =>
          customer.aName.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    update();
  }


}
