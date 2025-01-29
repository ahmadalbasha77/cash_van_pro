import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:cash_van_app/controller/invoice/item_controller.dart';
import 'package:cash_van_app/core/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItemDropDownWidget extends StatelessWidget {
  final dynamic Function(String?)? onItemSelected;

  ItemDropDownWidget({super.key, required this.onItemSelected});

  final _controller = ItemController.to;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ItemController>(
      builder: (controller) => _controller.isLoading == true
          ? Container(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(),
              ),
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Items'.tr,
                  ),
                  SizedBox(
                    width: 25,
                    height: 25,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: AppColor.primaryColor,
                      strokeAlign: .1,
                    ),
                  ),
                ],
              ),
            )
          : _controller.itemList.isEmpty
              ? Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                  decoration: BoxDecoration(
                    border: Border.all(),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Items'.tr,
                      ),
                      const Text(
                        'No Data',
                      ),
                    ],
                  ),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomDropdown<String>.searchRequest(
                      onChanged: onItemSelected,
                      decoration: CustomDropdownDecoration(
                        closedBorder: Border.all(),
                        closedFillColor: Colors.white,
                        closedBorderRadius: BorderRadius.circular(5),
                      ),
                      futureRequest: _controller.getRequestData,
                      hintText: 'select item'.tr,
                      items:
                          _controller.itemList.map((e) => e.itemName).toList(),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
    );
  }
}
