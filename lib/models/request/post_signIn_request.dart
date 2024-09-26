// To parse this JSON data, do
//
//     final signInRequest = signInRequestFromJson(jsonString);

import 'dart:convert';

SignInRequest signInRequestFromJson(String str) => SignInRequest.fromJson(json.decode(str));

String signInRequestToJson(SignInRequest data) => json.encode(data.toJson());

class SignInRequest {
  String email;
  String password;
  String firebaseToken;

  SignInRequest({
    required this.email,
    required this.password,
    required this.firebaseToken,
  });

  factory SignInRequest.fromJson(Map<String, dynamic> json) => SignInRequest(
    email: json["email"],
    password: json["password"],
    firebaseToken: json["firebase_token"],
  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "password": password,
    "firebase_token": firebaseToken,
  };
}
