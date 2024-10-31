class Aboutmyportfoliorequest {
  int? userId;
  String? aboutPortfolio;

  Aboutmyportfoliorequest({this.userId, this.aboutPortfolio});

  Aboutmyportfoliorequest.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    aboutPortfolio = json['about_portfolio'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['about_portfolio'] = this.aboutPortfolio;
    return data;
  }
}