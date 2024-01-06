import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class HomeSlider extends StatelessWidget {
  const HomeSlider({super.key, required this.banners});
  final List<String> banners;
  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      options: CarouselOptions(
          height: 150,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 2),
          enlargeCenterPage: true),
      itemCount: banners.length,
      itemBuilder: (context, index, realIndex) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(
            banners[index],
            fit: BoxFit.cover,
          ),
        );
      },
    );
  }
}
