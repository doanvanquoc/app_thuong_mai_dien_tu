import 'package:app_thuong_mai_dien_tu/models/user.dart';

class Review {
  int reviewID;
  String content;
  String reviewDate;
  int rating;
  User userID;
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
        userID = User.fromJson(json['user']!),
        productID = json['productID'];
}
