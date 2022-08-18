// To parse this JSON data, do
//
//     final supervisorGridResponse = supervisorGridResponseFromJson(jsonString);

import 'dart:convert';

SupervisorGridResponse supervisorGridResponseFromJson(String str) => SupervisorGridResponse.fromJson(json.decode(str));

String supervisorGridResponseToJson(SupervisorGridResponse data) => json.encode(data.toJson());

class SupervisorGridResponse {
  SupervisorGridResponse({
    this.result,
    this.targetUrl,
    this.success,
    this.error,
    this.unAuthorizedRequest,
    this.abp,
  });

  SuperVisorResult result;
  dynamic targetUrl;
  bool success;
  dynamic error;
  bool unAuthorizedRequest;
  bool abp;

  factory SupervisorGridResponse.fromJson(Map<String, dynamic> json) => SupervisorGridResponse(
    result: json["result"] == null ? null : SuperVisorResult.fromJson(json["result"]),
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

class SuperVisorResult {
  SuperVisorResult({
    this.totalCount,
    this.items,
  });

  int totalCount;
  List<SuperVisorItem> items;

  factory SuperVisorResult.fromJson(Map<String, dynamic> json) => SuperVisorResult(
    totalCount: json["totalCount"] == null ? null : json["totalCount"],
    items: json["items"] == null ? null : List<SuperVisorItem>.from(json["items"].map((x) => SuperVisorItem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "totalCount": totalCount == null ? null : totalCount,
    "items": items == null ? null : List<dynamic>.from(items.map((x) => x.toJson())),
  };
}

class SuperVisorItem {
  SuperVisorItem({
    this.roomKey,
    this.unit,
    this.maidStatusKey,
    this.maidStatus,
    this.roomStatusKey,
    this.roomStatus,
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
    this.getGuestArrived,
    this.preCheckInCountDes,
    this.linenChangeDes,
    this.roomStatusDes,
    this.roomStatusColor,
    this.getRoomDndButton,
    this.getRoomCleanButton,
    this.getRoomDirtyButton,
    this.getLinenItemButton,
    this.getHistoryLog,
  });

  String roomKey;
  String unit;
  String maidStatusKey;
  String maidStatus;
  String roomStatusKey;
  String roomStatus;
  String roomType;
  String interconnectRoom;
  int floor;
  String linenChange;
  int dnd;
  String cleaningTime;
  int linenDays;
  int bed;
  dynamic checkInDate;
  dynamic checkInTime;
  dynamic checkOutDate;
  dynamic checkOutTime;
  String maid;
  String hmmNotes;
  String guestArrived;
  int status;
  int preCheckInCount;
  String getGuestArrived;
  String preCheckInCountDes;
  String linenChangeDes;
  String roomStatusDes;
  String roomStatusColor;
  String getRoomDndButton;
  String getRoomCleanButton;
  String getRoomDirtyButton;
  String getLinenItemButton;
  String getHistoryLog;

  factory SuperVisorItem.fromJson(Map<String, dynamic> json) => SuperVisorItem(
    roomKey: json["roomKey"] == null ? null : json["roomKey"],
    unit: json["unit"] == null ? null : json["unit"],
    maidStatusKey: json["maidStatusKey"] == null ? null : json["maidStatusKey"],
    maidStatus: json["maidStatus"] == null ? null : json["maidStatus"],
    roomStatusKey: json["roomStatusKey"] == null ? null : json["roomStatusKey"],
    roomStatus: json["roomStatus"] == null ? null : json["roomStatus"],
    roomType: json["roomType"] == null ? null : json["roomType"],
    interconnectRoom: json["interconnectRoom"] == null ? null : json["interconnectRoom"],
    floor: json["floor"] == null ? null : json["floor"],
    linenChange: json["linenChange"] == null ? null : json["linenChange"],
    dnd: json["dnd"] == null ? null : json["dnd"],
    cleaningTime: json["cleaningTime"] == null ? null : json["cleaningTime"],
    linenDays: json["linenDays"] == null ? null : json["linenDays"],
    bed: json["bed"] == null ? null : json["bed"],
    checkInDate: json["checkInDate"],
    checkInTime: json["checkInTime"],
    checkOutDate: json["checkOutDate"],
    checkOutTime: json["checkOutTime"],
    maid: json["maid"] == null ? null : json["maid"],
    hmmNotes: json["hmmNotes"] == null ? null : json["hmmNotes"],
    guestArrived: json["guestArrived"] == null ? null : json["guestArrived"],
    status: json["status"] == null ? null : json["status"],
    preCheckInCount: json["preCheckInCount"] == null ? null : json["preCheckInCount"],
    getGuestArrived: json["getGuestArrived"] == null ? null : json["getGuestArrived"],
    preCheckInCountDes: json["preCheckInCountDes"] == null ? null : json["preCheckInCountDes"],
    linenChangeDes: json["linenChangeDes"] == null ? null : json["linenChangeDes"],
    roomStatusDes: json["roomStatusDes"] == null ? null : json["roomStatusDes"],
    roomStatusColor: json["roomStatusColor"] == null ? null : json["roomStatusColor"],
    getRoomDndButton: json["getRoomDNDButton"] == null ? null : json["getRoomDNDButton"],
    getRoomCleanButton: json["getRoomCleanButton"] == null ? null : json["getRoomCleanButton"],
    getRoomDirtyButton: json["getRoomDirtyButton"] == null ? null : json["getRoomDirtyButton"],
    getLinenItemButton: json["getLinenItemButton"] == null ? null : json["getLinenItemButton"],
    getHistoryLog: json["getHistoryLog"] == null ? null : json["getHistoryLog"],
  );

  Map<String, dynamic> toJson() => {
    "roomKey": roomKey == null ? null : roomKey,
    "unit": unit == null ? null : unit,
    "maidStatusKey": maidStatusKey == null ? null : maidStatusKey,
    "maidStatus": maidStatus == null ? null : maidStatus,
    "roomStatusKey": roomStatusKey == null ? null : roomStatusKey,
    "roomStatus": roomStatus == null ? null : roomStatus,
    "roomType": roomType == null ? null : roomType,
    "interconnectRoom": interconnectRoom == null ? null : interconnectRoom,
    "floor": floor == null ? null : floor,
    "linenChange": linenChange == null ? null : linenChange,
    "dnd": dnd == null ? null : dnd,
    "cleaningTime": cleaningTime == null ? null : cleaningTime,
    "linenDays": linenDays == null ? null : linenDays,
    "bed": bed == null ? null : bed,
    "checkInDate": checkInDate,
    "checkInTime": checkInTime,
    "checkOutDate": checkOutDate,
    "checkOutTime": checkOutTime,
    "maid": maid == null ? null : maid,
    "hmmNotes": hmmNotes == null ? null : hmmNotes,
    "guestArrived": guestArrived == null ? null : guestArrived,
    "status": status == null ? null : status,
    "preCheckInCount": preCheckInCount == null ? null : preCheckInCount,
    "getGuestArrived": getGuestArrived == null ? null : getGuestArrived,
    "preCheckInCountDes": preCheckInCountDes == null ? null : preCheckInCountDes,
    "linenChangeDes": linenChangeDes == null ? null : linenChangeDes,
    "roomStatusDes": roomStatusDes == null ? null : roomStatusDes,
    "roomStatusColor": roomStatusColor == null ? null : roomStatusColor,
    "getRoomDNDButton": getRoomDndButton == null ? null : getRoomDndButton,
    "getRoomCleanButton": getRoomCleanButton == null ? null : getRoomCleanButton,
    "getRoomDirtyButton": getRoomDirtyButton == null ? null : getRoomDirtyButton,
    "getLinenItemButton": getLinenItemButton == null ? null : getLinenItemButton,
    "getHistoryLog": getHistoryLog == null ? null : getHistoryLog,
  };
}
