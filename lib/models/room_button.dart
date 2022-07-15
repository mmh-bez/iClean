// To parse this JSON data, do
//
//     final roomButtonModel = roomButtonModelFromJson(jsonString);

import 'dart:convert';

RoomButtonModel roomButtonModelFromJson(String str) => RoomButtonModel.fromJson(json.decode(str));

String roomButtonModelToJson(RoomButtonModel data) => json.encode(data.toJson());

class RoomButtonModel {
  RoomButtonModel({
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

  factory RoomButtonModel.fromJson(Map<String, dynamic> json) => RoomButtonModel(
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
    this.totalCount,
    this.items,
  });

  int totalCount;
  List<RoomButtonItem> items;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    totalCount: json["totalCount"] == null ? null : json["totalCount"],
    items: json["items"] == null ? null : List<RoomButtonItem>.from(json["items"].map((x) => RoomButtonItem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "totalCount": totalCount == null ? null : totalCount,
    "items": items == null ? null : List<dynamic>.from(items.map((x) => x.toJson())),
  };
}

class RoomButtonItem {
  RoomButtonItem({
    this.room,
    this.roomStatus,
  });

  String room;
  RoomStatus roomStatus;

  factory RoomButtonItem.fromJson(Map<String, dynamic> json) => RoomButtonItem(
    room: json["room"] == null ? null : json["room"],
    roomStatus: json["roomStatus"] == null ? null : roomStatusValues.map[json["roomStatus"]],
  );

  Map<String, dynamic> toJson() => {
    "room": room == null ? null : room,
    "roomStatus": roomStatus == null ? null : roomStatusValues.reverse[roomStatus],
  };
}

enum RoomStatus { VACANT, OCCUPIED, HOLD }

final roomStatusValues = EnumValues({
  "Hold": RoomStatus.HOLD,
  "Occupied": RoomStatus.OCCUPIED,
  "Vacant": RoomStatus.VACANT
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
