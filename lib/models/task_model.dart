// To parse this JSON data, do
//
//     final dashboardModel = dashboardModelFromJson(jsonString);

import 'dart:convert';

TaskModel dashboardModelFromJson(String str) => TaskModel.fromJson(json.decode(str));

String dashboardModelToJson(TaskModel data) => json.encode(data.toJson());

class TaskModel {
  TaskModel({
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

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
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

  List<TaskItem> items;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    items: json["items"] == null ? null : List<TaskItem>.from(json["items"].map((x) => TaskItem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "items": items == null ? null : List<dynamic>.from(items.map((x) => x.toJson())),
  };
}

class TaskItem {
  TaskItem({
    this.assignedTask,
    this.roomToInspect,
  });

  int assignedTask;
  int roomToInspect;

  factory TaskItem.fromJson(Map<String, dynamic> json) => TaskItem(
    assignedTask: json["assignedTask"] == null ? null : json["assignedTask"],
    roomToInspect: json["roomToInspect"] == null ? null : json["roomToInspect"],
  );

  Map<String, dynamic> toJson() => {
    "assignedTask": assignedTask == null ? null : assignedTask,
    "roomToInspect": roomToInspect == null ? null : roomToInspect,
  };
}
