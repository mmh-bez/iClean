// To parse this JSON data, do
//
//     final supervisorCheckListResponse = supervisorCheckListResponseFromJson(jsonString);

import 'dart:convert';

SupervisorCheckListResponse supervisorCheckListResponseFromJson(String str) => SupervisorCheckListResponse.fromJson(json.decode(str));

String supervisorCheckListResponseToJson(SupervisorCheckListResponse data) => json.encode(data.toJson());

class SupervisorCheckListResponse {
  SupervisorCheckListResponse({
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

  factory SupervisorCheckListResponse.fromJson(Map<String, dynamic> json) => SupervisorCheckListResponse(
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

  List<SupCheckItem> items;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    items: json["items"] == null ? null : List<SupCheckItem>.from(json["items"].map((x) => SupCheckItem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "items": items == null ? null : List<dynamic>.from(items.map((x) => x.toJson())),
  };
}

String subCheckItemToJson(SupCheckItem data) => json.encode(data.toJson());
class SupCheckItem {
  SupCheckItem({
    this.supCheckList,
    this.roomKey,
  });

  List<SupCheckList> supCheckList;
  String roomKey;

  factory SupCheckItem.fromJson(Map<String, dynamic> json) => SupCheckItem(
    supCheckList: json["supCheckList"] == null ? null : List<SupCheckList>.from(json["supCheckList"].map((x) => SupCheckList.fromJson(x))),
    roomKey: json["roomKey"] == null ? null : json["roomKey"],
  );

  Map<String, dynamic> toJson() => {
    "supCheckList": supCheckList == null ? null : List<dynamic>.from(supCheckList.map((x) => x.toJson())),
    "roomKey": roomKey == null ? null : roomKey,
  };
}

class SupCheckList {
  SupCheckList({
    this.inspectionChecklistKey,
    this.itemKey,
    this.quantity,
    this.combined,
    this.checked,
    this.chkLinenItem,
  });

  String inspectionChecklistKey;
  String itemKey;
  String quantity;
  String combined;
  int checked;
  bool chkLinenItem;

  factory SupCheckList.fromJson(Map<String, dynamic> json) => SupCheckList(
    inspectionChecklistKey: json["inspectionChecklistKey"] == null ? null : json["inspectionChecklistKey"],
    itemKey: json["itemKey"] == null ? null : json["itemKey"],
    quantity: json["quantity"] == null ? null : json["quantity"],
    combined: json["combined"] == null ? null : json["combined"],
    checked: json["checked"] == null ? null : json["checked"],
    chkLinenItem: json["chkLinenItem"] == null ? null : json["chkLinenItem"],
  );

  Map<String, dynamic> toJson() => {
    "inspectionChecklistKey": inspectionChecklistKey == null ? null : inspectionChecklistKey,
    "itemKey": itemKey == null ? null : itemKey,
    "quantity": quantity == null ? null : quantity,
    "combined": combined == null ? null : combined,
    "checked": checked == null ? null : checked,
    "chkLinenItem": chkLinenItem == null ? null : chkLinenItem,
  };
}
