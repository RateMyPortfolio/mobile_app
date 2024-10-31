class PortfolioListingRequest {
  String? userId;
  String? portfolioSize;
  String? portfolioReturns;

  PortfolioListingRequest(
      {this.userId, this.portfolioSize, this.portfolioReturns});

  PortfolioListingRequest.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    portfolioSize = json['portfolio_size'];
    portfolioReturns = json['portfolio_returns'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['portfolio_size'] = this.portfolioSize;
    data['portfolio_returns'] = this.portfolioReturns;
    return data;
  }
}