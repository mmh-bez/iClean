// To parse this JSON data, do
//
//     final salePyament = salePyamentFromJson(jsonString);

import 'dart:convert';

import 'package:i_clean/models/supervisor/super_visor_checklist_response.dart';
String saveCheckListToJson(SaveCheckList data) => json.encode(data.toJson());

class SaveCheckList {
  SaveCheckList({
    this.checklist,
    this.roomkey,

  });

  List<SupCheckItem> checklist;
  String roomkey;



  Map<String, dynamic> toJson() => {
    "supCheckList": List<dynamic>.from(SupCheckItem.map((x) => x.toJson())),
    "roomKey": roomkey ,
  };
}
