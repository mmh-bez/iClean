class MaidStatusListOutPut {
  MaidStatusListOutPut({
    this.maidStatus,
    this.roomCount,
  });

  String maidStatus;
  int roomCount;

  factory MaidStatusListOutPut.fromJson(Map<String, dynamic> json) => MaidStatusListOutPut(
    maidStatus: json["maidStatus"] == null ? null : json["maidStatus"],
    roomCount: json["roomCount"] == null ? null : json["roomCount"],
  );

  Map<String, dynamic> toJson() => {
    "maidStatus": maidStatus == null ? null : maidStatus,
    "roomCount": roomCount == null ? null : roomCount,
  };
}