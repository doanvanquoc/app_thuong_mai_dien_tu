import 'package:app_thuong_mai_dien_tu/resources/widgets/category_item.dart';
import 'package:flutter/material.dart';

class HomeListCategory extends StatefulWidget {
  const HomeListCategory({super.key, required this.categories});
  final List<String> categories;

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
          itemCount: widget.categories.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = index;
                });
              },
              child: CategoryItem(
                  category: widget.categories[index], isSelected: index == selectedIndex),
            );
          }),
    );
  }
}
