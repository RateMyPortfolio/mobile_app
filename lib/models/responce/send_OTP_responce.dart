// To parse this JSON data, do
//
//     final sendOtpResponce = sendOtpResponceFromJson(jsonString);

import 'dart:convert';

SendOtpResponce sendOtpResponceFromJson(String str) => SendOtpResponce.fromJson(json.decode(str));

String sendOtpResponceToJson(SendOtpResponce data) => json.encode(data.toJson());

class SendOtpResponce {
  int status;
  String msg;
  String otp;

  SendOtpResponce({
    required this.status,
    required this.msg,
    required this.otp,
  });

  factory SendOtpResponce.fromJson(Map<String, dynamic> json) => SendOtpResponce(
    status: json["status"],
    msg: json["msg"],
    otp: json["otp"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "otp": otp,
  };
}
