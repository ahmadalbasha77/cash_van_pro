import 'package:cash_van_app/controller/invoice/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/text_style.dart';
import '../../../model/invoice/cart_model.dart';

class ItemOrderWidget extends StatelessWidget {
  final CartModel cartModel;
  final void Function() increaseQuantity;
  final void Function() decreaseQuantity;
  final VoidCallback changePrice;

  const ItemOrderWidget(
      {super.key,
      required this.cartModel,
      required this.increaseQuantity,
      required this.decreaseQuantity,
      required this.changePrice});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      color: Colors.grey[50],
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Row(
          children: [
            Expanded(
              flex: 4,
              child: Text(cartModel.itemName, style: AppTextStyles.bold16),
            ),
            const Spacer(),
            IconButton(
              onPressed: increaseQuantity,
              icon: const Icon(Icons.add, size: 25),
            ),
            Text('${cartModel.quantity}', style: AppTextStyles.bold18),
            IconButton(
              onPressed: decreaseQuantity,
              icon: const Icon(Icons.remove, size: 25),
            ),
            const Spacer(),
            GetBuilder<CartController>(builder: (logic) {
              return TextButton(
                style: const ButtonStyle(
                    padding: WidgetStatePropertyAll(EdgeInsets.zero)),
                onPressed: changePrice,
                child: Text(cartModel.priceAfterTax.toStringAsFixed(2),
                    style: AppTextStyles.bold16),
              );
            }),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.07,
            ),
            Text(cartModel.totalPrice.toStringAsFixed(2),
                style: AppTextStyles.bold16),
          ],
        ),
      ),
    );
  }
}
