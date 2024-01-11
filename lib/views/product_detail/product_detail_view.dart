import 'package:app_thuong_mai_dien_tu/views/product_detail/widget/detail_add_cart.dart';
import 'package:app_thuong_mai_dien_tu/views/product_detail/widget/detail_info_product.dart';
import 'package:app_thuong_mai_dien_tu/views/product_detail/widget/detail_slide_show.dart';
import 'package:flutter/material.dart';

class ProductDetail extends StatefulWidget {
  const ProductDetail({super.key});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  List<String> img = [
    'assets/images/phone2.png',
    'assets/images/phone1.png',
    'assets/images/phone2.png',
    'assets/images/phone1.png',
    'assets/images/phone2.png',
    'assets/images/phone1.png',
    'assets/images/phone2.png',
  ];

  int count = 1;
  int total = 0;

  String name = "Iphone 15 Pro Max 8G/ 128GB - VN ";
  String content =
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna. Lorem ipsum dolor sit amet, consectetur adipiscing elit.";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SlideShowProduct(img: img),
          InfoProductDetail(
            description: content,
            rate: "4.9(4,749 đánh giá)",
            sold: '3,284 đã bán',
            name: name,
          ),
          const AddCartDetail(),
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
                  })),
        ],
      ),
    );
  }
}
