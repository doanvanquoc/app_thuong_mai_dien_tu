import 'package:app_thuong_mai_dien_tu/models/company.dart';
import 'package:app_thuong_mai_dien_tu/models/product.dart';
import 'package:app_thuong_mai_dien_tu/models/user.dart';
import 'package:app_thuong_mai_dien_tu/resources/app_colors.dart';
import 'package:app_thuong_mai_dien_tu/views/home/widget/home_all_popular_product.dart';
import 'package:app_thuong_mai_dien_tu/views/home/widget/home_list_category.dart';
import 'package:flutter/material.dart';

class HomePopularProduct extends StatelessWidget {
  const HomePopularProduct(
      {super.key,
      required this.products,
      required this.companies,
      required this.user, required this.controller});
  final List<Product> products;
  final List<Company> companies;
  final User user;
  final ScrollController controller;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Phổ biến nhất',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: AppColor.secondaryColor,
              ),
            ),
            GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      HomeAllPopularProduct(companies: companies, user: user),
                ),
              ),
              child: const Text(
                'Tất cả',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColor.primaryColor,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        HomeListCategory(
          // controller: controller,
          companies: companies,
          products: products,
          user: user,
        ),
        // const SizedBox(height: 10),
        // SizedBox(
        //   height: MediaQuery.of(context).size.height / 1.4,
        //   child: GridView.builder(
        //     shrinkWrap: true,
        //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        //       crossAxisCount: 2,
        //       childAspectRatio: 1 / 2,
        //     ),
        //     itemCount: products.length,
        //     itemBuilder: (context, index) =>
        //         ProductItem(product: products[index]),
        //   ),
        // ),
      ],
    );
  }
}
