import 'package:app_thuong_mai_dien_tu/models/company.dart';
import 'package:app_thuong_mai_dien_tu/resources/widgets/category_item.dart';
import 'package:flutter/material.dart';

class HomeListCategory extends StatefulWidget {
  const HomeListCategory({super.key, required this.companies});
  final List<Company> companies;

  @override
  State<HomeListCategory> createState() => _HomeListCategoryState();
}

class _HomeListCategoryState extends State<HomeListCategory> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView.separated(
          separatorBuilder: (context, index) => const SizedBox(width: 10),
          scrollDirection: Axis.horizontal,
          itemCount: widget.companies.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = index;
                });
              },
              child: CategoryItem(
                  category: widget.companies[index].companyName,
                  isSelected: index == selectedIndex),
            );
          }),
    );
  }
}
