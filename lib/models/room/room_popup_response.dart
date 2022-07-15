// To parse this JSON data, do
//
//     final roomPopUpResponse = roomPopUpResponseFromJson(jsonString);

import 'dart:convert';

RoomPopUpResponse roomPopUpResponseFromJson(String str) => RoomPopUpResponse.fromJson(json.decode(str));

String roomPopUpResponseToJson(RoomPopUpResponse data) => json.encode(data.toJson());

class RoomPopUpResponse {
  RoomPopUpResponse({
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

  factory RoomPopUpResponse.fromJson(Map<String, dynamic> json) => RoomPopUpResponse(
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

  List<RoomPopUpItem> items;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    items: json["items"] == null ? null : List<RoomPopUpItem>.from(json["items"].map((x) => RoomPopUpItem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "items": items == null ? null : List<dynamic>.from(items.map((x) => x.toJson())),
  };
}

class RoomPopUpItem {
  RoomPopUpItem({
    this.previousAttendantKey,
    this.unit,
    this.previousAttendantName,
    this.btnUnassignLink,
    this.attendantlist,
  });

  String previousAttendantKey;
  String unit;
  String previousAttendantName;
  bool btnUnassignLink;
  List<RoomPopUpItemList> attendantlist;

  factory RoomPopUpItem.fromJson(Map<String, dynamic> json) => RoomPopUpItem(
    previousAttendantKey: json["previousAttendantKey"] == null ? null : json["previousAttendantKey"],
    unit: json["unit"] == null ? null : json["unit"],
    previousAttendantName: json["previousAttendantName"] == null ? null : json["previousAttendantName"],
    btnUnassignLink: json["btnUnassignLink"] == null ? null : json["btnUnassignLink"],
    attendantlist: json["attendantlist"] == null ? null : List<RoomPopUpItemList>.from(json["attendantlist"].map((x) => RoomPopUpItemList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "previousAttendantKey": previousAttendantKey == null ? null : previousAttendantKey,
    "unit": unit == null ? null : unit,
    "previousAttendantName": previousAttendantName == null ? null : previousAttendantName,
    "btnUnassignLink": btnUnassignLink == null ? null : btnUnassignLink,
    "attendantlist": attendantlist == null ? null : List<dynamic>.from(attendantlist.map((x) => x.toJson())),
  };
}

class RoomPopUpItemList {
  RoomPopUpItemList({
    this.maidKey,
    this.name,
  });

  String maidKey;
  String name;

  factory RoomPopUpItemList.fromJson(Map<String, dynamic> json) => RoomPopUpItemList(
    maidKey: json["maidKey"] == null ? null : json["maidKey"],
    name: json["name"] == null ? null : json["name"],
  );

  Map<String, dynamic> toJson() => {
    "maidKey": maidKey == null ? null : maidKey,
    "name": name == null ? null : name,
  };
}
