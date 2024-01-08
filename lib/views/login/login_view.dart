import 'package:app_thuong_mai_dien_tu/resources/widgets/my_button.dart';
import 'package:app_thuong_mai_dien_tu/views/login/widgets/loading.dart';
import 'package:app_thuong_mai_dien_tu/views/login/widgets/log_check.dart';
import 'package:app_thuong_mai_dien_tu/views/login/widgets/log_logo.dart';
import 'package:app_thuong_mai_dien_tu/views/login/widgets/log_richText.dart';
import 'package:app_thuong_mai_dien_tu/views/login/widgets/log_textfield.dart';
import 'package:app_thuong_mai_dien_tu/views/register/register_view.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: const Icon(Icons.arrow_back_sharp, size: 30),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 30),
              const LoginLogo(),
              const Text(
                'Đăng nhập tài khoản',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
              ),
              const SizedBox(height: 40),
              const LoginTextFile(
                name: 'Email',
                iconLeft: Icon(Icons.email),
                iconRight: null,
                lock: false,
              ),
              const LoginTextFile(
                name: 'Mật khẩu',
                iconLeft: Icon(Icons.lock),
                iconRight: Icon(Icons.remove_red_eye_outlined),
                lock: true,
              ),
              const CheckLogin(),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: MyButton(
                  onTap: () {
                    openDialog(
                      context,
                      'Đăng nhập thành công',
                      'Tài khoản của bạn đã có thể sử dụng. Chúng tôi sẽ đưa bạn đến Trang chủ trong vài giây...',
                    );
                  },
                  content: 'Đăng Nhập'
                ),
              ),
              const SizedBox(height: 50),
              RichTextLog(
                question: 'Bạn chưa có tài khoản?',
                name: 'Đăng Ký',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Register()),
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
