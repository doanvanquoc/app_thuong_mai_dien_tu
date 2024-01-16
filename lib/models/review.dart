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

  static double avgRating(List<Review> lst) {
    if (lst.isEmpty) return 0;
    double total = 0;
    double avg = 0;
    for (var element in lst) {
      total += element.rating;
    }
    avg = total / lst.length;
    return avg;
  }
}
