import 'dart:developer';

import 'package:app_thuong_mai_dien_tu/models/company.dart';
import 'package:app_thuong_mai_dien_tu/models/product.dart';
import 'package:app_thuong_mai_dien_tu/models/user.dart';
import 'package:app_thuong_mai_dien_tu/nav_bar.dart';
import 'package:app_thuong_mai_dien_tu/presenters/cart_presenter.dart';
import 'package:app_thuong_mai_dien_tu/presenters/product_presenter.dart';
import 'package:app_thuong_mai_dien_tu/resources/app_colors.dart';
import 'package:app_thuong_mai_dien_tu/resources/widgets/category_item.dart';
import 'package:app_thuong_mai_dien_tu/resources/widgets/product_item.dart';
import 'package:flutter/material.dart';

class HomeAllPopularProduct extends StatefulWidget {
  const HomeAllPopularProduct(
      {super.key, required this.companies, required this.user});
  @override
  State<HomeAllPopularProduct> createState() => _HomeAllPopularProductState();
  final List<Company> companies;
  final User user;
}

class _HomeAllPopularProductState extends State<HomeAllPopularProduct> {
  List<Product> popularProducts = [];
  int selectedIndex = 0;

  @override
  void initState() {
    ProductPresenter.instance.getLatestProduct().then((value) {
      if (mounted) {
        setState(() {
          popularProducts = value;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Sản phẩm phổ biến nhất',
          style: TextStyle(
            color: AppColor.secondaryColor,
          ),
        ),
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                      log('index ne: $index');
                      List<Product> products = index == 0
                          ? await ProductPresenter.instance
                              .getBestSellingProduct()
                          : await ProductPresenter.instance
                              .getBestSellingProductByCompanyID(
                                  widget.companies[index].companyID);
                      if (mounted) {
                        setState(() {
                          selectedIndex = index;
                          popularProducts = products;
                        });
                      }
                    },
                    child: CategoryItem(
                        category: widget.companies[index].companyName,
                        isSelected: index == selectedIndex),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1 / 2,
                  mainAxisSpacing: 5,
                ),
                itemCount: popularProducts.length,
                itemBuilder: (context, index) => ProductItem(
                  product: popularProducts[index],
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
                        productID: popularProducts[index].productID,
                        quantity: 1);
                    // ignore: use_build_context_synchronously
                    Navigator.pop(context);
                    // ignore: use_build_context_synchronously
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => MyNavBar(user: widget.user, index: 1),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
