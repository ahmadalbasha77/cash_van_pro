import 'package:cash_van_app/view/ui/report/customer%20report/account_statements_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/report/report_controller.dart';
import '../../../core/route/routes.dart';
import '../../widget/report/report_widget.dart';
import '../../widget/report/sub_report_widget.dart';

class ReportScreen extends StatelessWidget {
  ReportScreen({super.key});

  final ReportController controller = Get.put(ReportController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reports'.tr),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              Obx(() => ReportWidget(
                    active: controller.isActive.value,
                    title: 'Sales Reports',
                    icon: Icons.bar_chart,
                    onTap: controller.toggleSalesReports,
                  )),
              Obx(() => controller.isActive.value
                  ? Column(
                      children: [
                        SubReportWidget(
                          icon: Icons.description_outlined,
                          title: 'Invoice Report',
                          onTap: () {
                            Get.toNamed(Routes.invoiceSalesReport);
                          },
                        ),
                        // SubReportWidget(
                        //   icon: Icons.today_outlined,
                        //   title: 'Daily Sales Report',
                        //   onTap: () {
                        //     Get.toNamed(Routes.dailySalesReport);
                        //   },
                        // ),
                        // SubReportWidget(
                        //   icon: Icons.category_outlined,
                        //   title: 'Item Report',
                        //   onTap: () {
                        //     Get.toNamed(Routes.itemSalesReport);
                        //   },
                        // ),
                        // SubReportWidget(
                        //   icon: Icons.sell_outlined,
                        //   title: 'Total Sales Report',
                        //   onTap: () {
                        //     Get.toNamed(Routes.totalSalesReport);
                        //   },
                        // ),
                      ],
                    )
                  : const SizedBox.shrink()),
              const SizedBox(height: 16),
              Obx(() => ReportWidget(
                    active: controller.isActiveRefunds.value,
                    title: 'Refunds Reports',
                    icon: Icons.refresh,
                    onTap: controller.toggleRefundsReports,
                  )),
              Obx(() => controller.isActiveRefunds.value
                  ? Column(
                      children: [
                        SubReportWidget(
                          icon: Icons.description_outlined,
                          title: 'Invoice Report',
                          onTap: () {
                            Get.toNamed(Routes.invoiceRefundReport);
                          },
                        ),
                        // SubReportWidget(
                        //   icon: Icons.today_outlined,
                        //   title: 'Daily Refunds Report',
                        //   onTap: () {},
                        // ),
                        // SubReportWidget(
                        //   icon: Icons.category_outlined,
                        //   title: 'Item Report',
                        //   onTap: () {
                        //     Get.toNamed(Routes.itemRefundReport);
                        //   },
                        // ),
                        // SubReportWidget(
                        //   icon: Icons.sell_outlined,
                        //   title: 'Total Refunds Report',
                        //   onTap: () {
                        //     Get.toNamed(Routes.totalRefundReport);
                        //   },
                        // ),
                      ],
                    )
                  : const SizedBox.shrink()),
              const SizedBox(height: 16),
              Obx(() => ReportWidget(
                    active: controller.isActiveVouchers.value,
                    title: 'Vouchers Reports',
                    icon: Icons.attach_money,
                    onTap: controller.toggleVouchersReports,
                  )),
              Obx(() => controller.isActiveVouchers.value
                  ? Column(
                      children: [
                        SubReportWidget(
                          icon: Icons.payments_outlined,
                          title: 'Cash Voucher Reports',
                          onTap: () {
                            Get.toNamed(Routes.cashVoucherReport);
                          },
                        ),
                        SubReportWidget(
                          icon: Icons.credit_card_outlined,
                          title: 'Cheque Voucher Reports',
                          onTap: () {
                            Get.toNamed(Routes.chequeVoucherReport);
                          },
                        ),
                      ],
                    )
                  : Container()),
              const SizedBox(height: 16),
              Obx(() => ReportWidget(
                    active: controller.isActiveCustomers.value,
                    title: 'Customers Reports',
                    icon: Icons.people_rounded,
                    onTap: controller.toggleCustomersReports,
                  )),
              Obx(() => controller.isActiveCustomers.value
                  ? Column(
                      children: [
                        SubReportWidget(
                          icon: Icons.insert_chart_outlined,
                          title: 'Customers account statements',
                          onTap: () {
                            Get.to(() => AccountStatementsScreen());
                          },
                        ),
                        // SubReportWidget(
                        //   icon: Icons.trending_up_outlined,
                        //   title: 'Best Seller',
                        //   onTap: () {},
                        // ),
                        // SubReportWidget(
                        //   icon: Icons.trending_down,
                        //   title: 'Lowest Seller',
                        //   onTap: () {},
                        // ),
                      ],
                    )
                  : const SizedBox.shrink()),
              const SizedBox(height: 16),
              // Obx(() => ReportWidget(
              //       active: controller.isActiveStock.value,
              //       title: 'Stock Reports',
              //       icon: Icons.store,
              //       onTap: controller.toggleStockReports,
              //     )),
              // Obx(() => controller.isActiveStock.value
              //     ? Column(
              //         children: [
              //           SubReportWidget(
              //             icon: Icons.inventory_2_outlined,
              //             title: 'Stock Balance',
              //             onTap: () {
              //               Get.toNamed(Routes.stockBalance);
              //             },
              //           ),
              //         ],
              //       )
              //     : const SizedBox.shrink()),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
