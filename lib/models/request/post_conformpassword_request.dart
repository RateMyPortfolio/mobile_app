import 'dart:convert';

ConfromPassowrdRequest confromPassowrdRequestFromJson(String str) => ConfromPassowrdRequest.fromJson(json.decode(str));

String confromPassowrdRequestToJson(ConfromPassowrdRequest data) => json.encode(data.toJson());

class ConfromPassowrdRequest {
  String email;
  String password;

  ConfromPassowrdRequest({
    required this.email,
    required this.password,
  });

  factory ConfromPassowrdRequest.fromJson(Map<String, dynamic> json) => ConfromPassowrdRequest(
    email: json["email"],
    password: json["password"],
  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "password": password,
  };
}
