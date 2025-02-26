class QuotationHistoryModel {
  int id;
  int tranactionNo;
  DateTime invoiceDate;
  int customerId;
  String name;
  String notes;
  String eName;
  double totalBeforeTax;
  double totalAfterTax;

  QuotationHistoryModel({
    required this.id,
    required this.tranactionNo,
    required this.invoiceDate,
    required this.customerId,
    required this.name,
    required this.notes,
    required this.eName,
    required this.totalBeforeTax,
    required this.totalAfterTax,
  });

  factory QuotationHistoryModel.fromJson(Map<String, dynamic> json) =>
      QuotationHistoryModel(
        id: json["ID"]??0,
        tranactionNo: json["TranactionNo"] ?? 0,
        invoiceDate: DateTime.parse(json["InvoiceDate"]),
        customerId: json["CustomerID"]??0,
        name: json["Name"]??'',
        notes: json["Notes"]??'',
        eName: json["EName"]??'',
        totalBeforeTax: json["TotalBeforeTax"]?.toDouble()??0.0,
        totalAfterTax: json["TotalAfterTax"]?.toDouble()??0.0,
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "TranactionNo": tranactionNo,
        "InvoiceDate": invoiceDate.toIso8601String(),
        "CustomerID": customerId,
        "Name": name,
        "notes": notes,
        "EName": eName,
        "TotalBeforeTax": totalBeforeTax,
        "TotalAfterTax": totalAfterTax,
      };
}
