class CategoryModel {
  bool selected;
  int id;
  String aName;
  String eName;

  CategoryModel({
    required this.selected,
    required this.id,
    required this.aName,
    required this.eName,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        selected: json["Selected"] ?? 0,
        id: json["ID"] ?? 0,
        aName: json["AName"] ?? '',
        eName: json["EName"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "Selected": selected,
        "ID": id,
        "AName": aName,
        "EName": eName,
      };
}
