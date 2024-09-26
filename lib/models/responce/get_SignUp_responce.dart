import 'dart:convert';

SignUpResponce signUpResponceFromJson(String str) => SignUpResponce.fromJson(json.decode(str));

String signUpResponceToJson(SignUpResponce data) => json.encode(data.toJson());

class SignUpResponce {
  int status;
  String msg;
  Payload payload;

  SignUpResponce({
    required this.status,
    required this.msg,
    required this.payload,
  });

  factory SignUpResponce.fromJson(Map<String, dynamic> json) => SignUpResponce(
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
  int userId;
  String name;
  String mobile;
  String email;
  String firebaseToken;
  String profileImage;
  ApiToken apiToken;
  DateTime createdDate;

  Payload({
    required this.userId,
    required this.name,
    required this.mobile,
    required this.email,
    required this.firebaseToken,
    required this.profileImage,
    required this.apiToken,
    required this.createdDate,
  });

  factory Payload.fromJson(Map<String, dynamic> json) => Payload(
    userId: json["user_id"],
    name: json["name"],
    mobile: json["mobile"],
    email: json["email"],
    firebaseToken: json["firebase_token"],
    profileImage: json["profile_image"],
    apiToken: ApiToken.fromJson(json["api_token"]),
    createdDate: DateTime.parse(json["created_date"]),
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "name": name,
    "mobile": mobile,
    "email": email,
    "firebase_token": firebaseToken,
    "profile_image": profileImage,
    "api_token": apiToken.toJson(),
    "created_date": createdDate.toIso8601String(),
  };
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
