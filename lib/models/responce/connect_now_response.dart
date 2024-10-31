class connectNowResponse {
  int? status;
  String? msg;
  String? url;

  connectNowResponse({this.status, this.msg, this.url});

  connectNowResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.msg;
    data['url'] = this.url;
    return data;
  }
}
