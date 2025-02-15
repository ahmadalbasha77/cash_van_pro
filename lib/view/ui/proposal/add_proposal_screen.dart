import 'package:cash_van_app/core/app_color.dart';
import 'package:cash_van_app/core/my_shared_preferences.dart';
import 'package:cash_van_app/core/text_style.dart';
import 'package:cash_van_app/view/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/proposal/proposal_controller.dart';
import '../../../model/customers/customers_model.dart';
import '../../widget/invoice/change_price_sales_refund_dialog.dart';
import '../../widget/invoice/item_order_widget.dart';

class AddProposalScreen extends StatelessWidget {
  final CustomersModel customersData;

  AddProposalScreen({
    super.key,
    required this.customersData,
  });

  final _controller = Get.find<ProposalController>();

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
            if (mySharedPreferences.showPriceInQuotation == true)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Total'.tr, style: AppTextStyles.bold20),
                    GetBuilder<ProposalController>(builder: (logic) {
                      return Text(_controller.totalCartPrice.toStringAsFixed(2),
                          style: AppTextStyles.bold20
                              .copyWith(color: AppColor.primaryColor));
                    }),
                  ],
                ),
              ),
            Expanded(
              child: GetBuilder<ProposalController>(builder: (logic) {
                return CustomButtonWidget(
                  backgroundColor:
                      _controller.cartList.isEmpty ? Colors.grey : null,
                  title: 'Confirm',
                  onPressed: () {
                    _controller.addQuotation(customer: customersData);
                  },
                );
              }),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('Add Quotation'.tr),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Text('${'Customer Name'.tr} : ${customersData.aName}'.tr,
                style: AppTextStyles.bold16),
            const SizedBox(
              height: 10,
            ),
            const Divider(),
            const SizedBox(
              height: 10,
            ),
            Text('${'Items'.tr} (${_controller.cartList.length}) :'.tr,
                style: AppTextStyles.bold16),
            // const Divider(),
            const SizedBox(height: 10),
            Expanded(
              child: GetBuilder<ProposalController>(
                builder: (logic) => _controller.cartList.isEmpty
                    ? Center(
                        child: Text('No Items'.tr),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.only(bottom: 60),
                        itemCount: _controller.cartList.length,
                        itemBuilder: (context, index) {
                          return ItemOrderWidget(
                              showPrice:
                                  mySharedPreferences.showPriceInQuotation,
                              changePrice: () {
                                Get.dialog(ChangePriceSalesRefundDialog(
                                  controller: _controller
                                      .newPriceController,
                                  keyForm: _controller.priceKey,

                                  onConfirm: () {
                                    _controller.changePriceSales(
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
