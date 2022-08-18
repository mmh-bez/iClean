// To parse this JSON data, do
//
//     final supervisorStatusResponse = supervisorStatusResponseFromJson(jsonString);

import 'dart:convert';

import 'package:i_clean/models/attendant/ddl_room_status_model.dart';
import 'package:i_clean/models/attendant/floor_response_model.dart';

SupervisorStatusResponse supervisorStatusResponseFromJson(String str) => SupervisorStatusResponse.fromJson(json.decode(str));

String supervisorStatusResponseToJson(SupervisorStatusResponse data) => json.encode(data.toJson());

class SupervisorStatusResponse {
  SupervisorStatusResponse({
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

  factory SupervisorStatusResponse.fromJson(Map<String, dynamic> json) => SupervisorStatusResponse(
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

  List<Item> items;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    items: json["items"] == null ? null : List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "items": items == null ? null : List<dynamic>.from(items.map((x) => x.toJson())),
  };
}

class Item {
  Item({
    this.getHotelFloors,
    this.getRoomStatuss,
    this.staffList,
    this.totoalRoomCount,
  });

  List<GetHotelFloor> getHotelFloors;
  List<GetRoomStatuss> getRoomStatuss;
  List<StaffList> staffList;
  int totoalRoomCount;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    getHotelFloors: json["getHotelFloors"] == null ? null : List<GetHotelFloor>.from(json["getHotelFloors"].map((x) => GetHotelFloor.fromJson(x))),
    getRoomStatuss: json["getRoomStatuss"] == null ? null : List<GetRoomStatuss>.from(json["getRoomStatuss"].map((x) => GetRoomStatuss.fromJson(x))),
    staffList: json["staffList"] == null ? null : List<StaffList>.from(json["staffList"].map((x) => StaffList.fromJson(x))),
    totoalRoomCount: json["totoalRoomCount"] == null ? null : json["totoalRoomCount"],
  );

  Map<String, dynamic> toJson() => {
    "getHotelFloors": getHotelFloors == null ? null : List<dynamic>.from(getHotelFloors.map((x) => x.toJson())),
    "getRoomStatuss": getRoomStatuss == null ? null : List<dynamic>.from(getRoomStatuss.map((x) => x.toJson())),
    "staffList": staffList == null ? null : List<dynamic>.from(staffList.map((x) => x.toJson())),
    "totoalRoomCount": totoalRoomCount == null ? null : totoalRoomCount,
  };
}

class StaffList {
  StaffList({
    this.maidKey,
    this.name,
  });

  String maidKey;
  String name;

  factory StaffList.fromJson(Map<String, dynamic> json) => StaffList(
    maidKey: json["maidKey"] == null ? null : json["maidKey"],
    name: json["name"] == null ? null : json["name"],
  );

  Map<String, dynamic> toJson() => {
    "maidKey": maidKey == null ? null : maidKey,
    "name": name == null ? null : name,
  };
}
