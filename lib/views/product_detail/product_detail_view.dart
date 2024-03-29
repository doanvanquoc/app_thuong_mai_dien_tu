import 'dart:developer';

import 'package:app_thuong_mai_dien_tu/models/product.dart';
import 'package:app_thuong_mai_dien_tu/models/review.dart';
import 'package:app_thuong_mai_dien_tu/presenters/review_presenter.dart';
import 'package:app_thuong_mai_dien_tu/views/product_detail/widget/detail_add_cart.dart';
import 'package:app_thuong_mai_dien_tu/views/product_detail/widget/detail_info_product.dart';
import 'package:app_thuong_mai_dien_tu/views/product_detail/widget/detail_slide_show.dart';
import 'package:flutter/material.dart';

class ProductDetail extends StatefulWidget {
  const ProductDetail({super.key, required this.product});
  final Product product;
  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  final reviewPresenter = ReviewPresenter.instance;
  List<Review> reviews = [];
  @override
  void initState() {
    log('init state');
    log('prod id: ${widget.product.productID}');
    reviewPresenter
        .getReviewByIdProduct(widget.product.productID)
        .then((value) {
      if (mounted) {
        setState(() {
          reviews = value;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SlideShowProduct(img: widget.product.images),
          InfoProductDetail(
            product: widget.product,
            review: reviews,
          ),
          AddCartDetail(product: widget.product),
          Positioned(
            top: 50,
            left: 26,
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                size: 30,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
