class LoginSignupGoogleFaceBook_Request {
  String? username;
  String? password;
  String? email;
  String? mobile;
  String? loginType;
  String? firebaseToken;

  LoginSignupGoogleFaceBook_Request(
      {this.username,
        this.password,
        this.email,
        this.mobile,
        this.loginType,
        this.firebaseToken});

  LoginSignupGoogleFaceBook_Request.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['password'];
    email = json['email'];
    mobile = json['mobile'];
    loginType = json['login_type'];
    firebaseToken = json['firebase_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['password'] = this.password;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['login_type'] = this.loginType;
    data['firebase_token'] = this.firebaseToken;
    return data;
  }
}
