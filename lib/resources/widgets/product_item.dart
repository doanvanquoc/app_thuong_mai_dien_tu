import 'package:app_thuong_mai_dien_tu/models/product.dart';
import 'package:app_thuong_mai_dien_tu/models/review.dart';
import 'package:app_thuong_mai_dien_tu/presenters/review_presenter.dart';
import 'package:app_thuong_mai_dien_tu/resources/app_colors.dart';
import 'package:app_thuong_mai_dien_tu/views/home/widget/home_add_to_cart.dart';
import 'package:app_thuong_mai_dien_tu/views/product_detail/product_detail_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProductItem extends StatefulWidget {
  const ProductItem({super.key, required this.product, this.onTap});
  final Product product;
  final Function()? onTap;
  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  final reviewPresenter = ReviewPresenter.instance;
  List<Review> reviews = [];
  @override
  void initState() {
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
    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => ProductDetail(product: widget.product))),
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.only(right: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 150,
              alignment: Alignment.center,
              child: CachedNetworkImage(
                imageUrl: widget.product.images[0].imagePath,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              widget.product.productName,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColor.secondaryColor,
              ),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Row(
                children: [
                  const Icon(
                    Icons.star_border,
                    color: AppColor.primaryColor,
                  ),
                  Text(
                    widget.product.avgRating.toStringAsFixed(1),
                    style: const TextStyle(
                      color: AppColor.secondaryColor,
                    ),
                  ),
                  const SizedBox(width: 5),
                  const Text(
                    '|',
                    style: TextStyle(
                      color: AppColor.secondaryColor,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColor.primaryColor),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '${widget.product.totalSell} đã bán',
                      style: const TextStyle(color: AppColor.primaryColor),
                    ),
                  )
                ],
              ),
            ),
            Text(
              NumberFormat.currency(locale: 'vi_VN', symbol: 'VND')
                  .format(widget.product.price),
              style: const TextStyle(
                fontSize: 16,
                color: AppColor.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            HomeAddToCart(onTap: widget.onTap),
          ],
        ),
      ),
    );
  }
}
