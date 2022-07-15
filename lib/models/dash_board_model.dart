// To parse this JSON data, do
//
//     final dashBoardModel = dashBoardModelFromJson(jsonString);

import 'dart:convert';

List<DashBoardModel> dashBoardModelFromJson(String str) => List<DashBoardModel>.from(json.decode(str).map((x) => DashBoardModel.fromJson(x)));

String dashBoardModelToJson(List<DashBoardModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DashBoardModel {
  DashBoardModel({
    this.id,
    this.icon,
    this.name,
  });

  int id;
  String icon;
  String name;

  factory DashBoardModel.fromJson(Map<String, dynamic> json) => DashBoardModel(
    id: json["id"] == null ? null : json["id"],
    icon: json["icon"] == null ? null : json["icon"],
    name: json["name"] == null ? null : json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "icon": icon == null ? null : icon,
    "name": name == null ? null : name,
  };
}
