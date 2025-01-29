class LoginModel {
  int id;
  String aName;
  String eName;
  bool isAdmin;
  String userName;
  double totalCashSales;
  double totalDEbitSales;
  double totalCollecting;
  int costCenterId;
  int positionId;
  int branchId;
  int storeId;
  int cashId;

  LoginModel({
    required this.id,
    required this.aName,
    required this.eName,
    required this.isAdmin,
    required this.userName,
    required this.totalCashSales,
    required this.totalDEbitSales,
    required this.totalCollecting,
    required this.costCenterId,
    required this.positionId,
    required this.branchId,
    required this.storeId,
    required this.cashId,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        id: json["ID"] ?? 0,
        aName: json["AName"] ?? '',
        eName: json["EName"] ?? '',
        isAdmin: json["IsAdmin"] ?? false,
        userName: json["UserName"] ?? '',
        totalCashSales: json["TotalCashSales"].toDouble() ?? 0.0,
        totalDEbitSales: json["TotalDEbitSales"].toDouble() ?? 0.0,
        totalCollecting: json["TotalCollecting"].toDouble() ?? 0.0,
        costCenterId: json["CostCenterID"] ?? 0,
        positionId: json["PositionID"] ?? 0,
        branchId: json["BranchID"] ?? 0,
        storeId: json["StoreID"] ?? 0,
        cashId: json["CashID"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "AName": aName,
        "EName": eName,
        "IsAdmin": isAdmin,
        "UserName": userName,
        "TotalCashSales": totalCashSales,
        "TotalDEbitSales": totalDEbitSales,
        "TotalCollecting": totalCollecting,
        "CostCenterID": costCenterId,
        "PositionID": positionId,
        "BranchID": branchId,
        "StoreID": storeId,
        "CashID": cashId,
      };
}
