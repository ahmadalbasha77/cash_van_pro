import 'dart:async';
import 'package:cash_van_app/core/app_color.dart';
import 'package:cash_van_app/core/text_style.dart';
import 'package:cash_van_app/core/utils.dart';
import 'package:cash_van_app/model/customers/customers_model.dart';
import 'package:cash_van_app/view/ui/home/customers_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/customers/visit_controller.dart';
import '../../widget/customer/bonds_dialog.dart';
import '../../widget/customer/invoice_dialog.dart';

class VisitScreen extends StatefulWidget {
  const VisitScreen({super.key});

  @override
  State<VisitScreen> createState() => _VisitScreenState();
}

class _VisitScreenState extends State<VisitScreen> {
  late final CustomersModel customer;

  final visitController = VisitController.to;

  @override
  void initState() {
    super.initState();

    customer = Get.arguments as CustomersModel;
    if (visitController.startTimeScreen == null){
      visitController.startVisit();
      visitController.timer = Timer.periodic(const Duration(seconds: 1), (_) {
        visitController.update();
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) return;

        bool exit = await Utils.showAreYouSureDialog(
          title: 'انهاء الزيارة'.tr,
          message: 'هل تريد انهاء الزيارة ؟',
        );

        if (exit) {
          visitController.resetVisit();

          Get.off(() => CustomersScreen());
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('زيارة ${customer.aName}'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              const Icon(Icons.flag, color: Colors.green, size: 40),
              const SizedBox(height: 10),
              const Text(
                'تم بدء الزيارة بنجاح',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                'للعميل ${customer.aName}',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
              Text(
                'مدة الزيارة:',
                style: TextStyle(fontSize: 16, color: Colors.grey[700]),
              ),
              GetBuilder<VisitController>(builder: (logic) {
                return Text(
                  visitController.getElapsedTime(),
                  style: const TextStyle(
                      fontSize: 32, fontWeight: FontWeight.bold),
                );
              }),
              const SizedBox(height: 40),
              ElevatedButton.icon(
                onPressed: () {
                  Get.dialog(InvoiceDialog(customersModel: customer));
                },
                icon: const Icon(Icons.receipt_long, color: Colors.white),
                label: Text(
                  'إنشاء فاتورة',
                  style: AppTextStyles.regular16.copyWith(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.primaryColor,
                  minimumSize: const Size(double.infinity, 50),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () {
                  Get.dialog(BondsDialog(customersModel: customer));
                },
                icon: const Icon(Icons.attach_money, color: Colors.white),
                label: Text(
                  'إنشاء سند',
                  style: AppTextStyles.regular16.copyWith(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange.shade800,
                  minimumSize: const Size(double.infinity, 50),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () async {
                  if (await Utils.showAreYouSureDialog(
                    title: 'انهاء الزيارة',
                    message: 'هل تريد انهاء الزيارة ؟',
                  )) {
                    visitController.resetVisit();
                    Get.off(() => CustomersScreen());
                  }
                },
                icon: const Icon(Icons.exit_to_app, color: Colors.white),
                label: Text(
                  'انهاء الزيارة',
                  style: AppTextStyles.regular16.copyWith(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade800,
                  minimumSize: const Size(double.infinity, 50),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
