import 'package:app_thuong_mai_dien_tu/resources/app_colors.dart';
import 'package:app_thuong_mai_dien_tu/resources/widgets/search_box.dart';
import 'package:app_thuong_mai_dien_tu/views/home/home_esp_product.dart';
import 'package:app_thuong_mai_dien_tu/views/home/home_popular_product.dart';
import 'package:app_thuong_mai_dien_tu/views/home/home_slider.dart';
import 'package:app_thuong_mai_dien_tu/views/widget/home_appbar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
                HomePopularProduct(products: products)
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (value) {
          setState(() {
            currentIndex = value;
          });
        },
        type: BottomNavigationBarType.shifting,
        fixedColor: AppColor.primaryColor,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        unselectedLabelStyle: const TextStyle(color: Colors.grey),
        items: const [
          BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.houseMedical), label: 'Trang chủ'),
          BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.bagShopping), label: 'Giỏ hàng'),
          BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.cartShopping), label: 'Đơn hàng'),
          BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.wallet), label: 'Ví của tôi'),
          BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.user), label: 'Tài khoản'),
        ],
      ),
    );
  }
}
