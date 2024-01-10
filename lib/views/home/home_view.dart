import 'package:app_thuong_mai_dien_tu/views/home/widget/home_appbar.dart';
import 'package:app_thuong_mai_dien_tu/views/home/widget/home_esp_product.dart';
import 'package:app_thuong_mai_dien_tu/views/home/widget/home_popular_product.dart';
import 'package:app_thuong_mai_dien_tu/views/home/widget/home_slider.dart';
import 'package:app_thuong_mai_dien_tu/views/home/widget/search_box.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  List<String> banners = [
    'https://cdn2.cellphones.com.vn/insecure/rs:fill:690:300/q:80/plain/https://dashboard.cellphones.com.vn/storage/sliding-home-iphone15.jpg',
    'https://cdn2.cellphones.com.vn/insecure/rs:fill:690:300/q:80/plain/https://dashboard.cellphones.com.vn/storage/asus%20zenbook%2014.jpg',
    'https://cdn2.cellphones.com.vn/insecure/rs:fill:690:300/q:80/plain/https://dashboard.cellphones.com.vn/storage/realme-sli-t1-tragop-1.png',
    'https://cdn2.cellphones.com.vn/insecure/rs:fill:690:300/q:80/plain/https://dashboard.cellphones.com.vn/storage/infinix-sliding-th122.jpg'
  ];

  List<String> products = [
    'https://cdn.hoanghamobile.com/i/preview/Uploads/2022/09/08/2222.png',
    'https://cdn.hoanghamobile.com/i/productlist/dsp/Uploads/2023/03/08/14-yellow.png',
    'https://cdn.hoanghamobile.com/i/preview/Uploads/2022/09/08/2222.png',
    'https://cdn.hoanghamobile.com/i/productlist/dsp/Uploads/2023/03/08/14-yellow.png',
    'https://cdn.hoanghamobile.com/i/preview/Uploads/2022/09/08/2222.png',
    'https://cdn.hoanghamobile.com/i/productlist/dsp/Uploads/2023/03/08/14-yellow.png'
  ];

  List<String> categories = [
    'Apple',
    'Samsung',
    'Xiaomi',
    'Huawei',
    'Nokia'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const HomeAppbar(),
                const SizedBox(height: 24),
                const SearchBox(),
                const SizedBox(height: 24),
                HomeSlider(banners: banners),
                const SizedBox(height: 19),
                HomeEspProduct(products: products),
                const SizedBox(height: 19),
                HomePopularProduct(products: products, categories: categories,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
