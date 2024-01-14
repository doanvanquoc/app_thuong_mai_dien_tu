class Review {
  int reviewID;
  String content;
  DateTime dateRate;
  double ratingLevel;
  int userID;
  int productID;

  Review({
    required this.reviewID,
    required this.content,
    required this.dateRate,
    required this.ratingLevel,
    required this.userID,
    required this.productID,
  });
}
