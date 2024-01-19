import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
// ignore: library_prefixes
import 'package:app_thuong_mai_dien_tu/models/banner.dart' as MyBanner;

class HomeSlider extends StatefulWidget {
  const HomeSlider({super.key, required this.banners});
  final List<MyBanner.Banner> banners;

  @override
  State<HomeSlider> createState() => _HomeSliderState();
}

class _HomeSliderState extends State<HomeSlider> {
  int activedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider.builder(
          options: CarouselOptions(
            height: 150,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 2),
            enlargeCenterPage: true,
            onPageChanged: (index, reason) {
              setState(() {
                activedIndex = index;
              });
            },
          ),
          itemCount: widget.banners.length,
          itemBuilder: (context, index, realIndex) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                widget.banners[index].image,
                fit: BoxFit.cover,
              ),
            );
          },
        ),
        const SizedBox(height: 10),
        buildIndicator()
      ],
    );
  }

  Widget buildIndicator() => AnimatedSmoothIndicator(
        effect: const ExpandingDotsEffect(
          activeDotColor: Color(0xFF01B763),
          dotHeight: 10,
          dotWidth: 10,
          dotColor: Colors.grey,
        ),
        activeIndex: activedIndex,
        count: widget.banners.length,
      );
}
