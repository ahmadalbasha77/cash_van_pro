import 'package:cash_van_app/core/app_color.dart';
import 'package:cash_van_app/core/text_style.dart';
import 'package:cash_van_app/view/ui/quotation%20history/item_quotation_screen.dart';
import 'package:cash_van_app/view/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

import '../../../controller/quotation/quotation_edit_controller.dart';
import '../../../core/utils.dart';
import '../../widget/auth/custom_text_filed.dart';
import '../../widget/invoice/change_price_sales_refund_dialog.dart';
import '../../widget/invoice/item_order_widget.dart';

class EditQuotationScreen extends StatelessWidget {
  final String customerName;
  final int customerId;

  EditQuotationScreen({
    super.key,
    required this.customerName,
    required this.customerId,
  });

  final _controller = QuotationEditController.to;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) return;

        bool exit = await Utils.showAreYouSureDialog(
            title: 'Warning'.tr,
            message:
                'Your changes will not be saved.. Are you sure you want to exit?');
        if (exit) {
          Get.back();
        }
      },
      child: Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: AppColor.primaryColor,
          icon: const Icon(
            Icons.add,
            color: Colors.white,
          ),
          label: Text(
            'Add other items'.tr,
            style: AppTextStyles.bold14.copyWith(color: Colors.white),
          ),
          onPressed: () {
            Get.to(() => ItemQuotationScreen(),
                arguments: {'note': _controller.noteController.text});
          },
        ),
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
                    GetBuilder<QuotationEditController>(builder: (logic) {
                      return Text(_controller.totalCartPrice.toStringAsFixed(2),
                          style: AppTextStyles.bold20
                              .copyWith(color: AppColor.primaryColor));
                    }),
                  ],
                ),
              ),
              Expanded(
                child: GetBuilder<QuotationEditController>(builder: (logic) {
                  return CustomButtonWidget(
                    backgroundColor:
                        _controller.cartList.isEmpty ? Colors.grey : null,
                    title: 'Save Edit'.tr,
                    onPressed: () {
                      _controller.cartList.isEmpty
                          ? Utils.showFlutterToast('Please add items'.tr)
                          : _controller.editQuotation(customerId: customerId);
                    },
                  );
                }),
              ),
            ],
          ),
        ),
        appBar: AppBar(
          title: Text('Edit Quotation'.tr),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 0,
              ),
              Text('${'Customer Name'.tr} : $customerName'.tr,
                  style: AppTextStyles.bold16),
              const SizedBox(
                height: 10,
              ),
              Text('# ${Get.arguments['id']}'.tr, style: AppTextStyles.bold16),
              const SizedBox(
                height: 10,
              ),
              const Divider(),
              const SizedBox(
                height: 10,
              ),
              CustomTextFiledWidget(
                  radius: 20,
                  controller: _controller.noteController,
                  hint: 'Enter Note',
                  label: 'Add Note (optional)'),
              const SizedBox(
                height: 20,
              ),
              GetBuilder<QuotationEditController>(builder: (logic) {
                return Text(
                    '${'Items'.tr} (${_controller.cartList.length}) :'.tr,
                    style: AppTextStyles.bold16);
              }),
              // const Divider(),
              const SizedBox(height: 10),
              Expanded(
                child: GetBuilder<QuotationEditController>(
                  builder: (logic) => _controller.isLoading == true
                      ? const Center(child: CircularProgressIndicator())
                      : _controller.cartList.isEmpty
                          ? Center(
                              child: Text('No Items'.tr),
                            )
                          : ListView.builder(
                              padding: const EdgeInsets.only(bottom: 60),
                              itemCount: _controller.cartList.length,
                              itemBuilder: (context, index) {
                                return Slidable(
                                  closeOnScroll: true,
                                  useTextDirection: false,
                                  key: ValueKey(
                                      _controller.cartList[index].itemId),
                                  endActionPane: ActionPane(
                                    motion: const ScrollMotion(),
                                    dragDismissible: false,
                                    children: [
                                      SlidableAction(
                                        spacing: 15,
                                        onPressed: (context) async {
                                          _controller.removeItem(_controller
                                              .cartList[index].itemId);
                                        },
                                        foregroundColor: Colors.red.shade800,
                                        icon: Icons.delete_forever_outlined,
                                        label: 'remove'.tr,
                                      ),
                                    ],
                                  ),
                                  child: ItemOrderWidget(
                                      showPrice: true,
                                      changePrice: () {
                                        Get.dialog(ChangePriceSalesRefundDialog(
                                          controller:
                                              _controller.newPriceController,
                                          keyForm: _controller.priceKey,
                                          onConfirm: () {
                                            _controller.changePriceSales(
                                                _controller
                                                    .cartList[index].itemId);
                                          },
                                        ));
                                      },
                                      increaseQuantity: () {
                                        _controller.increaseQuantity(
                                            _controller.cartList[index].itemId);
                                      },
                                      decreaseQuantity: () {
                                        if (_controller
                                                .cartList[index].quantity ==
                                            1) {
                                          _controller.removeItem(_controller
                                              .cartList[index].itemId);
                                        } else {
                                          _controller.decreaseQuantity(
                                              _controller
                                                  .cartList[index].itemId);
                                        }
                                      },
                                      cartModel: _controller.cartList[index]),
                                );
                              },
                            ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
