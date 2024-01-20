import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:app_thuong_mai_dien_tu/data_sources/repo/user_api.dart';
import 'package:app_thuong_mai_dien_tu/models/user.dart';
import 'package:app_thuong_mai_dien_tu/nav_bar.dart';
import 'package:app_thuong_mai_dien_tu/resources/widgets/my_button.dart';
import 'package:app_thuong_mai_dien_tu/resources/widgets/my_textfile.dart';
import 'package:app_thuong_mai_dien_tu/resources/widgets/my_textfilepass.dart';
import 'package:app_thuong_mai_dien_tu/views/login/widgets/loading.dart';
import 'package:app_thuong_mai_dien_tu/views/login/widgets/log_logo.dart';
import 'package:app_thuong_mai_dien_tu/views/login/widgets/log_richText.dart';
import 'package:app_thuong_mai_dien_tu/views/register/register_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();

  Future<Map<String, dynamic>> loginUser(
      String userName, String password) async {
    return await UserAPI.instance.loginUser(userName, password);
  }
}

class _LoginState extends State<Login> {
  final TextEditingController userName = TextEditingController();
  final TextEditingController password = TextEditingController();
  String notifications = '';

  Future<void> loginUser() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(
                color: Colors.green,
              ),
              SizedBox(height: 10),
              Text('Đang kiểm tra thông tin đăng nhập...'),
            ],
          ),
        );
      },
    );
    try {
      if (userName.text.isEmpty || password.text.isEmpty) {
        setState(() {
          notifications = 'Cần nhập đầy đủ thông tin!';
        });
      } else {
        setState(() {
          notifications = '';
        });

        final result = await widget.loginUser(userName.text, password.text);

        if (result.containsKey('error')) {
          setState(() {
            notifications = result['error'];
          });
        } else if (result.containsKey('message') && result['message'] == 'OK') {
          final token = result['token'];

          //Lưu token vào local
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('auth_token', token);
          prefs.setBool('is_logged_out', false);

          Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
          final user = User.fromJson(decodedToken['user']);

          // ignore: use_build_context_synchronously
          Navigator.maybePop(context);
          Future.delayed(Duration.zero, () {
            // ignore: use_build_context_synchronously
            openDialog(
              context,
              'Đăng nhập thành công',
              'Chúng tôi sẽ đưa bạn đến Trang chủ trong vài giây...',
            );
          });
          Future.delayed(
            const Duration(seconds: 2),
            () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (_) => MyNavBar(user: user,index: 0),
                ),
                (route) => false,
              );
            },
          );
        } else {
          setState(() {
            notifications = 'Tài khoản hoặc mật khẩu không chính xác';
          });
        }
      }
    } finally {
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              const LoginLogo(),
              const Text(
                'Đăng nhập tài khoản',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
              const SizedBox(height: 40),
              MyTextFile(
                name: 'Email',
                iconLeft: const Icon(Icons.email_outlined),
                iconRight: null,
                controller: userName,
              ),
              MyTextPass(
                name: 'Mật khẩu',
                iconLeft: const Icon(Icons.lock_outlined),
                controller: password,
              ),
              Text(
                notifications,
                style: const TextStyle(color: Colors.red, fontSize: 18),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: MyButton(
                  onTap: loginUser,
                  content: 'Đăng Nhập',
                ),
              ),
              const SizedBox(height: 50),
              RichTextLog(
                question: 'Bạn chưa có tài khoản?',
                name: 'Đăng Ký',
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const Register()),
                    (route) => route is Register,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
