import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

Future openDialog(BuildContext context, String title, String detail) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      content: Container(
        padding: const EdgeInsets.all(20),
        height: 500,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Lottie.asset(
              'assets/animations/headerIcon.json',
              width: 180,
              height: 180,
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFF212121),
                fontSize: 24,
                fontFamily: 'Sarabun',
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              detail,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFF212121),
                fontSize: 16,
                fontFamily: 'Sarabun',
                fontWeight: FontWeight.w400,
                letterSpacing: 0.20,
              ),
            ),
            Lottie.asset(
              'assets/animations/loading.json',
              width: 100,
              height: 100,
            ),
          ],
        ),
      ),
    ),
  );
}
