

import 'dart:convert';

MinibarItemResponse minibarItemResponseFromJson(String str) => MinibarItemResponse.fromJson(json.decode(str));

class MinibarItemResponse {
  MinibarItemResponse({
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

  factory MinibarItemResponse.fromJson(Map<String, dynamic> json) => MinibarItemResponse(
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

  List<MinibarItemModel> items;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    items: json["items"] == null ? null : List<MinibarItemModel>.from(json["items"].map((x) => MinibarItemModel.fromJson(x))),
  );
}

class MinibarItemModel {
  MinibarItemModel({
    this.reservationKey,
    this.docNo,
    this.checkInDate,
    this.checkOutDate,
    this.guestKey,
    this.guestName,
    this.roomKey,
    this.addedMinibarItems,
    this.minibarItems,
  });

  String reservationKey;
  String docNo;
  DateTime checkInDate;
  DateTime checkOutDate;
  String guestKey;
  String guestName;
  String roomKey;
  List<AddedMinibarItem> addedMinibarItems;
  List<MinibarItem> minibarItems;

  factory MinibarItemModel.fromJson(Map<String, dynamic> json) => MinibarItemModel(
    reservationKey: json["reservationKey"] == null ? null : json["reservationKey"],
    docNo: json["docNo"] == null ? null : json["docNo"],
    checkInDate: json["checkInDate"] == null ? null : DateTime.parse(json["checkInDate"]),
    checkOutDate: json["checkOutDate"] == null ? null : DateTime.parse(json["checkOutDate"]),
    guestKey: json["guestKey"] == null ? null : json["guestKey"],
    guestName: json["guestName"] == null ? null : json["guestName"],
    roomKey: json["roomKey"] == null ? null : json["roomKey"],
    addedMinibarItems: json["addedMinibaritems"] == null ? null : List<AddedMinibarItem>.from(json["addedMinibaritems"].map((x) => AddedMinibarItem.fromJson(x))),
    minibarItems: json["minibarItems"] == null ? null : List<MinibarItem>.from(json["minibarItems"].map((x) => MinibarItem.fromJson(x))),
  );

}

class AddedMinibarItem {
  AddedMinibarItem({
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

  factory AddedMinibarItem.fromJson(Map<String, dynamic> json) => AddedMinibarItem(
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

class MinibarItem {
  MinibarItem({
    this.itemKey,
    this.description,
    this.salesPrice,
    this.postCodeKey,
  });

  String itemKey;
  String description;
  double salesPrice;
  String postCodeKey;

  factory MinibarItem.fromJson(Map<String, dynamic> json) => MinibarItem(
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
