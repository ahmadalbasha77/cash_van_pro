import 'package:cash_van_app/core/app_color.dart';
import 'package:cash_van_app/core/my_shared_preferences.dart';
import 'package:cash_van_app/core/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/invoice/cart_controller.dart';
import '../../../controller/invoice/item_by_categoryid_controller.dart';
import '../../../model/invoice/cart_model.dart';
import '../../widget/invoice/item_widget.dart';
import '../../widget/invoice/select_quantity_widget.dart';
import '../../widget/search_text_filed_widget.dart';

class ItemScreen extends StatelessWidget {
  final int categoryId;

  const ItemScreen({super.key, required this.categoryId});

  @override
  Widget build(BuildContext context) {
    final controller = ItemByCategoryIdController.to;
    final cartController = Get.find<CartController>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Items'.tr),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Text(
              'Done'.tr,
              style: AppTextStyles.bold16.copyWith(color: Colors.white),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            onPressed: () {
              Get.back();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5),
        child: Column(
          children: [
            SearchTextFiledWidget(
              controller: controller.searchController,
              hintText: 'Search items...',
              onChanged: (p0) {
                controller.getItem();
              },
            ),
            Expanded(
              child: GetBuilder<ItemByCategoryIdController>(
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
                                    salesPriceBeforeTax:
                                        mySharedPreferences.wholesalePrice
                                            ? item.wholeSalesPrice
                                            : item.salesPriceAfterTax,
                                    iconButton: GetBuilder<CartController>(
                                      builder: (controller) => cartController
                                              .cartList
                                              .any((cartItem) =>
                                                  cartItem.itemId ==
                                                  item.itemId)
                                          ? Icon(
                                              Icons.check,
                                              color: AppColor.primaryColor,
                                            )
                                          : IconButton(
                                              onPressed: () {
                                                Get.dialog(
                                                        const SelectQuantityWidget())
                                                    .then((selectedQuantity) {
                                                  if (selectedQuantity !=
                                                          null &&
                                                      selectedQuantity > 0) {
                                                    cartController.addItem(
                                                      CartModel(
                                                        itemId: item.itemId,
                                                        priceAfterTax: mySharedPreferences
                                                                .wholesalePrice
                                                            ? item
                                                                .wholeSalesPrice
                                                            : item
                                                                .salesPriceAfterTax,
                                                        itemName: item.itemName,
                                                        quantity:
                                                            selectedQuantity,
                                                      ),
                                                    );
                                                  }
                                                });
                                                // cartController.addItem(CartModel(
                                                //     itemId: item.itemId,
                                                //     priceAfterTax:
                                                //         item.salesPriceAfterTax,
                                                //     // totalAfterTax:
                                                //     //     item.salesPriceAfterTax,
                                                //     itemName: item.itemName,
                                                //     quantity: 1));
                                              },
                                              icon: Icon(
                                                Icons.add,
                                                color: AppColor.primaryColor,
                                              )),
                                    ));
                              },
                            )),
            ),
          ],
        ),
      ),
    );
  }
}
