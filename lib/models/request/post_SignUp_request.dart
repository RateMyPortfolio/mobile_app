// To parse this JSON data, do
//
//     final signUpRequest = signUpRequestFromJson(jsonString);

import 'dart:convert';

SignUpRequest signUpRequestFromJson(String str) => SignUpRequest.fromJson(json.decode(str));

String signUpRequestToJson(SignUpRequest data) => json.encode(data.toJson());

class SignUpRequest {
  String username;
  String password;
  String email;
  String mobile;

  SignUpRequest({
    required this.username,
    required this.password,
    required this.email,
    required this.mobile,
  });

  factory SignUpRequest.fromJson(Map<String, dynamic> json) => SignUpRequest(
    username: json["username"],
    password: json["password"],
    email: json["email"],
    mobile: json["mobile"],
  );

  Map<String, dynamic> toJson() => {
    "username": username,
    "password": password,
    "email": email,
    "mobile": mobile,
  };
}
