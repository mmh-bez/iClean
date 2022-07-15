// To parse this JSON data, do
//
//     final historyLogOfRoom = historyLogOfRoomFromJson(jsonString);

import 'dart:convert';

HistoryLogOfRoom historyLogOfRoomFromJson(String str) => HistoryLogOfRoom.fromJson(json.decode(str));

String historyLogOfRoomToJson(HistoryLogOfRoom data) => json.encode(data.toJson());

class HistoryLogOfRoom {
  HistoryLogOfRoom({
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

  factory HistoryLogOfRoom.fromJson(Map<String, dynamic> json) => HistoryLogOfRoom(
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

  List<HistoryLogOfRoomItem> items;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    items: json["items"] == null ? null : List<HistoryLogOfRoomItem>.from(json["items"].map((x) => HistoryLogOfRoomItem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "items": items == null ? null : List<dynamic>.from(items.map((x) => x.toJson())),
  };
}

class HistoryLogOfRoomItem {
  HistoryLogOfRoomItem({
    this.getDateTimeToDisplay,
  });

  String getDateTimeToDisplay;

  factory HistoryLogOfRoomItem.fromJson(Map<String, dynamic> json) => HistoryLogOfRoomItem(
    getDateTimeToDisplay: json["getDateTimeToDisplay"] == null ? null : json["getDateTimeToDisplay"],
  );

  Map<String, dynamic> toJson() => {
    "getDateTimeToDisplay": getDateTimeToDisplay == null ? null : getDateTimeToDisplay,
  };
}
