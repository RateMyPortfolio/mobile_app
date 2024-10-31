class LikeDeslikeComment_request {
  int? reviewId;
  int? replyId;
  int? userId;
  bool? isLike;

  LikeDeslikeComment_request(
      {this.reviewId, this.replyId, this.userId, this.isLike});

  LikeDeslikeComment_request.fromJson(Map<String, dynamic> json) {
    reviewId = json['review_id'];
    replyId = json['reply_id'];
    userId = json['user_id'];
    isLike = json['is_like'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['review_id'] = this.reviewId;
    data['reply_id'] = this.replyId;
    data['user_id'] = this.userId;
    data['is_like'] = this.isLike;
    return data;
  }
}
