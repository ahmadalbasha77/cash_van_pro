class CategoryModel {
  bool selected;
  int id;
  String aName;
  String eName;
  String color;
  String font;
  double fontSize;
  String fontStyle;
  bool stationShow;
  dynamic isShowOrder;
  int parentId;
  dynamic isAddSubscribe;

  CategoryModel({
    required this.selected,
    required this.id,
    required this.aName,
    required this.eName,
    required this.color,
    required this.font,
    required this.fontSize,
    required this.fontStyle,
    required this.stationShow,
    required this.isShowOrder,
    required this.parentId,
    required this.isAddSubscribe,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        selected: json["Selected"] ?? 0,
        id: json["ID"] ?? 0,
        aName: json["AName"] ?? '',
        eName: json["EName"] ?? '',
        color: json["Color"] ?? '',
        font: json["Font"] ?? '',
        fontSize: json["FontSize"] ?? 0.0,
        fontStyle: json["FontStyle"] ?? '',
        stationShow: json["StationShow"] ?? '',
        isShowOrder: json["IsShowOrder"] ?? false,
        parentId: json["ParentID"] ?? 0,
        isAddSubscribe: json["IsAddSubscribe"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "Selected": selected,
        "ID": id,
        "AName": aName,
        "EName": eName,
        "Color": color,
        "Font": font,
        "FontSize": fontSize,
        "FontStyle": fontStyle,
        "StationShow": stationShow,
        "IsShowOrder": isShowOrder,
        "ParentID": parentId,
        "IsAddSubscribe": isAddSubscribe,
      };
}
