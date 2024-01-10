import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  const MyButton({
    super.key,
    required this.onTap,
    required this.content,
    this.backgroundColor = const Color(0xFF01B763),
    this.textColor = Colors.white,
  });

  final Function() onTap;
  final String content;
  final Color backgroundColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    // return GestureDetector(
    //   onTap: onTap,
    //   child: Container(
    //     width: double.infinity,
    //     height: 58,
    //     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
    //     decoration: BoxDecoration(
    //       color: const Color(0xff109C5B),
    //       borderRadius: BorderRadius.circular(30),
    //       boxShadow: const [
    //         BoxShadow(
    //           color: Color(0x3F01B763),
    //           blurRadius: 24,
    //           offset: Offset(4, 8),
    //           spreadRadius: 0,
    //         ),
    //       ],
    //     ),
    //     alignment: Alignment.center,
    //     child: Text(
    //       content,
    //       style:
    //           const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    //     ),
    //   ),
    // );
    return Container(
      height: 58,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        boxShadow: const [
          BoxShadow(
            color: Color(0x3F01B763),
            blurRadius: 24,
            offset: Offset(4, 8),
            spreadRadius: 0,
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
          padding: EdgeInsets.zero,
          elevation: 6,
        ),
        child: Container(
          alignment: Alignment.center,
          height: 58,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
          child: Text(
            content,
            style: TextStyle(
              color: textColor,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
