import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

Future openDialog(BuildContext context) {
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
              height: 180,),
            const Text(
              'Tạo tài khoản thành công',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF212121),
                fontSize: 24,
                fontFamily: 'Sarabun',
                fontWeight: FontWeight.w700,
              ),
            ),
            const Text(
              'Tài khoản của bạn đã có thể sử dụng. Chúng tôi sẽ đưa bạn đến Trang chủ trong vài giây...',
              textAlign: TextAlign.center,
              style: TextStyle(
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
            // Uncomment the lines below if you want to add a button
            // CustomButton(
            //   onTap: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) => HomeScreen(),
            //       ),
            //     );
            //   },
            //   text: "Back to Home",
            // ),
          ],
        ),
      ),
    ),
  );
}
