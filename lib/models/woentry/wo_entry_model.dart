// To parse this JSON data, do
//
//     final lostAndFoundDataModel = lostAndFoundDataModelFromJson(jsonString);

import 'dart:convert';

WoEntryDataModel woEntryDataModelFromJson(String str) => WoEntryDataModel.fromJson(json.decode(str));


class WoEntryDataModel {
  WoEntryDataModel({
    this.result,
    this.targetUrl,
    this.success,
    this.error,
    this.unAuthorizedRequest,
    this.abp,
  });

  Result result;
  dynamic targetUrl;
  bool success;
  dynamic error;
  bool unAuthorizedRequest;
  bool abp;

  factory WoEntryDataModel.fromJson(Map<String, dynamic> json) => WoEntryDataModel(
    result: json["result"] == null ? null : Result.fromJson(json["result"]),
    targetUrl: json["targetUrl"],
    success: json["success"] == null ? null : json["success"],
    error: json["error"],
    unAuthorizedRequest: json["unAuthorizedRequest"] == null ? null : json["unAuthorizedRequest"],
    abp: json["__abp"] == null ? null : json["__abp"],
  );

  Map<String, dynamic> toJson() => {
    "result": result == null ? null : result.toJson(),
    "targetUrl": targetUrl,
    "success": success == null ? null : success,
    "error": error,
    "unAuthorizedRequest": unAuthorizedRequest == null ? null : unAuthorizedRequest,
    "__abp": abp == null ? null : abp,
  };
}

class Result {
  Result({
    this.items,
  });

  List<WoEntryItems> items;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    items: json["items"] == null ? null : List<WoEntryItems>.from(json["items"].map((x) => WoEntryItems.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "items": items == null ? null : List<dynamic>.from(items.map((x) => x.toJson())),
  };
}

class WoEntryItems {
  WoEntryItems({
    this.getReportedBy,
    this.room,
    this.area,
    this.workType,
  });

  List<GetReportedBy> getReportedBy;
  List<Room> room;
  List<Area> area;
  List<WorkType> workType;

  factory WoEntryItems.fromJson(Map<String, dynamic> json) => WoEntryItems(
    getReportedBy: json["getReportedBy"] == null ? null : List<GetReportedBy>.from(json["getReportedBy"].map((x) => GetReportedBy.fromJson(x))),
    room: json["room"] == null ? null : List<Room>.from(json["room"].map((x) => Room.fromJson(x))),
    area: json["area"] == null ? null : List<Area>.from(json["area"].map((x) => Area.fromJson(x))),
    workType: json["workType"] == null ? null : List<WorkType>.from(json["workType"].map((x) => WorkType.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "getReportedBy": getReportedBy == null ? null : List<dynamic>.from(getReportedBy.map((x) => x.toJson())),
    "room": room == null ? null : List<dynamic>.from(room.map((x) => x.toJson())),
    "area": area == null ? null : List<dynamic>.from(area.map((x) => x.toJson())),
    "workType": workType == null ? null : List<dynamic>.from(workType.map((x) => x.toJson())),
  };
}

class Area {
  Area({
    this.seqno,
    this.description,
  });

  int seqno;
  String description;

  factory Area.fromJson(Map<String, dynamic> json) => Area(
    seqno: json["seqno"] == null ? null : json["seqno"],
    description: json["description"] == null ? null : json["description"],
  );

  Map<String, dynamic> toJson() => {
    "seqno": seqno == null ? null : seqno,
    "description": description == null ? null : description,
  };
}

class GetReportedBy {
  GetReportedBy({
    this.staffKey,
    this.userName,
  });

  String staffKey;
  String userName;

  factory GetReportedBy.fromJson(Map<String, dynamic> json) => GetReportedBy(
    staffKey: json["staffKey"] == null ? null : json["staffKey"],
    userName: json["userName"] == null ? null : json["userName"],
  );

  Map<String, dynamic> toJson() => {
    "staffKey": staffKey == null ? null : staffKey,
    "userName": userName == null ? null : userName,
  };
}

class Room {
  Room({
    this.roomKey,
    this.unit,
  });

  String roomKey;
  String unit;

  factory Room.fromJson(Map<String, dynamic> json) => Room(
    roomKey: json["roomKey"] == null ? null : json["roomKey"],
    unit: json["unit"] == null ? null : json["unit"],
  );

  Map<String, dynamic> toJson() => {
    "roomKey": roomKey == null ? null : roomKey,
    "unit": unit == null ? null : unit,
  };
}

class WorkType {
  WorkType({
    this.seqno,
    this.description,
  });

  int seqno;
  String description;

  factory WorkType.fromJson(Map<String, dynamic> json) => WorkType(
    seqno: json["seqno"] == null ? null : json["seqno"],
    description: json["description"] == null ? null : json["description"],
  );

  Map<String, dynamic> toJson() => {
    "seqno": seqno == null ? null : seqno,
    "description": description == null ? null : description,
  };
}
