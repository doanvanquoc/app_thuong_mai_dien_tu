class Review {
  int reviewID;
  String content;
  String reviewDate;
  int rating;
  int? userID;
  int? productID;

  Review({
    required this.reviewID,
    required this.content,
    required this.reviewDate,
    required this.rating,
    required this.userID,
    required this.productID,
  });

  Review.fromJson(Map<String, dynamic> json)
      : reviewID = json['reviewID'],
        content = json['content'],
        reviewDate = json['review_date'],
        rating = json['rating'],
        userID = json['userID'],
        productID = json['productID'];
}
