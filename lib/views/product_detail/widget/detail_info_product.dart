import 'package:app_thuong_mai_dien_tu/models/product.dart';
import 'package:app_thuong_mai_dien_tu/models/review.dart';
import 'package:app_thuong_mai_dien_tu/presenters/review_presenter.dart';
import 'package:app_thuong_mai_dien_tu/resources/app_colors.dart';
import 'package:app_thuong_mai_dien_tu/views/product_detail/widget/detail_specification.dart';
import 'package:app_thuong_mai_dien_tu/views/review/review_view.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class InfoProductDetail extends StatefulWidget {
  InfoProductDetail({
    super.key,
    required this.product,
    required this.review,
  });
  final Product product;
  List<Review> review;

  @override
  State<InfoProductDetail> createState() => _InfoProductDetailState();
}

class _InfoProductDetailState extends State<InfoProductDetail> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 2.4,
      bottom: 80,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.product.productName,
                      style: const TextStyle(
                          fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Container(
                    width: 80,
                    height: 25,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: const Color.fromARGB(255, 212, 249, 232),
                    ),
                    child: const Center(
                      child: Text(
                        '1 đã bán',
                        style: TextStyle(
                          fontSize: 10,
                          color: AppColor.primaryColor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Icon(Icons.star, size: 20),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => ReviewPage(
                                    reviews: widget.review,
                                    avgRating: ReviewPresenter.avgRating)));
                      });
                    },
                    child: Text(
                      //toStringAsFixed(1) --> làm tròn
                      '${ReviewPresenter.avgRating(widget.review).toStringAsFixed(1)} (${widget.review.length} đánh giá)',
                      style: const TextStyle(fontSize: 14),
                    ),
                  )
                ],
              ),
              const Divider(),
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                child: Text(
                  "Mô tả",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Text(
                widget.product.description,
                style: const TextStyle(
                  fontSize: 16,
                ),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 12),
              DetailSpecifications(product: widget.product)
            ],
          ),
        ),
      ),
    );
  }
}
