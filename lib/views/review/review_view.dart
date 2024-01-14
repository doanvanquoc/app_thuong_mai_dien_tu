import 'package:app_thuong_mai_dien_tu/models/review.dart';
import 'package:app_thuong_mai_dien_tu/views/review/widgets/review_content.dart';
import 'package:app_thuong_mai_dien_tu/views/review/widgets/review_option.dart';
import 'package:flutter/material.dart';

class ReviewPage extends StatefulWidget {
  const ReviewPage({super.key});

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  String checkRate = "";
  List<String> ratelst = [
    'Tất cả',
    '5',
    '4',
    '3',
    '2',
    '1',
  ];

  List<Review> reviews = [
    Review(
      reviewID: 1,
      content:
          'Sắn sale được cái Iphone 15 giá chỉ có 10k mà thôi, Shop 5 sao!',
      dateRate: DateTime.now(),
      ratingLevel: 5,
      userID: 1,
      productID: 1,
    ),
    Review(
      reviewID: 2,
      content:
          'Sắn sale được cái Iphone 15 giá chỉ có 10k mà thôi, Shop 5 sao!',
      dateRate: DateTime.now(),
      ratingLevel: 5,
      userID: 1,
      productID: 1,
    ),
    Review(
      reviewID: 3,
      content:
          'Sắn sale được cái Iphone 15 giá chỉ có 10k mà thôi, Shop 5 sao!',
      dateRate: DateTime.now(),
      ratingLevel: 5,
      userID: 1,
      productID: 1,
    ),
  ];

  void checkOption(value) {
    setState(() {
      checkRate = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        title: Text(
          "4.9 (${reviews.length})",
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            ReviewOption(lst: ratelst, onTap: checkOption),
            Expanded(
                child: ListView.builder(
                    itemCount: reviews.length,
                    itemBuilder: (_, index) {
                      return ReviewContent(review: reviews[index]);
                    }))
          ],
        ),
      ),
    );
  }
}
