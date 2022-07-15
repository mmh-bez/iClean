// To parse this JSON data, do
//
//     final errorModel = errorModelFromJson(jsonString);

import 'dart:convert';

ErrorModel errorModelFromJson(String str) => ErrorModel.fromJson(json.decode(str));

class ErrorModel {
  ErrorModel({
     this.code,
     this.message,
     this.details,
     this.validationErrors,
  });

  int code;
  String message;
  dynamic details;
  dynamic validationErrors;

  factory ErrorModel.fromJson(Map<String, dynamic> json) => ErrorModel(
    code: json["code"] == null ? null : json["code"],
    message: json["message"] == null ? null : json["message"],
    details: json["details"],
    validationErrors: json["validationErrors"],
  );

}
