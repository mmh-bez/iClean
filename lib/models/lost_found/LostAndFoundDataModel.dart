// To parse this JSON data, do
//
//     final lostAndFoundDataModel = lostAndFoundDataModelFromJson(jsonString);

import 'dart:convert';

LostAndFoundDataModel lostAndFoundDataModelFromJson(String str) => LostAndFoundDataModel.fromJson(json.decode(str));

String lostAndFoundDataModelToJson(LostAndFoundDataModel data) => json.encode(data.toJson());

class LostAndFoundDataModel {
  LostAndFoundDataModel({
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

  factory LostAndFoundDataModel.fromJson(Map<String, dynamic> json) => LostAndFoundDataModel(
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

  List<LFItem> items;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    items: json["items"] == null ? null : List<LFItem>.from(json["items"].map((x) => LFItem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "items": items == null ? null : List<dynamic>.from(items.map((x) => x.toJson())),
  };
}

class LFItem {
  LFItem({
    this.itemStatus,
    this.room,
    this.area,
  });

  List<LFItemStatus> itemStatus;
  List<LFRoom> room;
  List<LFArea> area;

  factory LFItem.fromJson(Map<String, dynamic> json) => LFItem(
    itemStatus: json["itemStatus"] == null ? null : List<LFItemStatus>.from(json["itemStatus"].map((x) => LFItemStatus.fromJson(x))),
    room: json["room"] == null ? null : List<LFRoom>.from(json["room"].map((x) => LFRoom.fromJson(x))),
    area: json["area"] == null ? null : List<LFArea>.from(json["area"].map((x) => LFArea.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "itemStatus": itemStatus == null ? null : List<dynamic>.from(itemStatus.map((x) => x.toJson())),
    "room": room == null ? null : List<dynamic>.from(room.map((x) => x.toJson())),
    "area": area == null ? null : List<dynamic>.from(area.map((x) => x.toJson())),
  };
}

class LFArea {
  LFArea({
    this.seqno,
    this.description,
  });

  int seqno;
  String description;

  factory LFArea.fromJson(Map<String, dynamic> json) => LFArea(
    seqno: json["seqno"] == null ? null : json["seqno"],
    description: json["description"] == null ? null : json["description"],
  );

  Map<String, dynamic> toJson() => {
    "seqno": seqno == null ? null : seqno,
    "description": description == null ? null : description,
  };
}

class LFItemStatus {
  LFItemStatus({
    this.lostFoundStatusKey,
    this.lostFoundStatus,
  });

  String lostFoundStatusKey;
  String lostFoundStatus;

  factory LFItemStatus.fromJson(Map<String, dynamic> json) => LFItemStatus(
    lostFoundStatusKey: json["lostFoundStatusKey"] == null ? null : json["lostFoundStatusKey"],
    lostFoundStatus: json["lostFoundStatus"] == null ? null : json["lostFoundStatus"],
  );

  Map<String, dynamic> toJson() => {
    "lostFoundStatusKey": lostFoundStatusKey == null ? null : lostFoundStatusKey,
    "lostFoundStatus": lostFoundStatus == null ? null : lostFoundStatus,
  };
}

class LFRoom {
  LFRoom({
    this.roomKey,
    this.unit,
  });

  String roomKey;
  String unit;

  factory LFRoom.fromJson(Map<String, dynamic> json) => LFRoom(
    roomKey: json["roomKey"] == null ? null : json["roomKey"],
    unit: json["unit"] == null ? null : json["unit"],
  );

  Map<String, dynamic> toJson() => {
    "roomKey": roomKey == null ? null : roomKey,
    "unit": unit == null ? null : unit,
  };
}
