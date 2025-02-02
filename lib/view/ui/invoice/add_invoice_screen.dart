import 'package:cash_van_app/controller/invoice/cart_controller.dart';
import 'package:cash_van_app/core/app_color.dart';
import 'package:cash_van_app/core/text_style.dart';
import 'package:cash_van_app/view/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../model/customers/customers_model.dart';
import '../../widget/invoice/change_price_dialog.dart';
import '../../widget/invoice/item_order_widget.dart';
import '../../widget/invoice/pay_widget.dart';
import 'category_buttom_sheet.dart';

class AddInvoiceScreen extends StatelessWidget {
  final CustomersModel customersData;
  final String type;
  final bool isSales;

  AddInvoiceScreen(
      {super.key,
      required this.customersData,
      required this.type,
      required this.isSales});

  final _controller = Get.find<CartController>();

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
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Total'.tr, style: AppTextStyles.bold20),
                  GetBuilder<CartController>(builder: (logic) {
                    return Text(_controller.totalCartPrice.toStringAsFixed(2),
                        style: AppTextStyles.bold20
                            .copyWith(color: AppColor.primaryColor));
                  }),
                ],
              ),
            ),
            Expanded(
              child: GetBuilder<CartController>(builder: (logic) {
                return CustomButtonWidget(
                  backgroundColor:
                      _controller.cartList.isEmpty ? Colors.grey : null,
                  title: 'Save',
                  onPressed: () {
                    _controller.cartList.isEmpty
                        ? null
                        : Get.dialog(PaymentDialog(
                            isSales: isSales,
                            customers: customersData,
                          ));
                  },
                );
              }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColor.primaryColor,
        icon: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        label: Text(
          'Add Item'.tr,
          style: AppTextStyles.bold14.copyWith(color: Colors.white),
        ),
        onPressed: () {
          Get.bottomSheet(CategoryBottomSheet());
        },
      ),
      appBar: AppBar(
        title: Text('${'Add'.tr} ${'Invoice'.tr} $type '),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(customersData.aName,
                    style:
                        AppTextStyles.semiBold18.copyWith(color: Colors.black)),
                Text(customersData.customerBalance.toStringAsFixed(2),
                    style: AppTextStyles.bold18.copyWith(
                        color: customersData.customerBalance < 0
                            ? Colors.red
                            : customersData.customerBalance == 0
                                ? Colors.black45
                                : Colors.blue[800])),
              ],
            ),
            const SizedBox(height: 10),
            const Divider(),
            const SizedBox(height: 15),
            Text('${'Items'.tr} :'.tr, style: AppTextStyles.bold16),
            const SizedBox(height: 10),
            Expanded(
              child: GetBuilder<CartController>(
                builder: (logic) => _controller.cartList.isEmpty
                    ? Center(
                        child: Text('No Items'.tr),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.only(bottom: 60),
                        itemCount: _controller.cartList.length,
                        itemBuilder: (context, index) {
                          return ItemOrderWidget(
                              changePrice: () {
                                Get.dialog(ChangePriceDialog(
                                  onTap: () {
                                    _controller.changePriceProduct(
                                        _controller.cartList[index].itemId);
                                  },
                                ));
                              },
                              increaseQuantity: () {
                                _controller.increaseQuantity(
                                    _controller.cartList[index].itemId);
                              },
                              decreaseQuantity: () {
                                if (_controller.cartList[index].quantity == 1) {
                                  _controller.removeItem(
                                      _controller.cartList[index].itemId);
                                } else {
                                  _controller.decreaseQuantity(
                                      _controller.cartList[index].itemId);
                                }
                              },
                              cartModel: _controller.cartList[index]);
                        },
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PaymentDialog extends StatelessWidget {
  final CustomersModel customers;
  final bool isSales;

  const PaymentDialog({
    super.key,
    required this.customers,
    required this.isSales,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Choose payment method".tr),
      content: GetBuilder<CartController>(builder: (logic) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PayWidget(
                    type: 1,
                    title: 'Cash'.tr,
                    onTap: () {
                      logic.updatePaymentType(1);
                    },
                    isSelected: logic.paymentType),
                const SizedBox(width: 20),
                PayWidget(
                    type: 2,
                    title: 'Credit'.tr,
                    onTap: () {
                      logic.updatePaymentType(2);
                    },
                    isSelected: logic.paymentType),
              ],
            ),
            const SizedBox(height: 20),
            CustomButtonWidget(
              backgroundColor:
                  logic.paymentType == 0 ? Colors.grey : AppColor.primaryColor,
              vertical: 5,
              title: 'confirm'.tr,
              onPressed: () {
                logic.paymentType == 0
                    ? null
                    : logic.addInvoice(customer: customers, isRefund: !isSales);
              },
            )
          ],
        );
      }),
    );
  }
}
