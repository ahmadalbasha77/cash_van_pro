import 'package:cash_van_app/core/app_color.dart';
import 'package:cash_van_app/core/text_style.dart';
import 'package:cash_van_app/model/invoice/cart_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../controller/quotation/category_quotation_controller.dart';
import '../../../controller/quotation/item_by_category_id_quotation_controller.dart';
import '../../../controller/quotation/quotation_edit_controller.dart';
import '../../widget/custom_button.dart';
import '../../widget/invoice/select_quantity_widget.dart';
import '../../widget/search_text_filed_widget.dart';

class ItemQuotationScreen extends StatelessWidget {
  // final CustomersModel customersData;

  ItemQuotationScreen({
    super.key,
  });

  final _controller = ItemByCategoryIdQuotationController.to;
  final _controllerCategory = CategoryQuotationController.to;
  final proposalController = Get.put(QuotationEditController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomNavigationBar: Container(
      //   padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      //   decoration: const BoxDecoration(
      //     color: Colors.white,
      //     boxShadow: [
      //       BoxShadow(
      //         color: Colors.black26,
      //         blurRadius: 8,
      //         offset: Offset(0, -2),
      //       ),
      //     ],
      //   ),
      //   child: CustomButtonWidget(
      //     title: 'Save',
      //     onPressed: () {
      //       Get.back();
      //     },
      //   ),
      // ),
      appBar: AppBar(
        title: Text(
          'Items'.tr,
        ),
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
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            GetBuilder<ItemByCategoryIdQuotationController>(builder: (logic) {
              return SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.05,
                child: GetBuilder<CategoryQuotationController>(
                    builder: (logic) => _controllerCategory.isLoading
                        ? ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 5, // Placeholder shimmer count
                            itemBuilder: (context, index) => Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[100]!,
                              child: Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                width: 80,
                                height: 20, // Adjust height as needed
                              ),
                            ),
                          )
                        : _controllerCategory.categoryList.isEmpty
                            ? Center(
                                child: Text('No Found Data'.tr),
                              )
                            : ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount:
                                    _controllerCategory.categoryList.length,
                                itemBuilder: (context, index) =>
                                    GestureDetector(
                                  onTap: () {
                                    if (_controller.categoryId !=
                                        _controllerCategory
                                            .categoryList[index].id) {
                                      _controller.categoryId =
                                          _controllerCategory
                                              .categoryList[index].id;
                                      _controller.getItem();
                                    }
                                  },
                                  child: FittedBox(
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 10),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: _controller.categoryId ==
                                                      _controllerCategory
                                                          .categoryList[index]
                                                          .id
                                                  ? AppColor.primaryColor
                                                  : Colors.black26,
                                              width: 1),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Text(_controllerCategory
                                          .categoryList[index].aName),
                                    ),
                                  ),
                                ),
                              )),
              );
            }),
            SearchTextFiledWidget(
              controller: _controller.searchController,
              hintText: 'Search items...',
              onChanged: _controller.onSearchChanged
            ),
            Expanded(
              child: GetBuilder<ItemByCategoryIdQuotationController>(
                  builder: (logic) {
                return _controllerCategory.categoryList.isEmpty
                    ? const SizedBox.shrink()
                    : _controller.isLoading == true
                        ? const Center(child: CircularProgressIndicator())
                        : _controller.itemList.isEmpty
                            ? const Center(
                                child: Text('No Found Data'),
                              )
                            : GridView.builder(
                                itemCount: _controller.itemList.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 15,
                                  mainAxisSpacing: 15,
                                  childAspectRatio: 0.7,
                                ),
                                itemBuilder: (context, index) {
                                  final item = _controller.itemList[index];
                                  return GetBuilder<QuotationEditController>(
                                      builder: (logic) {
                                    return ProposalItemWidget(
                                      title: proposalController.cartList.any(
                                              (cartItem) =>
                                                  cartItem.itemId ==
                                                  item.itemId)
                                          ? 'Added'.tr
                                          : 'Add'.tr,
                                      background: proposalController.cartList
                                              .any((cartItem) =>
                                                  cartItem.itemId ==
                                                  item.itemId)
                                          ? Colors.grey[400]!
                                          : AppColor.primaryColor,
                                      name: item.itemName,
                                      onTap: () {
                                        !proposalController.cartList.any(
                                                (cartItem) =>
                                                    cartItem.itemId ==
                                                    item.itemId)
                                            ? Get.dialog(
                                                    const SelectQuantityWidget())
                                                .then((selectedQuantity) {
                                                proposalController.addItem(
                                                    CartModel(
                                                        itemId: item.itemId,
                                                        itemName: item.itemName,
                                                        priceAfterTax: item
                                                            .salesPriceAfterTax,
                                                        quantity:
                                                            selectedQuantity));
                                              })
                                            : proposalController
                                                .removeItem(item.itemId);
                                      },
                                      price: item.salesPriceAfterTax,
                                    );
                                  });
                                },
                              );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class ProposalItemWidget extends StatelessWidget {
  final String name;
  final double price;
  final void Function() onTap;
  final Color background;
  final String title;

  const ProposalItemWidget(
      {super.key,
      required this.name,
      required this.price,
      required this.onTap,
      required this.background,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 6,
      shadowColor: Colors.blueAccent.withOpacity(0.3),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Center(
                child: Text(
                  name,
                  style: AppTextStyles.bold16,
                  textAlign: TextAlign.center,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text('$price JOD', style: AppTextStyles.bold16),
            const SizedBox(height: 15),
            GetBuilder<QuotationEditController>(builder: (c) {
              return CustomButtonWidget(
                backgroundColor: background,
                vertical: 10,
                horizontal: 15,
                textStyle: AppTextStyles.bold14.copyWith(color: Colors.white),
                title: title,
                onPressed: onTap,
              );
            }),
          ],
        ),
      ),
    );
  }
}
