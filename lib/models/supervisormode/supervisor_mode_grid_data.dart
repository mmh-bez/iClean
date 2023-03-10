// To parse this JSON data, do
//
//     final supervisorModeGridData = supervisorModeGridDataFromMap(jsonString);

import 'dart:convert';

SupervisorModeGridData supervisorModeGridDataFromMap(String str) => SupervisorModeGridData.fromMap(json.decode(str));

class SupervisorModeGridData {
  SupervisorModeGridData({
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

  factory SupervisorModeGridData.fromMap(Map<String, dynamic> json) => SupervisorModeGridData(
    result: Result.fromMap(json["result"]),
    targetUrl: json["targetUrl"],
    success: json["success"],
    error: json["error"],
    unAuthorizedRequest: json["unAuthorizedRequest"],
    abp: json["__abp"],
  );
}

class Result {
  Result({
    this.totalCount,
    this.items,
  });

  int totalCount;
  List<SupervisorModeItem> items;

  factory Result.fromMap(Map<String, dynamic> json) => Result(
    totalCount: json["totalCount"],
    items: List<SupervisorModeItem>.from(json["items"].map((x) => SupervisorModeItem.fromMap(x))),
  );
}

class SupervisorModeItem {
  SupervisorModeItem({
    this.supervisorModeList,
  });

  List<SupervisorModeList> supervisorModeList;

  factory SupervisorModeItem.fromMap(Map<String, dynamic> json) => SupervisorModeItem(
    supervisorModeList: List<SupervisorModeList>.from(json["supervisorModeList"].map((x) => SupervisorModeList.fromMap(x))),
  );

}

class SupervisorModeList {
  SupervisorModeList({
    this.roomKey,
    this.unit,
    this.maidStatus,
    this.roomStatus,
    this.roomType,
    this.interconnectRoom,
    this.linenChange,
    this.dnd,
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
    this.attendantStatusColor,
    this.getRoomDndButton,
    this.getRoomCleanButton,
    this.getRoomDirtyButton,
    this.getHistoryLog,
  });

  String roomKey;
  String unit;
  String maidStatus;
  String roomStatus;
  String roomType;
  String interconnectRoom;
  String linenChange;
  int dnd;
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
  String attendantStatusColor;
  String getRoomDndButton;
  String getRoomCleanButton;
  String getRoomDirtyButton;
  String getHistoryLog;

  factory SupervisorModeList.fromMap(Map<String, dynamic> json) => SupervisorModeList(
    roomKey: json["roomKey"],
    unit: json["unit"],
    maidStatus: json["maidStatus"],
    roomStatus: json["roomStatus"],
    roomType: json["roomType"],
    interconnectRoom: json["interconnectRoom"],
    linenChange: json["linenChange"],
    dnd: json["dnd"],
    maid: json["maid"],
    hmmNotes: json["hmmNotes"],
    guestArrived: json["guestArrived"],
    status: json["status"],
    preCheckInCount: json["preCheckInCount"],
    getGuestArrived: json["getGuestArrived"],
    preCheckInCountDes: json["preCheckInCountDes"],
    linenChangeDes: json["linenChangeDes"],
    roomStatusDes: json["roomStatusDes"],
    roomStatusColor: json["roomStatusColor"],
    attendantStatusColor: json["attendantStatusColor"],
    getRoomDndButton: json["getRoomDNDButton"],
    getRoomCleanButton: json["getRoomCleanButton"],
    getRoomDirtyButton: json["getRoomDirtyButton"],
    getHistoryLog: json["getHistoryLog"],
  );


}
