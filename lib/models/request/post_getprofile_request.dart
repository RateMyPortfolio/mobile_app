import 'dart:convert';

GetProfileRequest getProfileRequestFromJson(String str) => GetProfileRequest.fromJson(json.decode(str));

String getProfileRequestToJson(GetProfileRequest data) => json.encode(data.toJson());

class GetProfileRequest {
  String userId;

  GetProfileRequest({
    required this.userId,
  });

  factory GetProfileRequest.fromJson(Map<String, dynamic> json) => GetProfileRequest(
    userId: json["user_id"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
  };
}
