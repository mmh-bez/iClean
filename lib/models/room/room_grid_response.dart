// To parse this JSON data, do
//
//     final roomGridResponse = roomGridResponseFromJson(jsonString);

import 'dart:convert';

RoomGridResponse roomGridResponseFromJson(String str) => RoomGridResponse.fromJson(json.decode(str));

class RoomGridResponse {
  RoomGridResponse({
    this.result,
    this.targetUrl,
    this.success,
    this.error,
    this.unAuthorizedRequest,
    this.abp,
  });

  RoomResult result;
  dynamic targetUrl;
  bool success;
  dynamic error;
  bool unAuthorizedRequest;
  bool abp;

  factory RoomGridResponse.fromJson(Map<String, dynamic> json) => RoomGridResponse(
    result: json["result"] == null ? null : RoomResult.fromJson(json["result"]),
    targetUrl: json["targetUrl"],
    success: json["success"] == null ? null : json["success"],
    error: json["error"],
    unAuthorizedRequest: json["unAuthorizedRequest"] == null ? null : json["unAuthorizedRequest"],
    abp: json["__abp"] == null ? null : json["__abp"],
  );

}

class RoomResult {
  RoomResult({
    this.totalCount,
    this.items,
  });

  int totalCount;
  List<RoomGridItems> items;

  factory RoomResult.fromJson(Map<String, dynamic> json) => RoomResult(
    totalCount: json["totalCount"] == null ? null : json["totalCount"],
    items: json["items"] == null ? null : List<RoomGridItems>.from(json["items"].map((x) => RoomGridItems.fromJson(x))),
  );

}

class RoomGridItems {
  RoomGridItems({
    this.unit,
    this.roomType,
    this.roomStatus,
    this.maidStatus,
    this.guest,
    this.maid,
    this.dnd,
    this.roomstatusTextColor,
    this.roomstatusPbgColor,
    this.dndColor,
    this.dndStatus,
    this.maidStatusTextColor,
    this.guestDes,
    this.maidDes,
  });

  String unit;
  String roomType;
  String roomStatus;
  String maidStatus;
  String guest;
  String maid;
  int dnd;
  String roomstatusTextColor;
  String roomstatusPbgColor;
  String dndColor;
  String dndStatus;
  String maidStatusTextColor;
  String guestDes;
  String maidDes;

  factory RoomGridItems.fromJson(Map<String, dynamic> json) => RoomGridItems(
    unit: json["unit"] == null ? null : json["unit"],
    roomType: json["roomType"] == null ? null : json["roomType"],
    roomStatus: json["roomStatus"] == null ? null : json["roomStatus"],
    maidStatus: json["maidStatus"] == null ? null : json["maidStatus"],
    guest: json["guest"] == null ? null : json["guest"],
    maid: json["maid"] == null ? null : json["maid"],
    dnd: json["dnd"] == null ? null : json["dnd"],
    roomstatusTextColor: json["roomstatusTextColor"] == null ? null : json["roomstatusTextColor"],
    roomstatusPbgColor: json["roomstatusPBGColor"] == null ? null : json["roomstatusPBGColor"],
    dndColor: json["dndColor"] == null ? null : json["dndColor"],
    dndStatus: json["dndStatus"] == null ? null : json["dndStatus"],
    maidStatusTextColor: json["maidStatusTextColor"] == null ? null : json["maidStatusTextColor"],
    guestDes: json["guestDes"] == null ? null : json["guestDes"],
    maidDes: json["maidDes"] == null ? null : json["maidDes"],
  );

}


