import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectQuantityController extends GetxController {
  var quantity = 1.obs;
  final TextEditingController textController = TextEditingController();

  @override
  void onInit() {
    super.onInit();

    textController.addListener(() {
      final int? newValue = int.tryParse(textController.text);
      if (newValue != null && newValue > 0) {
        quantity.value = newValue;
      }
    });

    ever(quantity, (newQuantity) {
      textController.text = newQuantity.toString();
    });

    textController.text = quantity.value.toString();
  }

  void increase() {
    quantity.value++;
  }

  void decrease() {
    if (quantity.value > 1) {
      quantity.value--;
    }
  }
}
