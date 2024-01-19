import 'package:app_thuong_mai_dien_tu/models/company.dart';
import 'package:app_thuong_mai_dien_tu/models/product.dart';
import 'package:app_thuong_mai_dien_tu/presenters/home_presenter.dart';
import 'package:app_thuong_mai_dien_tu/resources/widgets/category_item.dart';
import 'package:app_thuong_mai_dien_tu/resources/widgets/product_item.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class HomeListCategory extends StatefulWidget {
  HomeListCategory(
      {super.key, required this.companies, required this.products});
  final List<Company> companies;
  List<Product> products;

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
                    List<Product> products =
                        await homePresenter.getProductByCompanyID(
                            widget.companies[index].companyID);
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
            itemBuilder: (context, index) =>
                ProductItem(product: widget.products[index]),
          ),
        ),
      ],
    );
  }
}
