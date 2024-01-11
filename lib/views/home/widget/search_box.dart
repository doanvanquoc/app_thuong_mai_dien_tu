import 'package:app_thuong_mai_dien_tu/resources/app_colors.dart';
import 'package:app_thuong_mai_dien_tu/views/search/search_view.dart';
import 'package:flutter/material.dart';

class SearchBox extends StatelessWidget {
  const SearchBox({super.key});
  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: AppColor.primaryColor,
      decoration: InputDecoration(
        hintText: 'Tìm kiếm...',
        hintStyle: const TextStyle(color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
        fillColor: Colors.grey.shade200,
        filled: true,
        prefixIcon: IconButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => const SearchPage()));
          },
          icon: const Icon(
            Icons.search,
            color: Colors.grey,
          ),
        ),
        suffixIcon: IconButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => const SearchPage()));
          },
          icon: const Icon(
            Icons.filter_list_sharp,
            color: AppColor.primaryColor,
          ),
        ),
      ),
    );
  }
}
