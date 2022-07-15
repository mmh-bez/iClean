class GetHotelFloor {
  GetHotelFloor({
    this.floor,
    this.btnFloor,
  });

  String floor;
  String btnFloor;

  factory GetHotelFloor.fromJson(Map<String, dynamic> json) => GetHotelFloor(
    floor: json["floor"] == null ? null : json["floor"],
    btnFloor: json["btnFloor"] == null ? null : json["btnFloor"],
  );

  Map<String, dynamic> toJson() => {
    "floor": floor == null ? null : floor,
    "btnFloor": btnFloor == null ? null : btnFloor,
  };
}