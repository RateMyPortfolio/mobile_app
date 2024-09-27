import 'dart:convert';

SignInResponce signInResponceFromJson(String str) => SignInResponce.fromJson(json.decode(str));

String signInResponceToJson(SignInResponce data) => json.encode(data.toJson());

class SignInResponce {
  int status;
  String msg;
  Payload payload;

  SignInResponce({
    required this.status,
    required this.msg,
    required this.payload,
  });

  factory SignInResponce.fromJson(Map<String, dynamic> json) => SignInResponce(
    status: json["status"],
    msg: json["msg"],
    payload: Payload.fromJson(json["payload"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "payload": payload.toJson(),
  };
}

class Payload {
  int? userId;
  String? name;
  String? mobile;
  String? email;
  String? firebaseToken;
  String? profileImage;
  ApiToken? apiToken;
  String? selectedBroker;
  String? clientId;
  String? pin;
  String? totp;
  String? createdDate;

  Payload(
      {this.userId,
        this.name,
        this.mobile,
        this.email,
        this.firebaseToken,
        this.profileImage,
        this.apiToken,
        this.selectedBroker,
        this.clientId,
        this.pin,
        this.totp,
        this.createdDate});

  Payload.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    name = json['name'];
    mobile = json['mobile'];
    email = json['email'];
    firebaseToken = json['firebase_token'];
    profileImage = json['profile_image'];
    apiToken = json['api_token'] != null
        ? new ApiToken.fromJson(json['api_token'])
        : null;
    selectedBroker = json['selected_broker'];
    clientId = json['client_id'];
    pin = json['pin'];
    totp = json['totp'];
    createdDate = json['created_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['mobile'] = this.mobile;
    data['email'] = this.email;
    data['firebase_token'] = this.firebaseToken;
    data['profile_image'] = this.profileImage;
    if (this.apiToken != null) {
      data['api_token'] = this.apiToken!.toJson();
    }
    data['selected_broker'] = this.selectedBroker;
    data['client_id'] = this.clientId;
    data['pin'] = this.pin;
    data['totp'] = this.totp;
    data['created_date'] = this.createdDate;
    return data;
  }
}

class ApiToken {
  String refresh;
  String access;

  ApiToken({
    required this.refresh,
    required this.access,
  });

  factory ApiToken.fromJson(Map<String, dynamic> json) => ApiToken(
    refresh: json["refresh"],
    access: json["access"],
  );

  Map<String, dynamic> toJson() => {
    "refresh": refresh,
    "access": access,
  };
}
