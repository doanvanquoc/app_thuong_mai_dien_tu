import 'dart:developer';

import 'package:app_thuong_mai_dien_tu/models/company.dart';
import 'package:app_thuong_mai_dien_tu/models/product.dart';
import 'package:app_thuong_mai_dien_tu/models/user.dart';
import 'package:app_thuong_mai_dien_tu/nav_bar.dart';
import 'package:app_thuong_mai_dien_tu/presenters/cart_presenter.dart';
import 'package:app_thuong_mai_dien_tu/resources/app_colors.dart';
import 'package:app_thuong_mai_dien_tu/resources/widgets/product_item.dart';
import 'package:app_thuong_mai_dien_tu/views/product/product_special_view.dart';
import 'package:flutter/material.dart';

class HomeNewProduct extends StatelessWidget {
  const HomeNewProduct(
      {super.key,
      required this.products,
      required this.companies,
      required this.user});
  final List<Product> products;
  final List<Company> companies;
  final User user;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Sản phẩm mới nhất',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => NewProduct(
                      nameTab: 'Sản phẩm mới nhất', lstCategory: companies),
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
        SizedBox(
          height: 320,
          child: ListView.separated(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: products.length,
            itemBuilder: (context, index) {
              return ProductItem(
                product: products[index],
                onTap: () async {
                  log('on tap add to cart');
                  showDialog(
                      context: context,
                      builder: (context) => const AlertDialog(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            surfaceTintColor: Colors.transparent,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 30),
                            content: SizedBox(
                              width: 50, // Đặt chiều rộng mong muốn
                              height: 50, // Đặt chiều cao mong muốn
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CircularProgressIndicator(
                                    color: AppColor.primaryColor,
                                  ),
                                  // Các phần tử khác nếu cần
                                ],
                              ),
                            ),
                          ));
                  await CartPresenter.instance.addToCart(
                      userID: user.userID,
                      productID: products[index].productID,
                      quantity: 1);
                  // ignore: use_build_context_synchronously
                  Navigator.pop(context);
                  // ignore: use_build_context_synchronously
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (_) => MyNavBar(user: user, index: 1)));
                },
              );
            },
            separatorBuilder: (context, index) => Container(
              margin: const EdgeInsets.only(right: 15),
              width: 0.3,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
