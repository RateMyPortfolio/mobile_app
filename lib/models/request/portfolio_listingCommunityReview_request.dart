class portfolioCommunityReviewRequest {
  int? userId;
  int? portfolioId;
  int? replyCommentId;
  String? reviewText;

  portfolioCommunityReviewRequest(
      {this.userId, this.portfolioId, this.replyCommentId, this.reviewText});

  portfolioCommunityReviewRequest.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    portfolioId = json['portfolio_id'];
    replyCommentId = json['reply_comment_id'];
    reviewText = json['review_text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['portfolio_id'] = this.portfolioId;
    data['reply_comment_id'] = this.replyCommentId;
    data['review_text'] = this.reviewText;
    return data;
  }
}
