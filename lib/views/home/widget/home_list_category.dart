import 'package:app_thuong_mai_dien_tu/resources/widgets/category_item.dart';
import 'package:flutter/material.dart';

class HomeListCategory extends StatelessWidget {
  const HomeListCategory({super.key});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView.separated(
          separatorBuilder: (context, index) => const SizedBox(width: 10),
          scrollDirection: Axis.horizontal,
          itemCount: 5,
          itemBuilder: (context, index) {
            bool isSelected = index == 0;
            return CategoryItem(
                category: 'Category $index', isSelected: isSelected);
          }),
    );
  }
}
