// To parse this JSON data, do
//
//     final laundryItemResponse = laundryItemResponseFromJson(jsonString);

import 'dart:convert';

LaundryItemResponse laundryItemResponseFromJson(String str) => LaundryItemResponse.fromJson(json.decode(str));

String laundryItemResponseToJson(LaundryItemResponse data) => json.encode(data.toJson());

class LaundryItemResponse {
  LaundryItemResponse({
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

  factory LaundryItemResponse.fromJson(Map<String, dynamic> json) => LaundryItemResponse(
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

  List<LaundryItemModel> items;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    items: json["items"] == null ? null : List<LaundryItemModel>.from(json["items"].map((x) => LaundryItemModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "items": items == null ? null : List<dynamic>.from(items.map((x) => x.toJson())),
  };
}

class LaundryItemModel {
  LaundryItemModel({
    this.reservationKey,
    this.docNo,
    this.checkInDate,
    this.checkOutDate,
    this.guestKey,
    this.guestName,
    this.roomKey,
    this.addedLaundryitems,
    this.laundryItems,
  });

  String reservationKey;
  String docNo;
  DateTime checkInDate;
  DateTime checkOutDate;
  String guestKey;
  String guestName;
  String roomKey;
  List<AddedLaundryitem> addedLaundryitems;
  List<LaundryItem> laundryItems;

  factory LaundryItemModel.fromJson(Map<String, dynamic> json) => LaundryItemModel(
    reservationKey: json["reservationKey"] == null ? null : json["reservationKey"],
    docNo: json["docNo"] == null ? null : json["docNo"],
    checkInDate: json["checkInDate"] == null ? null : DateTime.parse(json["checkInDate"]),
    checkOutDate: json["checkOutDate"] == null ? null : DateTime.parse(json["checkOutDate"]),
    guestKey: json["guestKey"] == null ? null : json["guestKey"],
    guestName: json["guestName"] == null ? null : json["guestName"],
    roomKey: json["roomKey"] == null ? null : json["roomKey"],
    addedLaundryitems: json["addedLaundryitems"] == null ? null : List<AddedLaundryitem>.from(json["addedLaundryitems"].map((x) => AddedLaundryitem.fromJson(x))),
    laundryItems: json["laundryItems"] == null ? null : List<LaundryItem>.from(json["laundryItems"].map((x) => LaundryItem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "reservationKey": reservationKey == null ? null : reservationKey,
    "docNo": docNo == null ? null : docNo,
    "checkInDate": checkInDate == null ? null : checkInDate.toIso8601String(),
    "checkOutDate": checkOutDate == null ? null : checkOutDate.toIso8601String(),
    "guestKey": guestKey == null ? null : guestKey,
    "guestName": guestName == null ? null : guestName,
    "roomKey": roomKey == null ? null : roomKey,
    "addedLaundryitems": addedLaundryitems == null ? null : List<dynamic>.from(addedLaundryitems.map((x) => x.toJson())),
    "laundryItems": laundryItems == null ? null : List<dynamic>.from(laundryItems.map((x) => x.toJson())),
  };
}

class AddedLaundryitem {
  AddedLaundryitem({
    this.itemKey,
    this.postDate,
    this.userName,
    this.description,
    this.postDateDes,
  });

  String itemKey;
  DateTime postDate;
  String userName;
  String description;
  String postDateDes;

  factory AddedLaundryitem.fromJson(Map<String, dynamic> json) => AddedLaundryitem(
    itemKey: json["itemKey"] == null ? null : json["itemKey"],
    postDate: json["postDate"] == null ? null : DateTime.parse(json["postDate"]),
    userName: json["userName"] == null ? null : json["userName"],
    description: json["description"] == null ? null : json["description"],
    postDateDes: json["postDateDes"] == null ? null : json["postDateDes"],
  );

  Map<String, dynamic> toJson() => {
    "itemKey": itemKey == null ? null : itemKey,
    "postDate": postDate == null ? null : postDate.toIso8601String(),
    "userName": userName == null ? null : userName,
    "description": description == null ? null : description,
    "postDateDes": postDateDes == null ? null : postDateDes,
  };
}

class LaundryItem {
  LaundryItem({
    this.itemKey,
    this.description,
    this.salesPrice,
    this.postCodeKey,
  });

  String itemKey;
  String description;
  double salesPrice;
  String postCodeKey;

  factory LaundryItem.fromJson(Map<String, dynamic> json) => LaundryItem(
    itemKey: json["itemKey"] == null ? null : json["itemKey"],
    description: json["description"] == null ? null : json["description"],
    salesPrice: json["salesPrice"] == null ? null : json["salesPrice"].toDouble(),
    postCodeKey: json["postCodeKey"] == null ? null : json["postCodeKey"],
  );

  Map<String, dynamic> toJson() => {
    "itemKey": itemKey == null ? null : itemKey,
    "description": description == null ? null : description,
    "salesPrice": salesPrice == null ? null : salesPrice,
    "postCodeKey": postCodeKey == null ? null : postCodeKey,
  };
}
