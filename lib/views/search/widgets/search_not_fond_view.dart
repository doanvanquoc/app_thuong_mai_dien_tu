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
                  style: TextStyle(fontSize: 30),
                ),
                const SizedBox(height: 12),
                Text(
                  textAlign: TextAlign.center,
                  widget.message,
                  style: const TextStyle(fontSize: 18),
                )
              ],
            ),
          ))
        ],
      ),
    );
  }
}
