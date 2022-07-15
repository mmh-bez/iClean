// To parse this JSON data, do
//
//     final attendantDataModel = attendantDataModelFromJson(jsonString);

import 'dart:convert';

import 'package:i_clean/models/attendant/ddl_room_status_model.dart';
import 'package:i_clean/models/attendant/floor_response_model.dart';
import 'package:i_clean/models/attendant/guest_status_model.dart';
import 'package:i_clean/models/attendant/maid_status_model.dart';

AttendantDataModel attendantDataModelFromJson(String str) => AttendantDataModel.fromJson(json.decode(str));

String attendantDataModelToJson(AttendantDataModel data) => json.encode(data.toJson());

class AttendantDataModel {
  AttendantDataModel({
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

  factory AttendantDataModel.fromJson(Map<String, dynamic> json) => AttendantDataModel(
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
    this.maidStatusListOutPuts,
    this.getGuestStatuss,
  });

  List<GetHotelFloor> getHotelFloors;
  List<GetRoomStatuss> getRoomStatuss;
  List<MaidStatusListOutPut> maidStatusListOutPuts;
  List<GetGuestStatuss> getGuestStatuss;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    getHotelFloors: json["getHotelFloors"] == null ? null : List<GetHotelFloor>.from(json["getHotelFloors"].map((x) => GetHotelFloor.fromJson(x))),
    getRoomStatuss: json["getRoomStatuss"] == null ? null : List<GetRoomStatuss>.from(json["getRoomStatuss"].map((x) => GetRoomStatuss.fromJson(x))),
    maidStatusListOutPuts: json["maidStatusListOutPuts"] == null ? null : List<MaidStatusListOutPut>.from(json["maidStatusListOutPuts"].map((x) => MaidStatusListOutPut.fromJson(x))),
    getGuestStatuss: json["getGuestStatuss"] == null ? null : List<GetGuestStatuss>.from(json["getGuestStatuss"].map((x) => GetGuestStatuss.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "getHotelFloors": getHotelFloors == null ? null : List<dynamic>.from(getHotelFloors.map((x) => x.toJson())),
    "getRoomStatuss": getRoomStatuss == null ? null : List<dynamic>.from(getRoomStatuss.map((x) => x.toJson())),
    "maidStatusListOutPuts": maidStatusListOutPuts == null ? null : List<dynamic>.from(maidStatusListOutPuts.map((x) => x.toJson())),
    "getGuestStatuss": getGuestStatuss == null ? null : List<dynamic>.from(getGuestStatuss.map((x) => x.toJson())),
  };
}








