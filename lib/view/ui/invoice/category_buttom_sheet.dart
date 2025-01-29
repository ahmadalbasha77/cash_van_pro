import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/invoice/category_controller.dart';
import '../../../core/my_shared_preferences.dart';
import '../../../core/route/routes.dart';
import '../../../core/text_style.dart';

class CategoryBottomSheet extends StatelessWidget {
  final bool? isSalesAndRefund;
  final bool? isSales;

  CategoryBottomSheet(
      {super.key, this.isSalesAndRefund = false, this.isSales = true});

  final controller = CategoryController.to;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Categories'.tr, style: AppTextStyles.bold20),
          const SizedBox(height: 10),
          Expanded(
            child: GetBuilder<CategoryController>(
              builder: (logic) => controller.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : controller.categoryList.isEmpty
                      ? const Center(child: Text('No Data'))
                      : ListView.separated(
                          itemCount: controller.categoryList.length,
                          separatorBuilder: (_, __) => const Divider(),
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(
                                mySharedPreferences.language == 'en'
                                    ? controller.categoryList[index].eName
                                    : controller.categoryList[index].aName,
                                style: AppTextStyles.regular16,
                              ),
                              onTap: () {
                                isSalesAndRefund == true
                                    ? Get.offNamed(
                                        Routes.itemSF,
                                        arguments: isSales!,
                                      )
                                    : Get.offNamed(Routes.item);
                              },
                            );
                          },
                        ),
            ),
          ),
        ],
      ),
    );
  }
}
