class ItemModel {
  int itemId;
  String itemBarcode;
  String itemName;
  int categoryId;
  String categoryName;
  int salesTaxId;
  double salesTaxPercentage;
  int purchaseTaxId;
  double purchaseTaxPercentage;
  double salesPriceBeforeTax;
  double salesPriceAfterTax;
  int purchasePriceBeforeTax;
  int purchasePriceAfterTax;
  double wholeSalesPrice;

  ItemModel({
    required this.itemId,
    required this.itemBarcode,
    required this.itemName,
    required this.categoryId,
    required this.categoryName,
    required this.salesTaxId,
    required this.salesTaxPercentage,
    required this.purchaseTaxId,
    required this.purchaseTaxPercentage,
    required this.salesPriceBeforeTax,
    required this.salesPriceAfterTax,
    required this.purchasePriceBeforeTax,
    required this.purchasePriceAfterTax,
    required this.wholeSalesPrice,
  });

  factory ItemModel.fromJson(Map<String, dynamic> json) => ItemModel(
    itemId: json["ItemID"] ?? 0,
    itemBarcode: json["ItemBarcode"] ?? '',
    itemName: json["ItemName"] ?? '',
    categoryId: json["CategoryID"] ?? 0,
    categoryName: json["CategoryName"] ?? '',
    salesTaxId: json["SalesTaxID"] ?? 0,
    salesTaxPercentage: json["SalesTaxPercentage"]?.toDouble() ?? 0.0,
    purchaseTaxId: json["PurchaseTaxID"] ?? 0,
    purchaseTaxPercentage: json["PurchaseTaxPercentage"]?.toDouble() ?? 0.0,
    salesPriceBeforeTax: json["SalesPriceBeforeTax"]?.toDouble() ?? 0.0,
    salesPriceAfterTax: json["SalesPriceAfterTax"]?.toDouble() ?? 0.0,
    purchasePriceBeforeTax: json["PurchasePriceBeforeTax"]?.toInt() ?? 0,
    purchasePriceAfterTax: json["PurchasePriceAfterTax"]?.toInt() ?? 0,
    wholeSalesPrice: json["WholeSalesPrice"]?.toDouble() ?? 0.0,
  );

  Map<String, dynamic> toJson() => {
        "ItemID": itemId,
        "ItemBarcode": itemBarcode,
        "ItemName": itemName,
        "CategoryID": categoryId,
        "CategoryName": categoryName,
        "SalesTaxID": salesTaxId,
        "SalesTaxPercentage": salesTaxPercentage,
        "PurchaseTaxID": purchaseTaxId,
        "PurchaseTaxPercentage": purchaseTaxPercentage,
        "SalesPriceBeforeTax": salesPriceBeforeTax,
        "SalesPriceAfterTax": salesPriceAfterTax,
        "PurchasePriceBeforeTax": purchasePriceBeforeTax,
        "PurchasePriceAfterTax": purchasePriceAfterTax,
        "WholeSalesPrice": wholeSalesPrice,
      };
}
