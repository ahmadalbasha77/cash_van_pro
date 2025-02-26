class InvoiceModel {
  int salesId;
  int returnId;

  InvoiceModel({
    required this.salesId,
    required this.returnId,
  });

  factory InvoiceModel.fromJson(Map<String, dynamic> json) => InvoiceModel(
        salesId: json["SalesID"] ?? 0,
        returnId: json["ReturnID"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "SalesID": salesId,
        "ReturnID": returnId,
      };
}
