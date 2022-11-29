// To parse this JSON data, do
//
//     final baseResponse = baseResponseFromMap(jsonString);

import 'dart:convert';

BaseResponse baseResponseFromJson(String str) => BaseResponse.fromMap(json.decode(str));

String baseResponseToMap(BaseResponse data) => json.encode(data.toMap());

class BaseResponse {
  BaseResponse({
    this.result,
    this.targetUrl,
    this.success,
    this.error,
    this.unAuthorizedRequest,
    this.abp,
  });

  List<Result> result;
  dynamic targetUrl;
  bool success;
  dynamic error;
  bool unAuthorizedRequest;
  bool abp;

  factory BaseResponse.fromMap(Map<String, dynamic> json) => BaseResponse(
   // result: List<Result>.from(json["result"].map((x) => Result.fromMap(x))),
    targetUrl: json["targetUrl"],
    success: json["success"],
    error: json["error"],
    unAuthorizedRequest: json["unAuthorizedRequest"],
    abp: json["__abp"],
  );

  Map<String, dynamic> toMap() => {
    "result": List<dynamic>.from(result.map((x) => x.toMap())),
    "targetUrl": targetUrl,
    "success": success,
    "error": error,
    "unAuthorizedRequest": unAuthorizedRequest,
    "__abp": abp,
  };
}

class Result {
  Result({
    this.to,
    this.message,
  });

  List<String> to;
  String message;

  factory Result.fromMap(Map<String, dynamic> json) => Result(
    to: List<String>.from(json["to"].map((x) => x)),
    message: json["message"],
  );

  Map<String, dynamic> toMap() => {
    "to": List<dynamic>.from(to.map((x) => x)),
    "message": message,
  };
}
