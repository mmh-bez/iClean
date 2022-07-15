// To parse this JSON data, do
//
//     final lostAndFoundEditResponse = lostAndFoundEditResponseFromJson(jsonString);

import 'dart:convert';

LostAndFoundEditResponse lostAndFoundEditResponseFromJson(String str) => LostAndFoundEditResponse.fromJson(json.decode(str));

String lostAndFoundEditResponseToJson(LostAndFoundEditResponse data) => json.encode(data.toJson());

class LostAndFoundEditResponse {
  LostAndFoundEditResponse({
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

  factory LostAndFoundEditResponse.fromJson(Map<String, dynamic> json) => LostAndFoundEditResponse(
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
    this.lostFound,
  });

  LostFoundEditData lostFound;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    lostFound: json["lostFound"] == null ? null : LostFoundEditData.fromJson(json["lostFound"]),
  );

  Map<String, dynamic> toJson() => {
    "lostFound": lostFound == null ? null : lostFound.toJson(),
  };
}

class LostFoundEditData {
  LostFoundEditData({
    this.lostFoundStatusKey,
    this.reportedDate,
    this.itemName,
    this.area,
    this.owner,
    this.ownerFolio,
    this.ownerRoomKey,
    this.ownerContactNo,
    this.founder,
    this.founderFolio,
    this.founderRoomKey,
    this.founderContactNo,
    this.description,
    this.instruction,
    this.additionalInfo,
    this.staffKey,
    this.reference,
    this.id,
  });

  String lostFoundStatusKey;
  DateTime reportedDate;
  String itemName;
  int area;
  String owner;
  String ownerFolio;
  String ownerRoomKey;
  String ownerContactNo;
  String founder;
  String founderFolio;
  String founderRoomKey;
  String founderContactNo;
  String description;
  String instruction;
  String additionalInfo;
  String staffKey;
  String reference;
  String id;

  factory LostFoundEditData.fromJson(Map<String, dynamic> json) => LostFoundEditData(
    lostFoundStatusKey: json["lostFoundStatusKey"] == null ? null : json["lostFoundStatusKey"],
    reportedDate: json["reportedDate"] == null ? null : DateTime.parse(json["reportedDate"]),
    itemName: json["itemName"] == null ? null : json["itemName"],
    area: json["area"] == null ? null : json["area"],
    owner: json["owner"] == null ? null : json["owner"],
    ownerFolio: json["ownerFolio"] == null ? null : json["ownerFolio"],
    ownerRoomKey: json["ownerRoomKey"] == null ? null : json["ownerRoomKey"],
    ownerContactNo: json["ownerContactNo"] == null ? null : json["ownerContactNo"],
    founder: json["founder"] == null ? null : json["founder"],
    founderFolio: json["founderFolio"] == null ? null : json["founderFolio"],
    founderRoomKey: json["founderRoomKey"] == null ? null : json["founderRoomKey"],
    founderContactNo: json["founderContactNo"] == null ? null : json["founderContactNo"],
    description: json["description"] == null ? null : json["description"],
    instruction: json["instruction"] == null ? null : json["instruction"],
    additionalInfo: json["additionalInfo"] == null ? null : json["additionalInfo"],
    staffKey: json["staffKey"] == null ? null : json["staffKey"],
    reference: json["reference"] == null ? null : json["reference"],
    id: json["id"] == null ? null : json["id"],
  );

  Map<String, dynamic> toJson() => {
    "lostFoundStatusKey": lostFoundStatusKey == null ? null : lostFoundStatusKey,
    "reportedDate": reportedDate == null ? null : reportedDate.toIso8601String(),
    "itemName": itemName == null ? null : itemName,
    "area": area == null ? null : area,
    "owner": owner == null ? null : owner,
    "ownerFolio": ownerFolio == null ? null : ownerFolio,
    "ownerRoomKey": ownerRoomKey == null ? null : ownerRoomKey,
    "ownerContactNo": ownerContactNo == null ? null : ownerContactNo,
    "founder": founder == null ? null : founder,
    "founderFolio": founderFolio == null ? null : founderFolio,
    "founderRoomKey": founderRoomKey == null ? null : founderRoomKey,
    "founderContactNo": founderContactNo == null ? null : founderContactNo,
    "description": description == null ? null : description,
    "instruction": instruction == null ? null : instruction,
    "additionalInfo": additionalInfo == null ? null : additionalInfo,
    "staffKey": staffKey == null ? null : staffKey,
    "reference": reference == null ? null : reference,
    "id": id == null ? null : id,
  };
}
