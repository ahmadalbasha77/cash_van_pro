class ChequeVoucherReportModel {
  int id;
  int chequesNumber;
  DateTime paymentDate;
  DateTime issueDate;
  double amount;
  String beneficiaryName;
  String branchName;
  String bankName;

  ChequeVoucherReportModel({
    required this.id,
    required this.chequesNumber,
    required this.paymentDate,
    required this.issueDate,
    required this.amount,
    required this.beneficiaryName,
    required this.branchName,
    required this.bankName,
  });

  factory ChequeVoucherReportModel.fromJson(Map<String, dynamic> json) =>
      ChequeVoucherReportModel(
        id: json["ID"] ?? 0,
        chequesNumber: json["ChequesNumber"] ?? 0,
        paymentDate: DateTime.parse(json["PaymentDate"]),
        issueDate: DateTime.parse(json["IssueDate"]),
        amount: json["Amount"].toDouble() ?? 0.0,
        beneficiaryName: json["BeneficiaryName"] ?? '',
        branchName: json["BranchName"] ?? '',
        bankName: json["BankName"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "ChequesNumber": chequesNumber,
        "PaymentDate": paymentDate.toIso8601String(),
        "IssueDate": issueDate.toIso8601String(),
        "Amount": amount,
        "BeneficiaryName": beneficiaryName,
        "BranchName": branchName,
        "BankName": bankName,
      };
}
