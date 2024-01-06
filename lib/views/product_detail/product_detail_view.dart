import 'package:app_thuong_mai_dien_tu/views/product_detail/widget/add_cart.dart';
import 'package:app_thuong_mai_dien_tu/views/product_detail/widget/info_product.dart';
import 'package:app_thuong_mai_dien_tu/views/product_detail/widget/slide_show.dart';
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

  void IncrQ() {
    setState(() {
      count++;
    });
  }

  void DecrQ() {
    setState(() {
      if (count <= 1) {
        count = 1;
      } else {
        count -= 1;
      }
    });
  }

  String name = "Iphone 15 Pro Max 8G/ 128GB - VN ";
  String content =
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna. Lorem ipsum dolor sit amet, consectetur adipiscing elit.";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SlideShowProduct(img: img),
          InfoProductDetail(
            description: content,
            name: name,
            count: count,
            IncrQuanlity: IncrQ,
            DecrQuanlity: DecrQ,
          ),
          AddCartDetail(total: 38.0 * count),
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
