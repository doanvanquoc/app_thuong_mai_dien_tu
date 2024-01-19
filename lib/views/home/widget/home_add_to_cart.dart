import 'package:app_thuong_mai_dien_tu/resources/app_colors.dart';
import 'package:flutter/material.dart';

class HomeAddToCart extends StatelessWidget {
  const HomeAddToCart({super.key});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: AppColor.primaryColor,
          border: Border.all(color: AppColor.primaryColor),
          borderRadius: BorderRadius.circular(5),
        ),
        child: const Text(
          'Mua ngay',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
