import 'package:cash_van_app/core/text_style.dart';
import 'package:cash_van_app/view/ui/voucher/cach_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/route/routes.dart';
import '../../../model/customers/customers_model.dart';

class BondsDialog extends StatelessWidget {
  final CustomersModel customersModel;

  const BondsDialog({super.key, required this.customersModel});

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
              '${'Voucher for'.tr} ${customersModel.aName}',
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
              leading: const Icon(Icons.payments_outlined),
              title: Text(
                'Cash Voucher'.tr,
                style: AppTextStyles.regular16,
              ),
              onTap: () {
                Get.back();
                Get.dialog(CashDialog(
                  customer: customersModel,
                ));
              },
            ),
            ListTile(
              leading: const Icon(Icons.credit_card),
              title: Text(
                'Cheque Voucher'.tr,
                style: AppTextStyles.regular16,
              ),
              onTap: () {
                Get.offNamed(Routes.addCheque, arguments: customersModel);
              },
            ),
          ],
        ),
      ),
    );
  }
}
