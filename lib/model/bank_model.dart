class BankModel {
  int id;
  String aName;
  String eName;
  bool status;

  BankModel({
    required this.id,
    required this.aName,
    required this.eName,
    required this.status,
  });

  factory BankModel.fromJson(Map<String, dynamic> json) => BankModel(
        id: json["ID"] ?? 0,
        aName: json["AName"] ?? '',
        eName: json["EName"] ?? '',
        status: json["Status"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "AName": aName,
        "EName": eName,
        "Status": status,
      };
}
