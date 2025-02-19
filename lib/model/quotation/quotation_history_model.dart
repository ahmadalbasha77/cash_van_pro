class QuotationHistoryModel {
  int id;
  DateTime invoiceDate;
  int customerId;
  String name;
  String eName;
  double totalBeforeTax;
  double totalAfterTax;

  QuotationHistoryModel({
    required this.id,
    required this.invoiceDate,
    required this.customerId,
    required this.name,
    required this.eName,
    required this.totalBeforeTax,
    required this.totalAfterTax,
  });

  factory QuotationHistoryModel.fromJson(Map<String, dynamic> json) =>
      QuotationHistoryModel(
        id: json["ID"],
        invoiceDate: DateTime.parse(json["InvoiceDate"]),
        customerId: json["CustomerID"],
        name: json["Name"],
        eName: json["EName"],
        totalBeforeTax: json["TotalBeforeTax"]?.toDouble(),
        totalAfterTax: json["TotalAfterTax"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "InvoiceDate": invoiceDate.toIso8601String(),
        "CustomerID": customerId,
        "Name": name,
        "EName": eName,
        "TotalBeforeTax": totalBeforeTax,
        "TotalAfterTax": totalAfterTax,
      };
}
