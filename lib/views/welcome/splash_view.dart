import 'package:app_thuong_mai_dien_tu/views/welcome/welcome_view.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Thực hiện các công việc tiền khởi động ở đây nếu cần
    // Ví dụ: preloading data, setup, etc.

    // Sau một khoảng thời gian nhất định, chuyển đến màn hình chính
    Future.delayed(
      const Duration(seconds: 3),
      () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Welcome()),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const SizedBox(
            height: 100,
          ),
          Image.asset('assets/images/logo.png', width: 250, height: 250),
          const SizedBox(
            height: 50,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Lottie.asset(
              'assets/animations/loading.json',
              width: 100,
              height: 100,
            ),
          ),
        ],
      ),
    );
  }
}
