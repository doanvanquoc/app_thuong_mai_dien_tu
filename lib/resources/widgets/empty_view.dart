import 'package:flutter/material.dart';

class EmptyView extends StatelessWidget {
  const EmptyView({super.key, required this.text1, required this.text2});
  final String text1;
  final String text2;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const SizedBox(height: 110),
          Image.asset('assets/images/empty.png'),
          const SizedBox(height: 40),
          Text(
            text1,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xFF212121),
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            text2,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xFF212121),
              fontSize: 18,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
