// To parse this JSON data, do
//
//     final checkLIstModel = checkLIstModelFromJson(jsonString);

import 'dart:convert';

CheckLIstModel checkLIstModelFromJson(String str) => CheckLIstModel.fromJson(json.decode(str));

String checkLIstModelToJson(CheckLIstModel data) => json.encode(data.toJson());

class CheckLIstModel {
  CheckLIstModel({
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

  factory CheckLIstModel.fromJson(Map<String, dynamic> json) => CheckLIstModel(
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

  List<CheckListItem> items;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    items: json["items"] == null ? null : List<CheckListItem>.from(json["items"].map((x) => CheckListItem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "items": items == null ? null : List<dynamic>.from(items.map((x) => x.toJson())),
  };
}

class CheckListItem {
  CheckListItem({
    this.attendantCheckList,
    this.roomKey,
  });

  List<AttendantCheckList> attendantCheckList;
  String roomKey;

  factory CheckListItem.fromJson(Map<String, dynamic> json) => CheckListItem(
    attendantCheckList: json["attendantCheckList"] == null ? null : List<AttendantCheckList>.from(json["attendantCheckList"].map((x) => AttendantCheckList.fromJson(x))),
    roomKey: json["roomKey"] == null ? null : json["roomKey"],
  );

  Map<String, dynamic> toJson() => {
    "attendantCheckList": attendantCheckList == null ? null : List<dynamic>.from(attendantCheckList.map((x) => x.toJson())),
    "roomKey": roomKey == null ? null : roomKey,
  };
}

class AttendantCheckList {
  AttendantCheckList({
    this.linenChecklistKey,
    this.itemKey,
    this.quantity,
    this.itemCode,
    this.description,
    this.combined,
  });

  String linenChecklistKey;
  String itemKey;
  int quantity;
  dynamic itemCode;
  dynamic description;
  String combined;

  factory AttendantCheckList.fromJson(Map<String, dynamic> json) => AttendantCheckList(
    linenChecklistKey: json["linenChecklistKey"] == null ? null : json["linenChecklistKey"],
    itemKey: json["itemKey"] == null ? null : json["itemKey"],
    quantity: json["quantity"] == null ? null : json["quantity"],
    itemCode: json["itemCode"],
    description: json["description"],
    combined: json["combined"] == null ? null : json["combined"],
  );

  Map<String, dynamic> toJson() => {
    "linenChecklistKey": linenChecklistKey == null ? null : linenChecklistKey,
    "itemKey": itemKey == null ? null : itemKey,
    "quantity": quantity == null ? null : quantity,
    "itemCode": itemCode,
    "description": description,
    "combined": combined == null ? null : combined,
  };
}
