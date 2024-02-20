// ignore: library_prefixes
import 'dart:developer';

import 'package:app_thuong_mai_dien_tu/models/banner.dart' as MyBanner;
import 'package:app_thuong_mai_dien_tu/models/company.dart';
import 'package:app_thuong_mai_dien_tu/models/product.dart';
import 'package:app_thuong_mai_dien_tu/models/user.dart';
import 'package:app_thuong_mai_dien_tu/presenters/banner_presenter.dart';
import 'package:app_thuong_mai_dien_tu/presenters/company_presenter.dart';
import 'package:app_thuong_mai_dien_tu/presenters/home_presenter.dart';
import 'package:app_thuong_mai_dien_tu/presenters/product_presenter.dart';
import 'package:app_thuong_mai_dien_tu/views/home/widget/home_appbar.dart';
import 'package:app_thuong_mai_dien_tu/views/home/widget/home_new_product.dart';
import 'package:app_thuong_mai_dien_tu/views/home/widget/home_popular_product.dart';
import 'package:app_thuong_mai_dien_tu/views/home/widget/home_slider.dart';
import 'package:app_thuong_mai_dien_tu/views/home/widget/search_box.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.user});
  final User user;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = ScrollController();
  final allCompany = Company(companyID: 0, companyName: 'Tất cả');
  List<Product> latestProduct = [];
  List<Product> popularProduct = [];
  List<Company> companies = [];
  List<MyBanner.Banner> banners = [
    MyBanner.Banner(
        bannerID: 1,
        image:
            'https://res.cloudinary.com/dxe8ykmrn/image/upload/v1705678734/banners/syhintfcmcuwavqqx3la.png'),
    MyBanner.Banner(
        bannerID: 2,
        image:
            'https://res.cloudinary.com/dxe8ykmrn/image/upload/v1705678737/banners/pbzvhznki50whobpjm5g.png')
  ];
  @override
  void initState() {
    HomePresenter.instance.getLatestProduct(5).then((value) {
      if (mounted) {
        setState(() {
          latestProduct = value;
        });
      }
    });
    ProductPresenter.instance.getBestSellingProduct(10).then((value) {
      if (mounted) {
        setState(() {
          popularProduct = value;
        });
      }
    });

    CompanyPresenter.instance.getAllCompany().then((value) {
      if (mounted) {
        setState(() {
          companies = value;
          companies.insert(0, allCompany);
        });
      }
    });

    BannerPresenter.instance.getBanners().then((value) {
      if (mounted) {
        setState(() {
          banners = value;
        });
      }
    });

    super.initState();
  }

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          controller: controller,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HomeAppbar(
                  user: widget.user,
                ),
                const SizedBox(height: 24),
                const SearchBox(),
                const SizedBox(height: 24),
                HomeSlider(banners: banners),
                const SizedBox(height: 19),
                HomeNewProduct(
                  user: widget.user,
                  products: latestProduct,
                  companies: companies,
                ),
                const SizedBox(height: 19),
                HomePopularProduct(
                  controller: controller,
                  user: widget.user,
                  products: popularProduct,
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
