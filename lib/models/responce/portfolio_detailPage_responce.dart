import 'package:rate_my_portfolio/models/responce/post_GetProfile_responce.dart';

class PortfolioDetailpageResponce {
  int? status;
  String? msg;
  DetailsPayload? payload;

  PortfolioDetailpageResponce({this.status, this.msg, this.payload});

  PortfolioDetailpageResponce.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    payload =
    json['payload'] != null ? new DetailsPayload.fromJson(json['payload']) : null;
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

class DetailsPayload {
  String? selectedBroker;
  String? createdDt;
  String? username;
  String? profileImg;
  String? description;
  String? performaceMetrics1;
  String? performaceMetrics2;
  String? performaceMetrics3;
  String? performaceMetrics4;
  double? totalHoldingValues;
  double? totalHoldingReturns;
  bool? isCrown;
  int? portfolioId;
  int? userId;
  PortfolioHolding? portfolioHolding;
  List<String>? performaceMetrics;
  List<CommunityReviews>? communityReviews;

  DetailsPayload(
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
        this.userId,
        this.portfolioHolding,
        this.performaceMetrics,
        this.communityReviews});

  DetailsPayload.fromJson(Map<String, dynamic> json) {
    selectedBroker = json['selected_broker'];
    createdDt = json['created_dt'];
    username = json['username'];
    profileImg = json['profile_img'];
    description = json['description'];
    performaceMetrics1 = json['performace_metrics_1'];
    performaceMetrics2 = json['performace_metrics_2'];
    performaceMetrics3 = json['performace_metrics_3'];
    performaceMetrics4 = json['performace_metrics_4'];
    totalHoldingValues = json['total_holding_values'].toDouble();
    totalHoldingReturns = json['total_holding_returns'].toDouble();
    isCrown = json['is_crown'];
    portfolioId = json['portfolio_id'];
    userId = json['user_id'];
    portfolioHolding = json['portfolio_holding'] != null
        ? new PortfolioHolding.fromJson(json['portfolio_holding'])
        : null;
    if (json['performace_metrics'] != null) {
      performaceMetrics = List<String>.from(json['performace_metrics']);
    }
    if (json['community_reviews'] != null) {
      communityReviews = <CommunityReviews>[];
      json['community_reviews'].forEach((v) {
        communityReviews!.add(new CommunityReviews.fromJson(v));
      });
    }
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
    if (this.portfolioHolding != null) {
      data['portfolio_holding'] = this.portfolioHolding!.toJson();
    }
    if (this.performaceMetrics != null) {
      data['performace_metrics'] = this.performaceMetrics;
    }
    if (this.communityReviews != null) {
      data['community_reviews'] =
          this.communityReviews!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PortfolioHolding {
  Data? data;
  bool? status;
  String? message;
  String? errorcode;

  PortfolioHolding({this.data, this.status, this.message, this.errorcode});

  PortfolioHolding.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    status = json['status'];
    message = json['message'];
    errorcode = json['errorcode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['status'] = this.status;
    data['message'] = this.message;
    data['errorcode'] = this.errorcode;
    return data;
  }
}

class Data {
  List<Holdings>? holdings;
  Totalholding? totalholding;

  Data({this.holdings, this.totalholding});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['holdings'] != null) {
      holdings = <Holdings>[];
      json['holdings'].forEach((v) {
        holdings!.add(new Holdings.fromJson(v));
      });
    }
    totalholding = json['totalholding'] != null
        ? new Totalholding.fromJson(json['totalholding'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.holdings != null) {
      data['holdings'] = this.holdings!.map((v) => v.toJson()).toList();
    }
    if (this.totalholding != null) {
      data['totalholding'] = this.totalholding!.toJson();
    }
    return data;
  }
}


class CommunityReviews {
  int? reviewId;
  int? userId;
  String? username;
  String? profileImg;
  String? review;
  String? created_dt;
  int? likes;
  bool? isLikedbyme;
  List<Replies>? replies;

  CommunityReviews(
      {this.reviewId,
        this.userId,
        this.username,
        this.profileImg,
        this.review,
        this.created_dt,
        this.likes,
        this.isLikedbyme,
        this.replies});

  CommunityReviews.fromJson(Map<String, dynamic> json) {
    reviewId = json['review_id'];
    userId = json['user_id'];
    username = json['username'];
    profileImg = json['profile_img'];
    review = json['review'];
    created_dt = json['created_dt'];
    likes = json['likes'];
    isLikedbyme = json['is_likedbyme'];
    if (json['replies'] != null) {
      replies = <Replies>[];
      json['replies'].forEach((v) {
        replies!.add(new Replies.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['review_id'] = this.reviewId;
    data['user_id'] = this.userId;
    data['username'] = this.username;
    data['profile_img'] = this.profileImg;
    data['review'] = this.review;
    data['created_dt'] = this.created_dt;
    data['likes'] = this.likes;
    data['is_likedbyme'] = this.isLikedbyme;
    if (this.replies != null) {
      data['replies'] = this.replies!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Replies {
  int? replyId;
  int? userId;
  String? username;
  String? profileImg;
  String? comment;
  int? likes;
  bool? isLikedbyme;
  String? created_dt;

  Replies(
      {this.replyId,
        this.userId,
        this.username,
        this.profileImg,
        this.comment,
        this.likes,
        this.isLikedbyme,
      this.created_dt});

  Replies.fromJson(Map<String, dynamic> json) {
    replyId = json['reply_id'];
    userId = json['user_id'];
    username = json['username'];
    profileImg = json['profile_img'];
    comment = json['comment'];
    likes = json['likes'];
    isLikedbyme = json['is_likedbyme'];
    created_dt = json['created_dt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['reply_id'] = this.replyId;
    data['user_id'] = this.userId;
    data['username'] = this.username;
    data['profile_img'] = this.profileImg;
    data['comment'] = this.comment;
    data['likes'] = this.likes;
    data['is_likedbyme'] = this.isLikedbyme;
    data['created_dt'] = this.created_dt;
    return data;
  }
}
