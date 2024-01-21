import 'dart:developer';

import 'package:app_thuong_mai_dien_tu/models/company.dart';
import 'package:app_thuong_mai_dien_tu/models/product.dart';
import 'package:app_thuong_mai_dien_tu/models/user.dart';
import 'package:app_thuong_mai_dien_tu/nav_bar.dart';
import 'package:app_thuong_mai_dien_tu/presenters/cart_presenter.dart';
import 'package:app_thuong_mai_dien_tu/presenters/home_presenter.dart';
import 'package:app_thuong_mai_dien_tu/presenters/product_presenter.dart';
import 'package:app_thuong_mai_dien_tu/resources/app_colors.dart';
import 'package:app_thuong_mai_dien_tu/resources/widgets/category_item.dart';
import 'package:app_thuong_mai_dien_tu/resources/widgets/product_item.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class HomeListCategory extends StatefulWidget {
  HomeListCategory(
      {super.key,
      required this.companies,
      required this.products,
      required this.user});
  final List<Company> companies;
  List<Product> products;

  final User user;

  @override
  State<HomeListCategory> createState() => _HomeListCategoryState();
}

class _HomeListCategoryState extends State<HomeListCategory> {
  int selectedIndex = 0;
  final homePresenter = HomePresenter.instance;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 50,
          child: ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(width: 10),
              scrollDirection: Axis.horizontal,
              itemCount: widget.companies.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () async {
                    List<Product> products = index != 0
                        ? await ProductPresenter.instance
                            .getBestSellingProductByCompanyID(
                                10, widget.companies[index].companyID)
                        : await ProductPresenter.instance
                            .getBestSellingProduct(10);
                    setState(() {
                      selectedIndex = index;
                      widget.products = products;
                    });
                  },
                  child: CategoryItem(
                      category: widget.companies[index].companyName,
                      isSelected: index == selectedIndex),
                );
              }),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: MediaQuery.of(context).size.height / 1.4,
          child: GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1 / 2,
              mainAxisSpacing: 5,
            ),
            itemCount: widget.products.length,
            itemBuilder: (context, index) => ProductItem(
              product: widget.products[index],
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
                    userID: widget.user.userID,
                    productID: widget.products[index].productID,
                    quantity: 1);
                // ignore: use_build_context_synchronously
                Navigator.pop(context);
                // ignore: use_build_context_synchronously
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (_) => MyNavBar(user: widget.user, index: 1)));
              },
            ),
          ),
        ),
      ],
    );
  }
}
