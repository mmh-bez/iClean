// To parse this JSON data, do
//
//     final selectedItemModel = selectedItemModelFromJson(jsonString);

import 'dart:convert';

SelectedItemModel selectedItemModelFromJson(String str) => SelectedItemModel.fromJson(json.decode(str));

String selectedItemModelToJson(SelectedItemModel data) => json.encode(data.toJson());

class SelectedItemModel {
  SelectedItemModel({
    this.itemSelected,
    this.roomNo,
    this.voucherNo,
    this.reservationKey,
    this.roomKey,
  });

  List<ItemSelected> itemSelected;
  String roomNo;
  String voucherNo;
  String reservationKey;
  String roomKey;

  factory SelectedItemModel.fromJson(Map<String, dynamic> json) => SelectedItemModel(
    itemSelected: json["itemSelected"] == null ? null : List<ItemSelected>.from(json["itemSelected"].map((x) => ItemSelected.fromJson(x))),
    roomNo: json["roomNo"] == null ? null : json["roomNo"],
    voucherNo: json["voucherNo"] == null ? null : json["voucherNo"],
    reservationKey: json["reservationKey"] == null ? null : json["reservationKey"],
    roomKey: json["roomKey"] == null ? null : json["roomKey"],
  );

  Map<String, dynamic> toJson() => {
    "itemSelected": itemSelected == null ? null : List<dynamic>.from(itemSelected.map((x) => x.toJson())),
    "roomNo": roomNo == null ? null : roomNo,
    "voucherNo": voucherNo == null ? null : voucherNo,
    "reservationKey": reservationKey == null ? null : reservationKey,
    "roomKey": roomKey == null ? null : roomKey,
  };
}

class ItemSelected {
  ItemSelected({

    this.itemKey,
    this.description,
    this.qty,
    this.salesPrice,
    this.postCodeKey,
  });

  String itemKey;
  String description;
  int qty;
  int salesPrice;
  String postCodeKey;

  factory ItemSelected.fromJson(Map<String, dynamic> json) => ItemSelected(

    itemKey: json["itemKey"] == null ? null : json["itemKey"],
    description: json["description"] == null ? null : json["description"],
    qty: json["qty"] == null ? null : json["qty"],
    salesPrice: json["salesPrice"] == null ? null : json["salesPrice"],
    postCodeKey: json["postCodeKey"] == null ? null : json["postCodeKey"],
  );

  Map<String, dynamic> toJson() => {

    "itemKey": itemKey == null ? null : itemKey,
    "description": description == null ? null : description,
    "qty": qty == null ? null : qty,
    "salesPrice": salesPrice == null ? null : salesPrice,
    "postCodeKey": postCodeKey == null ? null : postCodeKey,
  };
}
