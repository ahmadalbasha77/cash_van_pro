import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/utils.dart';
import '../../../model/customers/customers_model.dart';
import 'bonds_dialog.dart';
import 'invoice_dialog.dart';

class SlidableWidget extends StatelessWidget {
  final CustomersModel customersModel;
  final Widget child;

  const SlidableWidget({
    super.key,
    required this.child,
    required this.customersModel,
  });

  @override
  Widget build(BuildContext context) {
    return Slidable(
        closeOnScroll: true,
        useTextDirection: false,
        key: ValueKey(customersModel.id),
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          dragDismissible: false,
          children: [
            SlidableAction(
              spacing: 15,
              onPressed: (context) async {
                Utils.launchNumber(customersModel.telephone1);
              },
              foregroundColor: Colors.black,
              icon: Icons.phone_outlined,
              label: 'call'.tr,
            ),
            SlidableAction(
              spacing: 15,
              // flex: 2,
              onPressed: (context) async {

                String text = '';
                String phoneCustomer = customersModel.telephone1;
                String androidUrl =
                    "whatsapp://send?phone=$phoneCustomer&text=${Uri.encodeComponent(text)}";
                String iosUrl =
                    "https://wa.me/$phoneCustomer?text=${Uri.encodeComponent(text)}";
                String webUrl =
                    "https://api.whatsapp.com/send/?phone=$phoneCustomer&text=${Uri.encodeComponent(text)}";

                try {
                  if (Platform.isIOS) {
                    if (await canLaunchUrl(Uri.parse(iosUrl))) {
                      await launchUrl(Uri.parse(iosUrl),
                          mode: LaunchMode.externalApplication);
                    } else {
                      throw Exception("Cannot launch iOS URL");
                    }
                  } else if (Platform.isAndroid) {
                    if (await canLaunchUrl(Uri.parse(androidUrl))) {
                      await launchUrl(Uri.parse(androidUrl),
                          mode: LaunchMode.externalApplication);
                    } else {
                      throw Exception("Cannot launch Android URL");
                    }
                  }
                } catch (e) {
                  await launchUrl(Uri.parse(webUrl),
                      mode: LaunchMode.externalApplication);
                }

              },

              foregroundColor: Colors.black,
              icon: Icons.message_outlined,
              label: 'Chat'.tr,
            ),
          ],
        ),
        startActionPane: ActionPane(
          motion: const ScrollMotion(),
          dragDismissible: false,
          children: [
            SlidableAction(
              spacing: 15,
              onPressed: (context) async {
                Get.dialog(InvoiceDialog(
                  customersModel: customersModel,
                ));
              },
              foregroundColor: Colors.black,
              icon: Icons.receipt_long_outlined,
              label: 'invoice'.tr,
            ),
            SlidableAction(
              spacing: 15,
              // flex: 2,
              onPressed: (context) async {
                Get.dialog(BondsDialog(
                  customersModel: customersModel,
                ));
              },
              foregroundColor: Colors.black,
              icon: Icons.post_add,
              label: 'Voucher'.tr,
            ),
          ],
        ),
        child: child);
  }
}
