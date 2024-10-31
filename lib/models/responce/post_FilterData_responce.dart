class FilterDataResponce {
  int? status;
  String? msg;
  filterPayload? payload;

  FilterDataResponce({this.status, this.msg, this.payload});

  FilterDataResponce.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    payload =
    json['payload'] != null ? new filterPayload.fromJson(json['payload']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.msg;
    if (this.payload != null) {
      data['payload'] = this.payload!.toJson();
    }
    return data;
  }
}

class filterPayload {
  List<int>? portfolioSize;
  List<int>? portfolioReturns;

  filterPayload({this.portfolioSize, this.portfolioReturns});

  filterPayload.fromJson(Map<String, dynamic> json) {
    portfolioSize = json['portfolio_size'].cast<int>();
    portfolioReturns = json['portfolio_returns'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['portfolio_size'] = this.portfolioSize;
    data['portfolio_returns'] = this.portfolioReturns;
    return data;
  }
}