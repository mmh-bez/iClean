// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

import 'package:i_clean/models/error_model.dart';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

class LoginModel {
  LoginModel({
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
  ErrorModel error;
  bool unAuthorizedRequest;
  bool abp;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    result: json["result"] == null ? null : Result.fromJson(json["result"]),
    targetUrl: json["targetUrl"],
    success: json["success"] == null ? null : json["success"],
    error: json["error"]== null ? null : ErrorModel.fromJson(json["error"]),
    unAuthorizedRequest: json["unAuthorizedRequest"] == null ? null : json["unAuthorizedRequest"],
    abp: json["__abp"] == null ? null : json["__abp"],
  );

}

class Result {
  Result({
    this.accessToken,
    this.encryptedAccessToken,
    this.expireInSeconds,
    this.shouldResetPassword,
    this.passwordResetCode,
    this.userId,
    this.requiresTwoFactorVerification,
    this.twoFactorAuthProviders,
    this.twoFactorRememberClientToken,
    this.returnUrl,
    this.refreshToken,
    this.refreshTokenExpireInSeconds,
    this.staffKey,
    this.name,
    this.isAdmin
  });

  String accessToken;
  String encryptedAccessToken;
  int expireInSeconds;
  bool shouldResetPassword;
  dynamic passwordResetCode;
  int userId;
  bool requiresTwoFactorVerification;
  dynamic twoFactorAuthProviders;
  dynamic twoFactorRememberClientToken;
  String returnUrl;
  String refreshToken;
  int refreshTokenExpireInSeconds;
  String staffKey;
  String name;
  bool isAdmin;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    accessToken: json["accessToken"] == null ? null : json["accessToken"],
    encryptedAccessToken: json["encryptedAccessToken"] == null ? null : json["encryptedAccessToken"],
    expireInSeconds: json["expireInSeconds"] == null ? null : json["expireInSeconds"],
    shouldResetPassword: json["shouldResetPassword"] == null ? null : json["shouldResetPassword"],
    passwordResetCode: json["passwordResetCode"],
    userId: json["userId"] == null ? null : json["userId"],
    requiresTwoFactorVerification: json["requiresTwoFactorVerification"] == null ? null : json["requiresTwoFactorVerification"],
    twoFactorAuthProviders: json["twoFactorAuthProviders"],
    twoFactorRememberClientToken: json["twoFactorRememberClientToken"],
    returnUrl: json["returnUrl"] == null ? null : json["returnUrl"],
    refreshToken: json["refreshToken"] == null ? null : json["refreshToken"],
    refreshTokenExpireInSeconds: json["refreshTokenExpireInSeconds"] == null ? null : json["refreshTokenExpireInSeconds"],
    staffKey: json["staffKey"] == null ? null : json["staffKey"],
    name: json['userName'],
    isAdmin: json['isAdmin']
  );

}
