class InvoiceModel {
  int salesId;
  int returnId;

  InvoiceModel({
    required this.salesId,
    required this.returnId,
  });

  factory InvoiceModel.fromJson(Map<String, dynamic> json) => InvoiceModel(
        salesId: json["SalesID"],
        returnId: json["ReturnID"],
      );

  Map<String, dynamic> toJson() => {
        "SalesID": salesId,
        "ReturnID": returnId,
      };
}
