class AccountStatementModel {
  double openingBalance;
  List<AccountStatementData> data;

  AccountStatementModel({
    required this.openingBalance,
    required this.data,
  });

  factory AccountStatementModel.fromJson(Map<String, dynamic> json) =>
      AccountStatementModel(
        openingBalance: json["OpeningBalance"] ?? 0.0,
        data: List<AccountStatementData>.from(
            json["Data"].map((x) => AccountStatementData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "OpeningBalance": openingBalance,
        "Data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class AccountStatementData {
  int voucherId;
  int voucherNumber;
  DateTime voucherDate;
  String voucherTypeAName;
  String voucherTypeEName;
  int voucherTypeId;
  String notes;
  double debit;
  double credit;
  String branchName;
  String? transactionOwnerName;
  DateTime dueDate;
  String otherAccount;
  int transactionNumber;
  int transactionId;
  int cashvoucherid;
  int incomingVoucherId;
  int outgoingVoucherId;
  int hrTransactionId;
  int? contractId;
  int chequesId;
  double periodBalance;

  AccountStatementData({
    required this.voucherId,
    required this.voucherNumber,
    required this.voucherDate,
    required this.voucherTypeAName,
    required this.voucherTypeEName,
    required this.voucherTypeId,
    required this.notes,
    required this.debit,
    required this.credit,
    required this.branchName,
    required this.transactionOwnerName,
    required this.dueDate,
    required this.otherAccount,
    required this.transactionNumber,
    required this.transactionId,
    required this.cashvoucherid,
    required this.incomingVoucherId,
    required this.outgoingVoucherId,
    required this.hrTransactionId,
    required this.contractId,
    required this.chequesId,
    required this.periodBalance,
  });

  factory AccountStatementData.fromJson(Map<String, dynamic> json) =>
      AccountStatementData(
        voucherId: json["VoucherID"] ?? 0,
        voucherNumber: json["VoucherNumber"] ?? 0,
        voucherDate: json["VoucherDate"] == null
            ? DateTime.now()
            : DateTime.parse(json["VoucherDate"]),
        voucherTypeAName: json["VoucherTypeAName"] ?? '',
        voucherTypeEName: json["VoucherTypeEName"] ?? '',
        voucherTypeId: json["VoucherTypeID"] ?? 0,
        notes: json["Notes"] ?? '',
        debit: json["Debit"]?.toDouble() ?? 0.0,
        credit: json["Credit"]?.toDouble() ?? 0.0,
        branchName: json["BranchName"] ?? '',
        transactionOwnerName: json["TransactionOwnerName"] ?? '',
        dueDate: json["DueDate"] == null
            ? DateTime.now()
            : DateTime.parse(json["DueDate"]),
        otherAccount: json["OtherAccount"] ?? '',
        transactionNumber: json["TransactionNumber"] ?? 0,
        transactionId: json["TransactionID"] ?? 0,
        cashvoucherid: json["Cashvoucherid"] ?? 0,
        incomingVoucherId: json["IncomingVoucherID"] ?? 0,
        outgoingVoucherId: json["OutgoingVoucherID"] ?? 0,
        hrTransactionId: json["HrTransactionID"] ?? 0,
        contractId: json["contractID"] ?? 0,
        chequesId: json["ChequesID"] ?? 0,
        periodBalance: json["PeriodBalance"]?.toDouble() ?? 0.0,
      );

  Map<String, dynamic> toJson() => {
        "VoucherID": voucherId,
        "VoucherNumber": voucherNumber,
        "VoucherDate": voucherDate.toIso8601String(),
        "VoucherTypeAName": voucherTypeAName,
        "VoucherTypeEName": voucherTypeEName,
        "VoucherTypeID": voucherTypeId,
        "Notes": notes,
        "Debit": debit,
        "Credit": credit,
        "BranchName": branchName,
        "TransactionOwnerName": transactionOwnerName,
        "DueDate": dueDate.toIso8601String(),
        "OtherAccount": otherAccount,
        "TransactionNumber": transactionNumber,
        "TransactionID": transactionId,
        "Cashvoucherid": cashvoucherid,
        "IncomingVoucherID": incomingVoucherId,
        "OutgoingVoucherID": outgoingVoucherId,
        "HrTransactionID": hrTransactionId,
        "contractID": contractId,
        "ChequesID": chequesId,
        "PeriodBalance": periodBalance,
      };
}
