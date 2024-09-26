// To parse this JSON data, do
//
//     final sendOtpRequest = sendOtpRequestFromJson(jsonString);

import 'dart:convert';

SendOtpRequest sendOtpRequestFromJson(String str) => SendOtpRequest.fromJson(json.decode(str));

String sendOtpRequestToJson(SendOtpRequest data) => json.encode(data.toJson());

class SendOtpRequest {
  String email;
  String typeFor;

  SendOtpRequest({
    required this.email,
    required this.typeFor,
  });

  factory SendOtpRequest.fromJson(Map<String, dynamic> json) => SendOtpRequest(
    email: json["email"],
    typeFor: json["type_for"],
  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "type_for": typeFor,
  };
}
