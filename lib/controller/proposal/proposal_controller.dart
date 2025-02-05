import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../model/invoice/cart_model.dart';
import '../../network/rest_api.dart';

class ProposalController extends GetxController {
  final Map<int, CartModel> _cartMap = {};
  final RestApi restApi = RestApi();

  int paymentType = 0;

  List<CartModel> get cartList => _cartMap.values.toList();

  final GlobalKey<FormState> priceKey = GlobalKey<FormState>();

  final TextEditingController newPriceController = TextEditingController();

  void addItem(CartModel item) {
    if (_cartMap.containsKey(item.itemId)) {
      _cartMap[item.itemId]!.quantity += item.quantity;
    } else {
      _cartMap[item.itemId] = item;
    }
    update();
  }

  void removeItem(int itemId) {
    _cartMap.remove(itemId);
    update();
  }

  void increaseQuantity(int itemId) {
    if (_cartMap.containsKey(itemId)) {
      _cartMap[itemId]!.quantity++;
      update();
    }
  }

  void decreaseQuantity(int itemId) {
    if (_cartMap.containsKey(itemId) && _cartMap[itemId]!.quantity > 1) {
      _cartMap[itemId]!.quantity--;
      update();
    }
  }

  double get totalCartPrice {
    return _cartMap.values.fold(0, (sum, item) => sum + item.totalPrice);
  }
}
