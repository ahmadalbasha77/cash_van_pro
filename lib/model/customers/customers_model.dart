class CustomersModel {
  final int id;
  final String aName;
  final String telephone1;
  final double customerBalance;

  const CustomersModel({
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
