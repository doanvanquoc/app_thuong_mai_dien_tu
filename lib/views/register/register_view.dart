import 'package:app_thuong_mai_dien_tu/resources/widgets/my_button.dart';
import 'package:app_thuong_mai_dien_tu/views/login/widgets/log_check.dart';
import 'package:app_thuong_mai_dien_tu/views/login/widgets/log_logo.dart';
import 'package:app_thuong_mai_dien_tu/views/login/widgets/log_richText.dart';
import 'package:app_thuong_mai_dien_tu/views/login/widgets/log_textfield.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.arrow_back_sharp, size: 30),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 15),
              const LoginLogo(),
              const Text(
                'Tạo tài khoản',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
              ),
              const SizedBox(height: 30),
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
              const LoginTextFile(
                name: 'Xác Nhận Mật khẩu',
                iconLeft: Icon(Icons.lock),
                iconRight: Icon(Icons.remove_red_eye_outlined),
                lock: true,
              ),
              const CheckLogin(),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: MyButton(onTap: () {}, content: 'Đăng Ký'),
              ),
              const SizedBox(height: 40),
              RichTextLog(question: 'Bạn đã có tài khoản?',name: 'Đăng Nhập',),
            ],
          ),
        ),
      ),
    );
  }
}