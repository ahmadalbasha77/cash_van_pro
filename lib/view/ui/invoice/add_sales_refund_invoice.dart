import 'package:cash_van_app/controller/invoice/sales_and_refund_controller.dart';
import 'package:cash_van_app/core/app_color.dart';
import 'package:cash_van_app/core/text_style.dart';
import 'package:cash_van_app/view/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utils.dart';
import '../../../model/customers/customers_model.dart';
import '../../widget/auth/custom_text_filed.dart';
import '../../widget/invoice/change_price_sales_refund_dialog.dart';
import '../../widget/invoice/item_order_widget.dart';
import '../../widget/invoice/pay_widget.dart';
import 'category_buttom_sheet.dart';

class AddSalesRefundInvoice extends StatelessWidget {
  final CustomersModel customersData;

  AddSalesRefundInvoice({
    super.key,
    required this.customersData,
  });

  final _controller = Get.find<SalesAndRefundController>();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: PopScope(
        canPop: false,
        onPopInvoked: (didPop) async {
          if (didPop) return;

          bool exit = await Utils.showAreYouSureDialog(
              title: 'Warning'.tr,
              message:
                  'Added items will be removed. Are you sure you want to exit?');
          if (exit) {
            Get.back();
          }
        },
        child: Scaffold(
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
            child: GetBuilder<SalesAndRefundController>(builder: (logic) {
              return Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Total'.tr, style: AppTextStyles.bold20),
                        Text(_controller.totalPrice.toStringAsFixed(3),
                            style: AppTextStyles.bold20.copyWith(
                                color: _controller.totalPrice == 0
                                    ? Colors.black54
                                    : _controller.totalPrice < 0
                                        ? Colors.red
                                        : AppColor.primaryColor)),
                      ],
                    ),
                  ),
                  Expanded(
                    child: CustomButtonWidget(
                      title: 'Save',
                      backgroundColor: _controller.refundList.isEmpty &&
                              _controller.salesList.isEmpty
                          ? Colors.grey
                          : AppColor.primaryColor,
                      onPressed: () {
                        _controller.refundList.isEmpty &&
                                _controller.salesList.isEmpty
                            ? Utils.showFlutterToast('Please add items'.tr)
                            : Get.dialog(PaymentDialog(
                                customers: customersData,
                              ));
                      },
                    ),
                  ),
                ],
              );
            }),
          ),
          appBar: AppBar(
            title: Text('Add Sales and Refund Invoice'.tr),
            bottom: TabBar(
              unselectedLabelStyle:
                  AppTextStyles.regular14.copyWith(color: Colors.white),
              labelStyle: AppTextStyles.bold18.copyWith(color: Colors.white),
              tabs: [
                Tab(text: 'Sales'.tr),
                Tab(text: 'Refunds'.tr),
              ],
            ),
          ),
          body: Column(
            children: [
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(customersData.aName,
                        style: AppTextStyles.semiBold18
                            .copyWith(color: Colors.black)),
                    Text(customersData.customerBalance.toStringAsFixed(2),
                        style: AppTextStyles.bold18.copyWith(
                            color: customersData.customerBalance < 0
                                ? Colors.red
                                : customersData.customerBalance == 0
                                    ? Colors.black45
                                    : Colors.blue[800])),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              const Divider(),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: CustomTextFiledWidget(
                    radius: 20,
                    controller: _controller.noteController,
                    hint: 'Enter Note',
                    label: 'Add Note (optional)'),
              ),
              const SizedBox(height: 15),
              Expanded(
                child: TabBarView(
                  children: [
                    // Sales Section
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GetBuilder<SalesAndRefundController>(
                                  builder: (logic) {
                                return Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          '${'Sales Items'.tr} (${_controller.salesList.length}) :'
                                              .tr,
                                          style: AppTextStyles.bold16),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                          '${'Total Sales'.tr} : ${_controller.totalSalesPrice.toStringAsFixed(3)}'
                                              .tr,
                                          style: AppTextStyles.bold14),
                                    ],
                                  ),
                                );
                              }),
                              TextButton.icon(
                                icon: Icon(
                                  Icons.add,
                                  color: AppColor.primaryColor,
                                ),
                                label: Text(
                                  'Add Item'.tr,
                                  style: AppTextStyles.bold14
                                      .copyWith(color: AppColor.primaryColor),
                                ),
                                onPressed: () {
                                  Get.bottomSheet(CategoryBottomSheet(
                                    isSalesAndRefund: true,
                                  ));
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Expanded(
                            child: GetBuilder<SalesAndRefundController>(
                                builder: (logic) => _controller
                                        .salesList.isEmpty
                                    ? Center(child: Text('No items found.'.tr))
                                    : ListView.builder(
                                        padding:
                                            const EdgeInsets.only(bottom: 60),
                                        itemCount: _controller.salesList.length,
                                        itemBuilder: (context, index) {
                                          var item =
                                              _controller.salesList[index];
                                          return ItemOrderWidget(
                                            changePrice: () {
                                              Get.dialog(
                                                  ChangePriceSalesRefundDialog(
                                                controller: _controller
                                                    .newPriceController,
                                                keyForm: _controller.priceKey,
                                                onConfirm: () {
                                                  _controller.changePriceSales(
                                                      item.itemId);
                                                },
                                              ));
                                            },
                                            increaseQuantity: () {
                                              _controller.increaseQuantitySales(
                                                  item.itemId);
                                            },
                                            decreaseQuantity: () {
                                              if (_controller.salesList[index]
                                                      .quantity ==
                                                  1) {
                                                _controller.removeItemSales(
                                                    item.itemId);
                                              } else {
                                                _controller
                                                    .decreaseQuantitySales(
                                                        item.itemId);
                                              }
                                            },
                                            cartModel:
                                                _controller.salesList[index],
                                          );
                                        },
                                      )),
                          ),
                        ],
                      ),
                    ),
                    // Refunds Section
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GetBuilder<SalesAndRefundController>(
                                  builder: (logic) {
                                return Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          '${'Refund Items'.tr} (${_controller.refundList.length}) :'
                                              .tr,
                                          style: AppTextStyles.bold16),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                          '${'Total Refund'.tr} : ${_controller.totalRefundPrice.toStringAsFixed(3)}'
                                              .tr,
                                          style: AppTextStyles.bold14),
                                    ],
                                  ),
                                );
                              }),
                              TextButton.icon(
                                icon: Icon(
                                  Icons.add,
                                  color: AppColor.primaryColor,
                                ),
                                label: Text(
                                  'Add Item'.tr,
                                  style: AppTextStyles.bold14
                                      .copyWith(color: AppColor.primaryColor),
                                ),
                                onPressed: () {
                                  Get.bottomSheet(CategoryBottomSheet(
                                    isSales: false,
                                    isSalesAndRefund: true,
                                  ));
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Expanded(
                            child: GetBuilder<SalesAndRefundController>(
                                builder: (logic) => _controller
                                        .refundList.isEmpty
                                    ? Center(child: Text('No items found.'.tr))
                                    : ListView.builder(
                                        padding:
                                            const EdgeInsets.only(bottom: 60),
                                        itemCount:
                                            _controller.refundList.length,
                                        itemBuilder: (context, index) {
                                          return ItemOrderWidget(
                                              changePrice: () {
                                                Get.dialog(
                                                    ChangePriceSalesRefundDialog(
                                                  controller: _controller
                                                      .newPriceController,
                                                  keyForm: _controller.priceKey,
                                                  onConfirm: () {
                                                    _controller
                                                        .changePriceRefund(
                                                            _controller
                                                                .refundList[
                                                                    index]
                                                                .itemId);
                                                  },
                                                ));
                                              },
                                              increaseQuantity: () {
                                                _controller
                                                    .increaseQuantityRefund(
                                                        _controller
                                                            .refundList[index]
                                                            .itemId);
                                              },
                                              decreaseQuantity: () {
                                                if (_controller
                                                        .refundList[index]
                                                        .quantity ==
                                                    1) {
                                                  _controller.removeItemRefund(
                                                      _controller
                                                          .refundList[index]
                                                          .itemId);
                                                } else {
                                                  _controller
                                                      .decreaseQuantityRefund(
                                                          _controller
                                                              .refundList[index]
                                                              .itemId);
                                                }
                                              },
                                              cartModel: _controller
                                                  .refundList[index]);
                                        },
                                      )),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PaymentDialog extends StatelessWidget {
  final CustomersModel customers;

  const PaymentDialog({
    super.key,
    required this.customers,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Choose payment method".tr),
      content: GetBuilder<SalesAndRefundController>(builder: (logic) {
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
                    : logic.addSalesAndRefundInvoice(customers);
              },
            )
          ],
        );
      }),
    );
  }
}
