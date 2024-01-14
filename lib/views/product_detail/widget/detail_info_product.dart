import 'package:app_thuong_mai_dien_tu/models/product.dart';
import 'package:app_thuong_mai_dien_tu/resources/app_colors.dart';
import 'package:app_thuong_mai_dien_tu/views/review/review_view.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class InfoProductDetail extends StatefulWidget {
  const InfoProductDetail({
    super.key,
    required this.product,
    required this.rate,
    required this.sold,
  });
  final Product product;
  final String rate;
  final String sold;

  @override
  State<InfoProductDetail> createState() => _InfoProductDetailState();
}

class _InfoProductDetailState extends State<InfoProductDetail> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 2.4,
      bottom: 62,
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
                      widget.product.name,
                      style: const TextStyle(
                          fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.favorite, size: 28),
                  )
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
                    child: Center(
                      child: Text(
                        widget.sold,
                        style: const TextStyle(
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const ReviewPage()));
                    },
                    child: Text(
                      widget.rate,
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
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Text(
                widget.product.description,
                style: const TextStyle(
                  fontSize: 14,
                ),
                textAlign: TextAlign.justify,
              ),
              // Text(
              //   widget.description,
              //   style: const TextStyle(
              //     fontSize: 14,
              //   ),
              //   textAlign: TextAlign.justify,
              // ),
              // Text(
              //   widget.description,
              //   style: const TextStyle(
              //     fontSize: 14,
              //   ),
              //   textAlign: TextAlign.justify,
              // ),
              const SizedBox(height: 12),
              const Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
