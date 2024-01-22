import 'package:app_thuong_mai_dien_tu/models/review.dart';
import 'package:app_thuong_mai_dien_tu/presenters/review_presenter.dart';
import 'package:app_thuong_mai_dien_tu/resources/app_colors.dart';
import 'package:flutter/material.dart';

class ReviewContent extends StatefulWidget {
  const ReviewContent({super.key, required this.review});
  final Review review;
  @override
  State<ReviewContent> createState() => _ReviewContentState();
}

class _ReviewContentState extends State<ReviewContent> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12 + 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SizedBox(
                  height: 48,
                  width: 48,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(widget.review.userID.avatar),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  widget.review.userID.fullname,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColor.secondaryColor,
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(right: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(width: 2, color: AppColor.primaryColor),
                borderRadius: BorderRadius.circular(100),
              ),
              height: 32,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.star,
                    size: 20,
                    color: AppColor.primaryColor,
                  ),
                  Text(
                    '${widget.review.rating}',
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColor.primaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          widget.review.content,
          style: const TextStyle(fontSize: 12, color: AppColor.secondaryColor),
        ),
        const SizedBox(height: 12),
        Text(
          ReviewPresenter.converDate(widget.review.reviewDate),
          style: const TextStyle(color: AppColor.secondaryColor),
        )
      ],
    );
  }
}
