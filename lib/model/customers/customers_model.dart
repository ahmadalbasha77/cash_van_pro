class CustomersModel {
  int id;
  String aName;
  String telephone1;
  double customerBalance;

  CustomersModel({
    required this.id,
    required this.aName,
    required this.telephone1,
    required this.customerBalance,
  });

  factory CustomersModel.fromJson(Map<String, dynamic> json) => CustomersModel(
        id: json["ID"],
        aName: json["AName"],
        telephone1: json["Telephone1"],
        customerBalance: json["CustomerBalance"],
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "AName": aName,
        "Telephone1": telephone1,
        "CustomerBalance": customerBalance,
      };
}
