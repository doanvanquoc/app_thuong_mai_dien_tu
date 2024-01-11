import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class SlideShowProduct extends StatefulWidget {
  const SlideShowProduct({super.key, required this.img});
  final List img;
  @override
  State<SlideShowProduct> createState() => _SlideShowProductState();
}

class _SlideShowProductState extends State<SlideShowProduct> {
  int activeIndex = 0;

  Widget buildImage(String urlImage, int index) => SizedBox(
          child: Image.asset(
        urlImage,
        fit: BoxFit.cover,
      ));
  Widget buildIndicator() => AnimatedSmoothIndicator(
        effect: const ExpandingDotsEffect(
            activeDotColor: Color(0xFF01B763),
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
                return buildImage(widget.img[index], index);
              },
              options: CarouselOptions(
                viewportFraction: 1,
                height: double.infinity,
                onPageChanged: ((index, reason) {
                  setState(() {
                    activeIndex = index;
                  });
                }),
              ),
            ),
          ),
          buildIndicator(),
        ],
      ),
    );
  }
}
