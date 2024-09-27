import 'dart:convert';

GetStartedBrokerresponce getStartedBrokerresponceFromJson(String str) => GetStartedBrokerresponce.fromJson(json.decode(str));

String getStartedBrokerresponceToJson(GetStartedBrokerresponce data) => json.encode(data.toJson());

class GetStartedBrokerresponce {
  int status;
  String msg;

  GetStartedBrokerresponce({
    required this.status,
    required this.msg,
  });

  factory GetStartedBrokerresponce.fromJson(Map<String, dynamic> json) => GetStartedBrokerresponce(
    status: json["status"],
    msg: json["msg"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
  };
}
