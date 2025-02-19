import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/route/routes.dart';
import '../../../core/text_style.dart';
import '../../../model/customers/customers_model.dart';
import '../../ui/quotation history/customer_quotation_history_screen.dart';

class InvoiceDialog extends StatelessWidget {
  final CustomersModel customersModel;

  const InvoiceDialog({super.key, required this.customersModel});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              textAlign: TextAlign.center,
              '${'Invoice for'.tr} ${customersModel.aName}',
              style: AppTextStyles.bold20,
            ),
            const SizedBox(
              height: 10,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              child: SizedBox(
                width: 20,
              ),
            ),
            ListTile(
              leading: const Icon(Icons.add_shopping_cart_outlined),
              title: Text(
                'Quotation'.tr,
                style: AppTextStyles.regular16,
              ),
              onTap: () {
                Get.off(
                  () => CustomerQuotationHistoryScreen(
                    customer: customersModel,
                  ),
                  arguments: {'id': customersModel.id.toString()},
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.add_box_outlined),
              title: Text(
                'Sales invoice'.tr,
                style: AppTextStyles.regular16,
              ),
              onTap: () {
                Get.offNamed(
                  Routes.addInvoice,
                  arguments: {
                    'isSales': true,
                    'type': 'Sales'.tr,
                    'customersData': customersModel,
                  },
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.reset_tv),
              title: Text(
                'Return invoice'.tr,
                style: AppTextStyles.regular16,
              ),
              onTap: () {
                Get.offNamed(
                  Routes.addInvoice,
                  arguments: {
                    'isSales': false,
                    'type': 'Refunds'.tr,
                    'customersData': customersModel,
                  },
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.add_chart),
              title: Text(
                'New and return invoice'.tr,
                style: AppTextStyles.regular16,
              ),
              onTap: () {
                Get.offNamed(Routes.addInvoiceSF, arguments: customersModel);
              },
            ),
          ],
        ),
      ),
    );
  }
}
