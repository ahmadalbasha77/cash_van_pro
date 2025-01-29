class CartModel {
  int itemId;
  String itemName;
  // double price;
  double priceAfterTax;
  // double totalAfterTax;
  int quantity;

  // Constructor to ensure all fields are initialized
  CartModel({
    required this.itemId,
    required this.itemName,
    // required this.price,
    required this.priceAfterTax,
    // required this.totalAfterTax,
    required this.quantity,
  });

  // Calculate total price for this item
  double get totalPrice => priceAfterTax * quantity;
}
