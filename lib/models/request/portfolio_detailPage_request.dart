class PortfolioDetailpageRequest {
  int? portfolioId;
  int? userId;

  PortfolioDetailpageRequest({this.portfolioId,this.userId});

  PortfolioDetailpageRequest.fromJson(Map<String, dynamic> json) {
    portfolioId = json['portfolio_id'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['portfolio_id'] = this.portfolioId;
    data['user_id'] = this.userId;
    return data;
  }
}