class PortfolioListingResponce {
  int? status;
  String? msg;
  List<PortfolioListingpayload>? payload;

  PortfolioListingResponce({this.status, this.msg, this.payload});

  PortfolioListingResponce.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    if (json['payload'] != null) {
      payload = <PortfolioListingpayload>[];
      json['payload'].forEach((v) {
        payload!.add(new PortfolioListingpayload.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.msg;
    if (this.payload != null) {
      data['payload'] = this.payload!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PortfolioListingpayload {
  String? selectedBroker;
  String? createdDt;
  String? username;
  String? profileImg;
  String? description;
  String? performaceMetrics1;
  String? performaceMetrics2;
  String? performaceMetrics3;
  String? performaceMetrics4;
  int? totalHoldingValues;
  double? totalHoldingReturns;
  bool? isCrown;
  int? portfolioId;
  int? userId;

  PortfolioListingpayload(
      {this.selectedBroker,
        this.createdDt,
        this.username,
        this.profileImg,
        this.description,
        this.performaceMetrics1,
        this.performaceMetrics2,
        this.performaceMetrics3,
        this.performaceMetrics4,
        this.totalHoldingValues,
        this.totalHoldingReturns,
        this.isCrown,
        this.portfolioId,
        this.userId});

  PortfolioListingpayload.fromJson(Map<String, dynamic> json) {
    selectedBroker = json['selected_broker'];
    createdDt = json['created_dt'];
    username = json['username'];
    profileImg = json['profile_img'];
    description = json['description'];
    performaceMetrics1 = json['performace_metrics_1'];
    performaceMetrics2 = json['performace_metrics_2'];
    performaceMetrics3 = json['performace_metrics_3'];
    performaceMetrics4 = json['performace_metrics_4'];
    totalHoldingValues = json['total_holding_values'];
    totalHoldingReturns = json['total_holding_returns'].toDouble();
    isCrown = json['is_crown'];
    portfolioId = json['portfolio_id'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['selected_broker'] = this.selectedBroker;
    data['created_dt'] = this.createdDt;
    data['username'] = this.username;
    data['profile_img'] = this.profileImg;
    data['description'] = this.description;
    data['performace_metrics_1'] = this.performaceMetrics1;
    data['performace_metrics_2'] = this.performaceMetrics2;
    data['performace_metrics_3'] = this.performaceMetrics3;
    data['performace_metrics_4'] = this.performaceMetrics4;
    data['total_holding_values'] = this.totalHoldingValues;
    data['total_holding_returns'] = this.totalHoldingReturns;
    data['is_crown'] = this.isCrown;
    data['portfolio_id'] = this.portfolioId;
    data['user_id'] = this.userId;
    return data;
  }
}