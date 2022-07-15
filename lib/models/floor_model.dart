// To parse this JSON data, do
//
//     final lostAndFoundDataModel = lostAndFoundDataModelFromJson(jsonString);

import 'dart:convert';

import 'package:i_clean/models/attendant/floor_response_model.dart';

HotelFloorResponse hotelFloorResponseFromJson(String str) => HotelFloorResponse.fromJson(json.decode(str));

class HotelFloorResponse {
  HotelFloorResponse({
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

  factory HotelFloorResponse.fromJson(Map<String, dynamic> json) => HotelFloorResponse(
    result: json["result"] == null ? null : Result.fromJson(json["result"]),
    targetUrl: json["targetUrl"],
    success: json["success"] == null ? null : json["success"],
    error: json["error"],
    unAuthorizedRequest: json["unAuthorizedRequest"] == null ? null : json["unAuthorizedRequest"],
    abp: json["__abp"] == null ? null : json["__abp"],
  );

}

class Result {
  Result({
    this.floorItems,
  });

  List<GetHotelFloor> floorItems;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    floorItems: json["items"] == null ? null : List<GetHotelFloor>.from(json["items"].map((x) => GetHotelFloor.fromJson(x))),
  );

}
