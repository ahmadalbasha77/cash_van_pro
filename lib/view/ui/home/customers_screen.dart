import 'package:cash_van_app/controller/customers/customers_controller.dart';
import 'package:cash_van_app/core/my_shared_preferences.dart';
import 'package:cash_van_app/core/text_style.dart';
import 'package:cash_van_app/view/widget/search_text_filed_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../core/app_color.dart';
import '../../../core/route/routes.dart';
import '../../widget/customer/custom_drawer_widget.dart';
import '../../widget/customer/customer_widget.dart';

import '../../widget/customer/slidable_widget.dart';

class CustomersScreen extends StatelessWidget {
  CustomersScreen({super.key});

  final controller = CustomersController.to;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: IconButton(
          style: ButtonStyle(
              shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
              backgroundColor: WidgetStatePropertyAll(AppColor.primaryColor)),
          onPressed: () {
            Get.toNamed(Routes.addCustomer);
          },
          icon: Icon(
            Icons.add,
            size: 38 * mySharedPreferences.fontSize,
            color: Colors.white,
          )),
      drawer: const CustomDrawerWidget(),
      appBar: AppBar(
        elevation: 0,
        surfaceTintColor: AppColor.primaryColor,
        shadowColor: AppColor.primaryColor,
        backgroundColor: AppColor.primaryColor,
        title: Text(
          "Customers".tr,
          style:
              const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      body: Column(
        children: [
          SearchTextFiledWidget(
            backgroundColor: AppColor.primaryColor,
            hintText: 'Search customers...',
            onChanged: (p0) => controller.filterCustomers(p0),
          ),
          Expanded(
            child: GetBuilder<CustomersController>(
              builder: (logic) => controller.isLoading == true
                  ? const Center(child: CircularProgressIndicator())
                  : controller.filteredCustomersList.isEmpty
                      ? Center(
                          child: Text(
                          'No Customers'.tr,
                          style: AppTextStyles.semiBold16,
                        ))
                      : SmartRefresher(
                          controller: RefreshController(),
                          onRefresh: () {
                            controller.getCustomers();
                          },
                          child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            padding: const EdgeInsets.all(16),
                            itemCount: controller.filteredCustomersList.length,
                            itemBuilder: (context, index) {
                              return SlidableWidget(
                                  customersModel:
                                      controller.filteredCustomersList[index],
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    child: CustomersWidget(
                                      customer: controller
                                          .filteredCustomersList[index],
                                    ),
                                  ));
                            },
                          ),
                        ),
            ),
          ),
        ],
      ),
    );
  }
}
