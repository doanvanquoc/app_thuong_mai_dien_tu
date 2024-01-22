// ignore: library_prefixes
import 'package:app_thuong_mai_dien_tu/models/image.dart' as MyImage;
import 'package:app_thuong_mai_dien_tu/resources/app_colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class SlideShowProduct extends StatefulWidget {
  const SlideShowProduct({super.key, required this.img});
  final List<MyImage.Image> img;
  @override
  State<SlideShowProduct> createState() => _SlideShowProductState();
}

class _SlideShowProductState extends State<SlideShowProduct> {
  int activeIndex = 0;

  Widget buildImage(String urlImage, int index) => SizedBox(
          child: CachedNetworkImage(
        imageUrl: urlImage,
        fit: BoxFit.cover,
      ));
  Widget buildIndicator() => AnimatedSmoothIndicator(
        effect: const ExpandingDotsEffect(
            activeDotColor: AppColor.primaryColor,
            dotHeight: 10,
            dotWidth: 10,
            dotColor: Colors.grey),
        activeIndex: activeIndex,
        count: widget.img.length,
      );

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      child: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 2.2,
            child: CarouselSlider.builder(
              itemCount: widget.img.length,
              itemBuilder: (_, index, realIndex) {
                return buildImage(widget.img[index].imagePath, index);
              },
              options: CarouselOptions(
                viewportFraction: 1,
                height: double.infinity,
                onPageChanged: ((index, reason) {
                  if (mounted) {
                    setState(() {
                      activeIndex = index;
                    });
                  }
                }),
              ),
            ),
          ),
          const SizedBox(height: 10),
          buildIndicator(),
        ],
      ),
    );
  }
}
