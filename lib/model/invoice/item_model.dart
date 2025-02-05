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
  bool isTax;
  double salesPriceBeforeTax;
  double salesPriceAfterTax;
  int purchasePriceBeforeTax;
  int purchasePriceAfterTax;
  bool isNumber;
  bool isScaler;
  bool isScalerPerGrain;
  bool isDiscountable;
  bool isAdditions;
  bool isHasAdditionMandatory;
  bool isHasOptions;
  bool isOptionsMandetory;
  bool isItemOptions;
  int parentId;
  bool isMainItem;
  double qtyFactor;
  double wholeSalesPrice;
  int updateUserId;
  String updateUserName;
  bool isProductions;
  int costCenterId;
  bool status;
  bool isShowInTablet;
  dynamic picture;

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
    required this.isTax,
    required this.salesPriceBeforeTax,
    required this.salesPriceAfterTax,
    required this.purchasePriceBeforeTax,
    required this.purchasePriceAfterTax,
    required this.isNumber,
    required this.isScaler,
    required this.isScalerPerGrain,
    required this.isDiscountable,
    required this.isAdditions,
    required this.isHasAdditionMandatory,
    required this.isHasOptions,
    required this.isOptionsMandetory,
    required this.isItemOptions,
    required this.parentId,
    required this.isMainItem,
    required this.qtyFactor,
    required this.updateUserId,
    required this.updateUserName,
    required this.isProductions,
    required this.costCenterId,
    required this.status,
    required this.isShowInTablet,
    required this.picture,
    required this.wholeSalesPrice,
  });

  factory ItemModel.fromJson(Map<String, dynamic> json) => ItemModel(
    itemId: json["ItemID"] ?? 0,
    itemBarcode: json["ItemBarcode"] ?? '',
    itemName: json["ItemName"] ?? '',
    categoryId: json["CategoryID"] ?? 0,
    categoryName: json["CategoryName"] ?? '',
    salesTaxId: json["SalesTaxID"] ?? 0,
    salesTaxPercentage: json["SalesTaxPercentage"]?.toDouble() ?? 0.0, // ✅ تجنب null
    purchaseTaxId: json["PurchaseTaxID"] ?? 0,
    purchaseTaxPercentage: json["PurchaseTaxPercentage"]?.toDouble() ?? 0.0, // ✅ تجنب null
    isTax: json["IsTax"] ?? false,
    salesPriceBeforeTax: json["SalesPriceBeforeTax"]?.toDouble() ?? 0.0, // ✅ تجنب null
    salesPriceAfterTax: json["SalesPriceAfterTax"]?.toDouble() ?? 0.0, // ✅ تجنب null
    purchasePriceBeforeTax: json["PurchasePriceBeforeTax"]?.toInt() ?? 0, // ✅ تجنب null
    purchasePriceAfterTax: json["PurchasePriceAfterTax"]?.toInt() ?? 0, // ✅ تجنب null
    isNumber: json["IsNumber"] ?? false,
    isScaler: json["IsScaler"] ?? false,
    isScalerPerGrain: json["IsScalerPerGrain"] ?? false,
    isDiscountable: json["IsDiscountable"] ?? false,
    isAdditions: json["IsAdditions"] ?? false,
    isHasAdditionMandatory: json["IsHasAdditionMandatory"] ?? false,
    isHasOptions: json["IsHasOptions"] ?? false,
    isOptionsMandetory: json["IsOptionsMandetory"] ?? false,
    isItemOptions: json["IsItemOptions"] ?? false,
    parentId: json["ParentID"] ?? 0,
    isMainItem: json["IsMainItem"] ?? false,
    qtyFactor: json["QTYFactor"]?.toDouble() ?? 0.0, // ✅ تجنب null
    updateUserId: json["UpdateUserID"] ?? 0,
    updateUserName: json["UpdateUserName"] ?? '',
    isProductions: json["IsProductions"] ?? false,
    costCenterId: json["CostCenterID"] ?? 0,
    status: json["Status"] ?? false,
    isShowInTablet: json["IsShowInTablet"] ?? false,
    picture: json["Picture"] ?? '',
    wholeSalesPrice: json["WholeSalesPrice"]?.toDouble() ?? 0.0, // ✅ تجنب null
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
        "IsTax": isTax,
        "SalesPriceBeforeTax": salesPriceBeforeTax,
        "SalesPriceAfterTax": salesPriceAfterTax,
        "PurchasePriceBeforeTax": purchasePriceBeforeTax,
        "PurchasePriceAfterTax": purchasePriceAfterTax,
        "IsNumber": isNumber,
        "IsScaler": isScaler,
        "IsScalerPerGrain": isScalerPerGrain,
        "IsDiscountable": isDiscountable,
        "IsAdditions": isAdditions,
        "IsHasAdditionMandatory": isHasAdditionMandatory,
        "IsHasOptions": isHasOptions,
        "IsOptionsMandetory": isOptionsMandetory,
        "IsItemOptions": isItemOptions,
        "ParentID": parentId,
        "IsMainItem": isMainItem,
        "QTYFactor": qtyFactor,
        "UpdateUserID": updateUserId,
        "UpdateUserName": updateUserName,
        "IsProductions": isProductions,
        "CostCenterID": costCenterId,
        "Status": status,
        "IsShowInTablet": isShowInTablet,
        "Picture": picture,
        "WholeSalesPrice": wholeSalesPrice,
      };
}
