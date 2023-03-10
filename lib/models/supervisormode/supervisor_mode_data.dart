// To parse this JSON data, do
//
//     final supervisorModeData = supervisorModeDataFromMap(jsonString);

import 'dart:convert';

import '../attendant/ddl_room_status_model.dart';
import '../attendant/floor_response_model.dart';
import '../supervisor/super_visor_status_response.dart';

SupervisorModeData supervisorModeDataFromMap(String str) => SupervisorModeData.fromMap(json.decode(str));

class SupervisorModeData {
  SupervisorModeData({
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

  factory SupervisorModeData.fromMap(Map<String, dynamic> json) => SupervisorModeData(
    result: Result.fromMap(json["result"]),
    targetUrl: json["targetUrl"],
    success: json["success"],
    error: json["error"],
    unAuthorizedRequest: json["unAuthorizedRequest"],
    abp: json["__abp"],
  );

}

class Result {
  Result({
    this.items,
  });

  List<Item> items;

  factory Result.fromMap(Map<String, dynamic> json) => Result(
    items: List<Item>.from(json["items"].map((x) => Item.fromMap(x))),
  );

}

class Item {
  Item({
    this.getHotelFloors,
    this.getRoomStatuss,
    this.staffList,
    this.maidStatusCount,
  });

  List<GetHotelFloor> getHotelFloors;
  List<GetRoomStatuss> getRoomStatuss;
  List<StaffList> staffList;
  List<MaidStatusCount> maidStatusCount;

  factory Item.fromMap(Map<String, dynamic> json) => Item(
    getHotelFloors: List<GetHotelFloor>.from(json["getHotelFloors"].map((x) => GetHotelFloor.fromJson(x))),
    getRoomStatuss: List<GetRoomStatuss>.from(json["getRoomStatuss"].map((x) => GetRoomStatuss.fromJson(x))),
    staffList: List<StaffList>.from(json["staffList"].map((x) => StaffList.fromJson(x))),
    maidStatusCount: List<MaidStatusCount>.from(json["maidStatusCount"].map((x) => MaidStatusCount.fromMap(x))),
  );

}

class MaidStatusCount {
  MaidStatusCount({
    this.maidStatus,
    this.roomCount,
  });

  String maidStatus;
  int roomCount;

  factory MaidStatusCount.fromMap(Map<String, dynamic> json) => MaidStatusCount(
    maidStatus: json["maidStatus"],
    roomCount: json["roomCount"],
  );

  Map<String, dynamic> toMap() => {
    "maidStatus": maidStatus,
    "roomCount": roomCount,
  };
}
