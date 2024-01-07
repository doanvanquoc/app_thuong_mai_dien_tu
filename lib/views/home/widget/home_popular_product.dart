import 'package:app_thuong_mai_dien_tu/resources/app_colors.dart';
import 'package:app_thuong_mai_dien_tu/resources/widgets/product_item.dart';
import 'package:app_thuong_mai_dien_tu/views/home/widget/home_list_category.dart';
import 'package:flutter/material.dart';

class HomePopularProduct extends StatelessWidget {
  const HomePopularProduct({super.key, required this.products});
  final List<String> products;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Phổ biến nhất',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            Text(
              'Tất cả',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColor.primaryColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        const HomeListCategory(),
        const SizedBox(height: 10),
        SizedBox(
          height: MediaQuery.of(context).size.height / 1.4,
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1 / 2.2,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) =>
                ProductItem(product: products[index]),
          ),
        ),
      ],
    );
  }
}
