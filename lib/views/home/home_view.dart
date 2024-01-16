import 'package:app_thuong_mai_dien_tu/data_sources/repo/company_api.dart';
import 'package:app_thuong_mai_dien_tu/data_sources/repo/product_api.dart';
import 'package:app_thuong_mai_dien_tu/models/company.dart';
import 'package:app_thuong_mai_dien_tu/models/product.dart';
import 'package:app_thuong_mai_dien_tu/views/home/widget/home_appbar.dart';
import 'package:app_thuong_mai_dien_tu/views/home/widget/home_new_product.dart';
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
  final productAPI = ProductAPI.instance;
  final companyAPI = CompanyAPI.instance;
  List<Product> products = [];
  List<Company> companies = [];
  @override
  void initState() {
    productAPI.getLatestProduct().then((value) {
      setState(() {
        products = value;
      });
    });

    companyAPI.getAllCompany().then((value) {
      setState(() {
        companies = value;
      });
    });
    super.initState();
  }

  int currentIndex = 0;
  List<String> banners = [
    'https://cdn2.cellphones.com.vn/insecure/rs:fill:690:300/q:80/plain/https://dashboard.cellphones.com.vn/storage/sliding-home-iphone15.jpg',
    'https://cdn2.cellphones.com.vn/insecure/rs:fill:690:300/q:80/plain/https://dashboard.cellphones.com.vn/storage/infinix-sliding-th122.jpg',
    'https://cdn2.cellphones.com.vn/insecure/rs:fill:690:300/q:80/plain/https://dashboard.cellphones.com.vn/storage/sliding-home-iphone15.jpg',
    'https://cdn2.cellphones.com.vn/insecure/rs:fill:690:300/q:80/plain/https://dashboard.cellphones.com.vn/storage/infinix-sliding-th122.jpg'
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
                HomeNewProduct(
                  products: products,
                  companies: companies,
                ),
                const SizedBox(height: 19),
                HomePopularProduct(
                  products: products,
                  companies: companies,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
