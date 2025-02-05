import 'package:cash_van_app/controller/invoice/item_controller.dart';
import 'package:cash_van_app/core/app_color.dart';
import 'package:cash_van_app/core/text_style.dart';
import 'package:cash_van_app/model/invoice/cart_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/proposal/proposal_controller.dart';
import '../../widget/custom_button.dart';

class ProposalScreen extends StatelessWidget {
  ProposalScreen({super.key});

  final _controller = ItemController.to;
  final proposalController = Get.put(ProposalController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 8,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: CustomButtonWidget(
          title: 'Save',
          onPressed: () {},
        ),
      ),
      appBar: AppBar(
        title: const Text(
          'Proposal Price',
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GetBuilder<ItemController>(
            builder: (logic) => _controller.isLoading == true
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
                          childAspectRatio: 0.8,
                        ),
                        itemBuilder: (context, index) {
                          final item = _controller.itemList[index];
                          return GetBuilder<ProposalController>(
                              builder: (logic) {
                            return ProposalItemWidget(
                              title: proposalController.cartList.any(
                                      (cartItem) =>
                                          cartItem.itemId == item.itemId)
                                  ? 'Added'
                                  : 'Add to cart',
                              background: proposalController.cartList.any(
                                      (cartItem) =>
                                          cartItem.itemId == item.itemId)
                                  ? Colors.grey[400]!
                                  : AppColor.primaryColor,
                              name: item.itemName,
                              onTap: () {
                                !proposalController.cartList.any((cartItem) =>
                                        cartItem.itemId == item.itemId)
                                    ? proposalController.addItem(CartModel(
                                        itemId: item.itemId,
                                        itemName: item.itemName,
                                        priceAfterTax: item.salesPriceBeforeTax,
                                        quantity: 1))
                                    : proposalController
                                        .removeItem(item.itemId);
                              },
                              price: item.wholeSalesPrice,
                            );
                          });
                        },
                      )),
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
                  style: AppTextStyles.bold18,
                  textAlign: TextAlign.center,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text('$price JOD', style: AppTextStyles.bold16),
            const SizedBox(height: 15),
            GetBuilder<ProposalController>(builder: (c) {
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
