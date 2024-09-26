// To parse this JSON data, do
//
//     final confromPassowrdResponce = confromPassowrdResponceFromJson(jsonString);

import 'dart:convert';

ConfromPassowrdResponce confromPassowrdResponceFromJson(String str) => ConfromPassowrdResponce.fromJson(json.decode(str));

String confromPassowrdResponceToJson(ConfromPassowrdResponce data) => json.encode(data.toJson());

class ConfromPassowrdResponce {
  int status;
  String msg;

  ConfromPassowrdResponce({
    required this.status,
    required this.msg,
  });

  factory ConfromPassowrdResponce.fromJson(Map<String, dynamic> json) => ConfromPassowrdResponce(
    status: json["status"],
    msg: json["msg"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
  };
}
