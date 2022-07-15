class GetGuestStatuss {
  GetGuestStatuss({
    this.guestStatusKey,
    this.statusCode,
    this.status,
  });

  String guestStatusKey;
  int statusCode;
  String status;

  factory GetGuestStatuss.fromJson(Map<String, dynamic> json) => GetGuestStatuss(
    guestStatusKey: json["guestStatusKey"] == null ? null : json["guestStatusKey"],
    statusCode: json["statusCode"] == null ? null : json["statusCode"],
    status: json["status"] == null ? null : json["status"],
  );

  Map<String, dynamic> toJson() => {
    "guestStatusKey": guestStatusKey == null ? null : guestStatusKey,
    "statusCode": statusCode == null ? null : statusCode,
    "status": status == null ? null : status,
  };
}