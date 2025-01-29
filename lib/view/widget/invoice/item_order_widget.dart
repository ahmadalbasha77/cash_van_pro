import 'package:flutter/material.dart';

import '../../../core/text_style.dart';
import '../../../model/invoice/cart_model.dart';

class ItemOrderWidget extends StatelessWidget {
  final CartModel cartModel;
  final void Function() increaseQuantity;
  final void Function() decreaseQuantity;

  const ItemOrderWidget(
      {super.key,
        required this.cartModel,
        required this.increaseQuantity,
        required this.decreaseQuantity});

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
            Text(cartModel.totalPrice.toStringAsFixed(3), style: AppTextStyles.bold16),
          ],
        ),
      ),
    );
  }
}