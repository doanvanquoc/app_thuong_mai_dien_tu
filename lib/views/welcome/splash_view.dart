import 'package:app_thuong_mai_dien_tu/data_sources/repo/user_api.dart';
import 'package:app_thuong_mai_dien_tu/models/user.dart';
import 'package:app_thuong_mai_dien_tu/nav_bar.dart';
import 'package:app_thuong_mai_dien_tu/views/login/login_view.dart';
import 'package:app_thuong_mai_dien_tu/views/welcome/welcome_view.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final UserAPI _userApi = UserAPI.instance;

  Future<String?> getAuthToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  Future<bool?> getLogOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('is_logged_out');
  }

  @override
  void initState() {
    super.initState();
    checkTokenValidity();
  }

  Future<void> checkTokenValidity() async {
    String? storedToken = await getAuthToken();
    bool? isLogout = await getLogOut();

    if (isLogout == true) {
      Future.delayed(
        const Duration(seconds: 2),
        () {
          // ignore: use_build_context_synchronously
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const Login()),
          );
        },
      );
    } else if (storedToken != null && storedToken.isNotEmpty) {
      try {
        final result = await _userApi.verifyToken(storedToken);

        if (result.containsKey('code') && result['code'] == 1) {
          User user = User.fromJson(result['data']);
          final pref = await SharedPreferences.getInstance();
          pref.setInt('curUser', user.userID);
          // ignore: use_build_context_synchronously
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (_) => MyNavBar(user: user, index: 0),
            ),
            (route) => false,
          );
        } else {
          // ignore: use_build_context_synchronously
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const Login()),
          );
        }
      } catch (e) {
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Login()),
        );
      }
    } else {
      Future.delayed(
        const Duration(seconds: 2),
        () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (_) => const Welcome(),
            ),
            (route) => false,
          );
        },
      );
    }
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
          Image.asset('assets/images/logo.png', width: 350, height: 350),
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
