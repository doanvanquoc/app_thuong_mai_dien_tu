import 'package:app_thuong_mai_dien_tu/models/review.dart';
import 'package:app_thuong_mai_dien_tu/views/review/widgets/review_content.dart';
import 'package:app_thuong_mai_dien_tu/views/review/widgets/review_option.dart';
import 'package:flutter/material.dart';

class ReviewPage extends StatefulWidget {
  const ReviewPage({super.key, required this.reviews});
  final List<Review> reviews;
  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  String checkRate = "";

//Mặc định 5 sao
  List<String> ratelst = [
    'Tất cả',
    '5',
    '4',
    '3',
    '2',
    '1',
  ];

  List<Review> reviewByRating = [];
  void checkOption(value) {
    //lọc theo sao
    setState(() {
      reviewByRating.clear();
      checkRate = value;
      for (var element in widget.reviews) {
        if (element.rating.toString() == value) {
          reviewByRating.add(element);
        }
      }
      if (value == 'Tất cả') reviewByRating.addAll(widget.reviews);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    reviewByRating.addAll(widget.reviews);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        title: Text(
          "${Review.avgRating(widget.reviews).toStringAsFixed(1)} (${widget.reviews.length} đánh giá)",
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
                    itemCount: reviewByRating.length,
                    itemBuilder: (_, index) {
                      return ReviewContent(review: reviewByRating[index]);
                    }))
          ],
        ),
      ),
    );
  }
}
