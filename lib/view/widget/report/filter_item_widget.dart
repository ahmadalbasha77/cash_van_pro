import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/invoice/item_controller.dart';
import '../../../core/app_color.dart';
import '../../../core/utils.dart';
import '../auth/custom_text_filed.dart';


class FilterItemReport extends StatelessWidget {
  const FilterItemReport({super.key});

  @override
  Widget build(BuildContext context) {
    String? selectedClient;

    final controller = ItemController.to;

    final TextEditingController fromDateController = TextEditingController();
    final TextEditingController toDateController = TextEditingController();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: CustomTextFiledWidget(
                  readOnly: true,
                  suffixIcon: Icon(
                    Icons.calendar_month,
                    color: AppColor.primaryColor,
                  ),
                  onTap: () async {
                    String date = await Utils.fromDateSelected(
                        fromDateController, toDateController, context);
                    if (date.isNotEmpty) {
                      fromDateController.text = date;
                    }
                  },
                  controller: fromDateController,
                  label: 'From Date',
                ),
              ),
              const SizedBox(width: 15),
              const Icon(
                Icons.sync_alt,
                color: Colors.black54,
              ),
              const SizedBox(width: 15),
              Expanded(
                child: CustomTextFiledWidget(
                  readOnly: true,
                  suffixIcon: Icon(
                    Icons.calendar_month,
                    color: AppColor.primaryColor,
                  ),
                  onTap: () async {
                    String date = await Utils.toDateSelected(
                        fromDateController, toDateController, context);
                    if (date.isNotEmpty) {
                      toDateController.text = date;
                    }
                  },
                  controller: toDateController,
                  label: 'To Date',
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          GetBuilder<ItemController>(builder: (logic) {
            return DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Item Name'.tr,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              isExpanded: true,
              value: selectedClient,
              icon: controller.isLoading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 3,
                      ))
                  : const Icon(Icons.arrow_drop_down),
              items: controller.itemList
                  .map((item) => DropdownMenuItem(
                      value: item.itemId.toString(),
                      child: Text(item.itemName)))
                  .toList(),
              onChanged: (value) {
                selectedClient = value;
              },
            );
          }),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              style: ButtonStyle(
                  padding: const WidgetStatePropertyAll(
                      EdgeInsets.symmetric(vertical: 15)),
                  backgroundColor:
                      WidgetStatePropertyAll(AppColor.primaryColor)),
              onPressed: () {},
              icon: const Icon(
                Icons.search,
                color: Colors.white,
              ),
              label: const Text(
                'Show',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
