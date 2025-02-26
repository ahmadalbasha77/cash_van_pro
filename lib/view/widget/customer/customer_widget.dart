import 'package:cash_van_app/core/app_color.dart';
import 'package:cash_van_app/core/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../model/customers/customers_model.dart';

class CustomersWidget extends StatelessWidget {
  final CustomersModel customer;

  const CustomersWidget({
    super.key,
    required this.customer,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: AppColor.primaryColor.withOpacity(0.3),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: AppColor.primaryColor.withOpacity(0.1),
            child: Text(
              customer.aName[0].toUpperCase(),
              style: AppTextStyles.bold22.copyWith(color: AppColor.primaryColor),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  customer.aName,
                  style: AppTextStyles.bold18.copyWith(color: AppColor.primaryColor),
                ),
                const SizedBox(height: 4),
                Text(
                  "${'Phone'.tr}: ${customer.telephone1}",
                  style: AppTextStyles.semiBold14.copyWith(color: AppColor.primaryColor),
                ),
                const SizedBox(height: 4),
                Text(
                    "${'Balance'.tr}: ${customer.customerBalance.toStringAsFixed(2)}",
                    style: AppTextStyles.semiBold14.copyWith(
                        color: customer.customerBalance < 0
                            ? Colors.red
                            : customer.customerBalance == 0
                                ? Colors.black45
                                : Colors.blue[800])),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
