import 'dart:convert';

GetStartedBrokerRequest getStartedBrokerRequestFromJson(String str) => GetStartedBrokerRequest.fromJson(json.decode(str));

String getStartedBrokerRequestToJson(GetStartedBrokerRequest data) => json.encode(data.toJson());

class GetStartedBrokerRequest {
  String userId;
  String brokerName;
  String clientId;
  String pin;
  String totp;

  GetStartedBrokerRequest({
    required this.userId,
    required this.brokerName,
    required this.clientId,
    required this.pin,
    required this.totp,
  });

  factory GetStartedBrokerRequest.fromJson(Map<String, dynamic> json) => GetStartedBrokerRequest(
    userId: json["user_id"],
    brokerName: json["broker_name"],
    clientId: json["client_id"],
    pin: json["pin"],
    totp: json["totp"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "broker_name": brokerName,
    "client_id": clientId,
    "pin": pin,
    "totp": totp,
  };
}
