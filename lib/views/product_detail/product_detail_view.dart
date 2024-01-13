import 'package:app_thuong_mai_dien_tu/models/product.dart';
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
  int count = 1;
  int total = 0;

  List<String> img = [
    'assets/images/phone2.png',
    'assets/images/phone1.png',
    'assets/images/phone2.png',
    'assets/images/phone1.png',
    'assets/images/phone2.png',
    'assets/images/phone1.png',
    'assets/images/phone2.png',
  ];
  Product product = Product(
    image: 'assets/images/image.png',
    name: 'Samsung Galaxy S23 Ultra 8G/128GB',
    description:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna. Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
    price: '31.900.000đ',
    quantity: 1,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SlideShowProduct(img: img),
          InfoProductDetail(
            product: product,
            rate: "4.9(4,749 đánh giá)",
            sold: '3,284 đã bán',
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
