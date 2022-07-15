// To parse this JSON data, do
//
//     final historyModel = historyModelFromJson(jsonString);

import 'dart:convert';

import 'package:i_clean/models/error_model.dart';

HistoryModel historyModelFromJson(String str) => HistoryModel.fromJson(json.decode(str));
class HistoryModel {
  HistoryModel({
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
  ErrorModel error;
  bool unAuthorizedRequest;
  bool abp;

  factory HistoryModel.fromJson(Map<String, dynamic> json) => HistoryModel(
    result: json["result"] == null ? null : Result.fromJson(json["result"]),
    targetUrl: json["targetUrl"],
    success: json["success"] == null ? null : json["success"],
    error: json["error"]== null ? null : ErrorModel.fromJson(json["error"]),
    unAuthorizedRequest: json["unAuthorizedRequest"] == null ? null : json["unAuthorizedRequest"],
    abp: json["__abp"] == null ? null : json["__abp"],
  );

}

class Result {
  Result({
    this.totalCount,
    this.items,
  });

  int totalCount;
  List<HistoryItem> items;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    totalCount: json["totalCount"] == null ? null : json["totalCount"],
    items: json["items"] == null ? null : List<HistoryItem>.from(json["items"].map((x) => HistoryItem.fromJson(x))),
  );
}

class HistoryItem {
  HistoryItem({
    this.history,
  });

  History history;

  factory HistoryItem.fromJson(Map<String, dynamic> json) => HistoryItem(
    history: json["history"] == null ? null : History.fromJson(json["history"]),
  );
}

class History {
  History({
    this.historyKey,
    this.changedDate,
    this.tableName,
    this.detail,
    this.id,
  });

  String historyKey;
  DateTime changedDate;
  String tableName;
  String detail;
  String id;

  factory History.fromJson(Map<String, dynamic> json) => History(
    historyKey: json["historyKey"] == null ? null : json["historyKey"],
    changedDate: json["changedDate"] == null ? null : DateTime.parse(json["changedDate"]),
    tableName: json["tableName"] == null ? null : json["tableName"],
    detail: json["detail"] == null ? null : json["detail"],
    id: json["id"] == null ? null : json["id"],
  );

}
