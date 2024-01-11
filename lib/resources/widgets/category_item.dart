import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem(
      {super.key, required this.category, required this.isSelected});
  final String category;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    return Chip(
      labelStyle: TextStyle(color: isSelected ? Colors.white : const Color(0xff01B763), fontSize: 16),
      label: Text(category),
      backgroundColor:
          isSelected ? const Color(0xff01B763) : Colors.transparent,
      labelPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 1),
      shape: RoundedRectangleBorder(
        side: const BorderSide(width: 1, color: Color(0xff01B763)),
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}
