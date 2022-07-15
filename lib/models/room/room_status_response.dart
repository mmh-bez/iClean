// To parse this JSON data, do
//
//     final roomStatusResponse = roomStatusResponseFromJson(jsonString);

import 'dart:convert';

import '../attendant/ddl_room_status_model.dart';
import '../attendant/floor_response_model.dart';
import '../attendant/guest_status_model.dart';

RoomStatusResponse roomStatusResponseFromJson(String str) => RoomStatusResponse.fromJson(json.decode(str));

String roomStatusResponseToJson(RoomStatusResponse data) => json.encode(data.toJson());

class RoomStatusResponse {
  RoomStatusResponse({
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

  factory RoomStatusResponse.fromJson(Map<String, dynamic> json) => RoomStatusResponse(
    result: json["result"] == null ? null : RoomResult.fromJson(json["result"]),
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

class RoomResult {
  RoomResult({
    this.items,
  });

  List<RoomItems> items;

  factory RoomResult.fromJson(Map<String, dynamic> json) => RoomResult(
    items: json["items"] == null ? null : List<RoomItems>.from(json["items"].map((x) => RoomItems.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "items": items == null ? null : List<dynamic>.from(items.map((x) => x.toJson())),
  };
}

class RoomItems {
  RoomItems({
    this.getHotelFloors,
    this.getRoomStatuss,
    this.getGuestStatuss,
  });

  List<GetHotelFloor> getHotelFloors;
  List<GetRoomStatuss> getRoomStatuss;
  List<GetGuestStatuss> getGuestStatuss;

  factory RoomItems.fromJson(Map<String, dynamic> json) => RoomItems(
    getHotelFloors: json["getHotelFloors"] == null ? null : List<GetHotelFloor>.from(json["getHotelFloors"].map((x) => GetHotelFloor.fromJson(x))),
    getRoomStatuss: json["getRoomStatuss"] == null ? null : List<GetRoomStatuss>.from(json["getRoomStatuss"].map((x) => GetRoomStatuss.fromJson(x))),
    getGuestStatuss: json["getGuestStatuss"] == null ? null : List<GetGuestStatuss>.from(json["getGuestStatuss"].map((x) => GetGuestStatuss.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "getHotelFloors": getHotelFloors == null ? null : List<dynamic>.from(getHotelFloors.map((x) => x.toJson())),
    "getRoomStatuss": getRoomStatuss == null ? null : List<dynamic>.from(getRoomStatuss.map((x) => x.toJson())),
    "getGuestStatuss": getGuestStatuss == null ? null : List<dynamic>.from(getGuestStatuss.map((x) => x.toJson())),
  };
}

