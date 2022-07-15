// To parse this JSON data, do
//
//     final lostAndFoundData = lostAndFoundDataFromJson(jsonString);

import 'dart:convert';

LostAndFoundData lostAndFoundDataFromJson(String str) => LostAndFoundData.fromJson(json.decode(str));

class LostAndFoundData {
  LostAndFoundData({
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

  factory LostAndFoundData.fromJson(Map<String, dynamic> json) => LostAndFoundData(
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
    this.items,
  });

  List<LostAndFoundItem> items;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    items: json["items"] == null ? null : List<LostAndFoundItem>.from(json["items"].map((x) => LostAndFoundItem.fromJson(x))),
  );


}

class LostAndFoundItem {
  LostAndFoundItem({
    this.lostFoundKey,
    this.autoReference,
    this.reference,
    this.reportedDate,
    this.itemName,
    this.lostFoundStatus,
    this.mArea,
    this.owner,
    this.founder,
    this.description,
    this.instruction,
    this.additionalInfo,
  });

  String lostFoundKey;
  String autoReference;
  String reference;
  DateTime reportedDate;
  String itemName;
  String lostFoundStatus;
  String mArea;
  String owner;
  String founder;
  String description;
  String instruction;
  String additionalInfo;

  factory LostAndFoundItem.fromJson(Map<String, dynamic> json) => LostAndFoundItem(
    lostFoundKey: json["lostFoundKey"] == null ? "" : json["lostFoundKey"],
    autoReference: json["autoReference"] == null ? "" : json["autoReference"],
    reference: json["reference"] == null ? "" : json["reference"],
    reportedDate: json["reportedDate"] == "" ? null : DateTime.parse(json["reportedDate"]),
    itemName: json["itemName"] == null ? "" : json["itemName"],
    lostFoundStatus: json["lostFoundStatus"] == null ? "" : json["lostFoundStatus"],
    mArea: json["mArea"] == null ? "" : json["mArea"],
    owner: json["owner"] == null ? "" : json["owner"],
    founder: json["founder"] == null ? "" : json["founder"],
    description: json["description"] == "" ? null : json["description"],
    instruction: json["instruction"] == null ? "" : json["instruction"],
    additionalInfo: json["additionalInfo"] == null ? "" : json["additionalInfo"],
  );

  Map<String, dynamic> toJson() => {
    "lostFoundKey": lostFoundKey == null ? null : lostFoundKey,
    "autoReference": autoReference == null ? null : autoReference,
    "reference": reference == null ? null : reference,
    "reportedDate": reportedDate == null ? null : reportedDate.toIso8601String(),
    "itemName": itemName == null ? null : itemName,
    "lostFoundStatus": lostFoundStatus == null ? null : lostFoundStatus,
    "mArea": mArea == null ? null : mArea,
    "owner": owner == null ? null : owner,
    "founder": founder == null ? null : founder,
    "description": description == null ? null : description,
    "instruction": instruction == null ? null : instruction,
    "additionalInfo": additionalInfo == null ? null : additionalInfo,
  };
}
