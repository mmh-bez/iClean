// To parse this JSON data, do
//
//     final attendantModel = attendantModelFromJson(jsonString);

import 'dart:convert';

AttendantModel attendantModelFromJson(String str) => AttendantModel.fromJson(json.decode(str));

String attendantModelToJson(AttendantModel data) => json.encode(data.toJson());

class AttendantModel {
  AttendantModel({
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

  factory AttendantModel.fromJson(Map<String, dynamic> json) => AttendantModel(
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
    this.totalCount,
    this.items,
  });

  int totalCount;
  List<AttendantItem> items;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    totalCount: json["totalCount"] == null ? null : json["totalCount"],
    items: json["items"] == null ? null : List<AttendantItem>.from(json["items"].map((x) => AttendantItem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "totalCount": totalCount == null ? null : totalCount,
    "items": items == null ? null : List<dynamic>.from(items.map((x) => x.toJson())),
  };
}

class AttendantItem {
  AttendantItem({
    this.roomKey,
    this.unit,
    this.maidStatusKey,
    this.maidStatus,
    this.roomStatusKey,
    this.roomStatus,
    this.reservationKey,
    this.roomType,
    this.interconnectRoom,
    this.floor,
    this.linenChange,
    this.dnd,
    this.cleaningTime,
    this.linenDays,
    this.bed,
    this.checkInDate,
    this.checkInTime,
    this.checkOutDate,
    this.checkOutTime,
    this.maid,
    this.hmmNotes,
    this.guestArrived,
    this.status,
    this.preCheckInCount,
    this.guestStatus,
    this.linenChangeDes,
    this.items,
    this.getRoomDndButton,
    this.getStartOrEndTaskButton,
    this.getGuestArrived,
    this.preCheckInCountDes,
    this.roomStatusColor,
    this.attendantStatusColor,
    this.startStatus,
    this.loginStaffKey,
  });

  String roomKey;
  String unit;
  dynamic maidStatusKey;
  String maidStatus;
  dynamic roomStatusKey;
  String roomStatus;
  String reservationKey;
  String roomType;
  String interconnectRoom;
  int floor;
  String linenChange;
  int dnd;
  dynamic cleaningTime;
  dynamic linenDays;
  dynamic bed;
  dynamic checkInDate;
  dynamic checkInTime;
  dynamic checkOutDate;
  dynamic checkOutTime;
  dynamic maid;
  String hmmNotes;
  String guestArrived;
  int status;
  int preCheckInCount;
  String guestStatus;
  String linenChangeDes;
  String items;
  String getRoomDndButton;
  String getStartOrEndTaskButton;
  String getGuestArrived;
  String preCheckInCountDes;
  String roomStatusColor;
  String attendantStatusColor;
  String startStatus;
  String loginStaffKey;

  factory AttendantItem.fromJson(Map<String, dynamic> json) => AttendantItem(
    roomKey: json["roomKey"] == null ? '' : json["roomKey"],
    unit: json["unit"] == null ? '' : json["unit"],
    maidStatusKey: json["maidStatusKey"],
    maidStatus: json["maidStatus"] == null ? '' : json["maidStatus"],
    roomStatusKey: json["roomStatusKey"],
    roomStatus: json["roomStatus"] == null ? '' : json["roomStatus"],
    reservationKey: json["reservationKey"] == null ? '' : json["reservationKey"],
    roomType: json["roomType"] == null ? null : json["roomType"],
    interconnectRoom: json["interconnectRoom"] == null ? '' : json["interconnectRoom"],
    floor: json["floor"] == null ? '' : json["floor"],
    linenChange: json["linenChange"] == null ? '' : json["linenChange"],
    dnd: json["dnd"] == null ? null : json["dnd"],
    cleaningTime: json["cleaningTime"],
    linenDays: json["linenDays"],
    bed: json["bed"],
    checkInDate: json["checkInDate"],
    checkInTime: json["checkInTime"],
    checkOutDate: json["checkOutDate"],
    checkOutTime: json["checkOutTime"],
    maid: json["maid"],
    hmmNotes: json["hmmNotes"] == null ? null : json["hmmNotes"],
    guestArrived: json["guestArrived"] == null ? null : json["guestArrived"],
    status: json["status"] == null ? null : json["status"],
    preCheckInCount: json["preCheckInCount"] == null ? null : json["preCheckInCount"],
    guestStatus: json["guestStatus"] == null ? null : json["guestStatus"],
    linenChangeDes: json["linenChangeDes"] == null ? null : json["linenChangeDes"],
    items: json["items"] == null ? '' : json["items"],
    getRoomDndButton: json["getRoomDNDButton"] == null ? '' : json["getRoomDNDButton"],
    getStartOrEndTaskButton: json["getStartOrEndTaskButton"] == null ? '' : json["getStartOrEndTaskButton"],
    getGuestArrived: json["getGuestArrived"] == null ? null : json["getGuestArrived"],
    preCheckInCountDes: json["preCheckInCountDes"] == null ? null : json["preCheckInCountDes"],
    roomStatusColor: json["roomStatusColor"] == null ? null : json["roomStatusColor"],
    attendantStatusColor: json["attendantStatusColor"] == null ? null : json["attendantStatusColor"],
    startStatus: json["startStatus"] == null ? null : json["startStatus"],
    loginStaffKey: json["loginStaffKey"] == null ? null : json["loginStaffKey"],
  );

  Map<String, dynamic> toJson() => {
    "roomKey": roomKey == null ? null : roomKey,
    "unit": unit == null ? null : unit,
    "maidStatusKey": maidStatusKey,
    "maidStatus": maidStatus == null ? null : maidStatus,
    "roomStatusKey": roomStatusKey,
    "roomStatus": roomStatus == null ? null : roomStatus,
    "reservationKey": reservationKey == null ? null : reservationKey,
    "roomType": roomType == null ? null : roomType,
    "interconnectRoom": interconnectRoom == null ? null : interconnectRoom,
    "floor": floor == null ? null : floor,
    "linenChange": linenChange == null ? null : linenChange,
    "dnd": dnd == null ? null : dnd,
    "cleaningTime": cleaningTime,
    "linenDays": linenDays,
    "bed": bed,
    "checkInDate": checkInDate,
    "checkInTime": checkInTime,
    "checkOutDate": checkOutDate,
    "checkOutTime": checkOutTime,
    "maid": maid,
    "hmmNotes": hmmNotes == null ? null : hmmNotes,
    "guestArrived": guestArrived == null ? null : guestArrived,
    "status": status == null ? null : status,
    "preCheckInCount": preCheckInCount == null ? null : preCheckInCount,
    "guestStatus": guestStatus == null ? null : guestStatus,
    "linenChangeDes": linenChangeDes == null ? null : linenChangeDes,
    "items": items == null ? null : items,
    "getRoomDNDButton": getRoomDndButton == null ? null : getRoomDndButton,
    "getStartOrEndTaskButton": getStartOrEndTaskButton == null ? null : getStartOrEndTaskButton,
    "getGuestArrived": getGuestArrived == null ? null : getGuestArrived,
    "preCheckInCountDes": preCheckInCountDes == null ? null : preCheckInCountDes,
    "roomStatusColor": roomStatusColor == null ? null : roomStatusColor,
    "attendantStatusColor": attendantStatusColor == null ? null : attendantStatusColor,
  };
}
