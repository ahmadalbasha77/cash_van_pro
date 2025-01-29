import 'package:cash_van_app/controller/invoice/item_controller.dart';
import 'package:cash_van_app/controller/invoice/sales_and_refund_controller.dart';
import 'package:cash_van_app/core/app_color.dart';
import 'package:cash_van_app/model/invoice/cart_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/text_style.dart';
import '../../widget/invoice/item_widget.dart';

class ItemSalesRefundScreen extends StatelessWidget {
  final bool isSales;

  const ItemSalesRefundScreen({super.key, required this.isSales});

  @override
  Widget build(BuildContext context) {
    final controller = ItemController.to;
    final cartController = Get.find<SalesAndRefundController>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Items'.tr),
        centerTitle: true,
        actions: [
          IconButton(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            icon: Text(
              'Done'.tr,
              style: AppTextStyles.bold16.copyWith(color: Colors.white),
            ),
            onPressed: () {
              Get.back();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5),
        child: GetBuilder<ItemController>(
            builder: (logic) => controller.isLoading
                ? const Center(child: CircularProgressIndicator())
                : controller.itemList.isEmpty
                    ? Center(child: Text('No items found.'.tr))
                    : ListView.builder(
                        itemCount: controller.itemList.length,
                        itemBuilder: (context, index) {
                          final item = controller.itemList[index];
                          return ItemWidget(
                              itemName: item.itemName,
                              itemBarcode: item.itemBarcode,
                              salesPriceBeforeTax: item.salesPriceAfterTax,
                              iconButton: GetBuilder<SalesAndRefundController>(
                                builder: (controller) => isSales == true
                                    ? cartController.salesList.any((cartItem) =>
                                            cartItem.itemId == item.itemId)
                                        ? Icon(
                                            Icons.check,
                                            color: AppColor.primaryColor,
                                          )
                                        : IconButton(
                                            onPressed: () {
                                              cartController.addItemSales(
                                                  CartModel(
                                                      itemId: item.itemId,
                                                      priceAfterTax: item
                                                          .salesPriceAfterTax,
                                                      // totalAfterTax: item
                                                      //     .salesPriceAfterTax,
                                                      itemName: item.itemName,
                                                      quantity: 1));
                                            },
                                            icon: Icon(
                                              Icons.add,
                                              color: AppColor.primaryColor,
                                            ))
                                    : cartController.refundList.any(
                                            (cartItem) =>
                                                cartItem.itemId == item.itemId)
                                        ? Icon(
                                            Icons.check,
                                            color: AppColor.primaryColor,
                                          )
                                        : IconButton(
                                            onPressed: () {
                                              cartController.addItemRefund(
                                                  CartModel(
                                                      itemId: item.itemId,
                                                      priceAfterTax: item
                                                          .salesPriceAfterTax,
                                                      // totalAfterTax: item
                                                      //     .salesPriceAfterTax,
                                                      itemName: item.itemName,
                                                      quantity: 1));
                                            },
                                            icon: Icon(
                                              Icons.add,
                                              color: AppColor.primaryColor,
                                            )),
                              ));
                        },
                      )),
      ),
    );
  }
}
