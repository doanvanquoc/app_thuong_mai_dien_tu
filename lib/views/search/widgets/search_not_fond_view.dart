import 'package:app_thuong_mai_dien_tu/resources/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SearchNotFound extends StatefulWidget {
  const SearchNotFound({super.key, required this.message});
  final String message;
  @override
  State<SearchNotFound> createState() => _SearchNotFoundState();
}

class _SearchNotFoundState extends State<SearchNotFound> {
  TextEditingController searchTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 50),
                Lottie.asset(
                  'assets/animations/foundNotItem.json',
                  // fit:  BoxFit.cover,
                  width: 200,
                  height: 200,
                ),
                const SizedBox(height: 20),
                const Text(
                  "Không tìm thấy",
                  style: TextStyle(
                    fontSize: 30,
                    color: AppColor.secondaryColor,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  textAlign: TextAlign.center,
                  "Chúng tôi rất tiếc, từ khóa bạn tìm không thấy kết quả nào. Vui lòng kiểm tra lại hoặc tìm kiếm với từ khóa khác.",
                  style: TextStyle(
                    fontSize: 18,
                    color: AppColor.secondaryColor,
                  ),
                )
              ],
            ),
          ))
        ],
      ),
    );
  }
}
