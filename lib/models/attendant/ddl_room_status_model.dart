class GetRoomStatuss {
  GetRoomStatuss({
    this.roomStatusKey,
    this.roomStatus,
  });

  String roomStatusKey;
  String roomStatus;

  factory GetRoomStatuss.fromJson(Map<String, dynamic> json) => GetRoomStatuss(
    roomStatusKey: json["roomStatusKey"] == null ? null : json["roomStatusKey"],
    roomStatus: json["roomStatus"] == null ? null : json["roomStatus"],
  );

  Map<String, dynamic> toJson() => {
    "roomStatusKey": roomStatusKey == null ? null : roomStatusKey,
    "roomStatus": roomStatus == null ? null : roomStatus,
  };
}