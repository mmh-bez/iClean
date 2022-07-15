// To parse this JSON data, do
//
//     final viewLogResponse = viewLogResponseFromJson(jsonString);

import 'dart:convert';

ViewLogResponse viewLogResponseFromJson(String str) => ViewLogResponse.fromJson(json.decode(str));

String viewLogResponseToJson(ViewLogResponse data) => json.encode(data.toJson());

class ViewLogResponse {
  ViewLogResponse({
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

  factory ViewLogResponse.fromJson(Map<String, dynamic> json) => ViewLogResponse(
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
  List<ViewLogItem> items;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    totalCount: json["totalCount"] == null ? null : json["totalCount"],
    items: json["items"] == null ? null : List<ViewLogItem>.from(json["items"].map((x) => ViewLogItem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "totalCount": totalCount == null ? null : totalCount,
    "items": items == null ? null : List<dynamic>.from(items.map((x) => x.toJson())),
  };
}

class ViewLogItem {
  ViewLogItem({
    this.changedDate,
    this.tableName,
    this.detail,
  });

  DateTime changedDate;
  TableName tableName;
  String detail;

  factory ViewLogItem.fromJson(Map<String, dynamic> json) => ViewLogItem(
    changedDate: json["changedDate"] == null ? null : DateTime.parse(json["changedDate"]),
    tableName: json["tableName"] == null ? null : tableNameValues.map[json["tableName"]],
    detail: json["detail"] == null ? null : json["detail"],
  );

  Map<String, dynamic> toJson() => {
    "changedDate": changedDate == null ? null : changedDate.toIso8601String(),
    "tableName": tableName == null ? null : tableNameValues.reverse[tableName],
    "detail": detail == null ? null : detail,
  };
}

enum TableName { STAFF, WO, ROOM, MINIBAR, LAUNDRY, ROOM_DND }

final tableNameValues = EnumValues({
  "Laundry": TableName.LAUNDRY,
  "Minibar": TableName.MINIBAR,
  "Room": TableName.ROOM,
  "RoomDND": TableName.ROOM_DND,
  "Staff": TableName.STAFF,
  "WO": TableName.WO
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
