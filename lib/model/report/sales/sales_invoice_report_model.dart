class SalesInvoiceReportModel {
  int id;
  DateTime invoiceDate;
  String sourceName;
  double totalAfterTax;
  String settelmentWay;

  SalesInvoiceReportModel({
    required this.id,
    required this.invoiceDate,
    required this.sourceName,
    required this.totalAfterTax,
    required this.settelmentWay,
  });

  factory SalesInvoiceReportModel.fromJson(Map<String, dynamic> json) =>
      SalesInvoiceReportModel(
        id: json["ID"] ?? 0,
        invoiceDate: json["InvoiceDate"] == null
            ? DateTime.now()
            : DateTime.parse(json["InvoiceDate"]),
        sourceName: json["SourceName"] ?? '',
        totalAfterTax: json["TotalAfterTax"]?.toDouble() ?? 0.0,
        settelmentWay: json["SettelmentWay"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "InvoiceDate": invoiceDate.toIso8601String(),
        "SourceName": sourceName,
        "TotalAfterTax": totalAfterTax,
        "SettelmentWay": settelmentWay,
      };
}
