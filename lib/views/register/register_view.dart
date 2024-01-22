import 'dart:developer';

import 'package:app_thuong_mai_dien_tu/data_sources/repo/user_api.dart';
import 'package:app_thuong_mai_dien_tu/resources/widgets/my_button.dart';
import 'package:app_thuong_mai_dien_tu/resources/widgets/my_textfile.dart';
import 'package:app_thuong_mai_dien_tu/resources/widgets/my_textfilepass.dart';
import 'package:app_thuong_mai_dien_tu/views/login/login_view.dart';
import 'package:app_thuong_mai_dien_tu/views/login/widgets/log_logo.dart';
import 'package:app_thuong_mai_dien_tu/views/login/widgets/log_rich_text.dart';
import 'package:app_thuong_mai_dien_tu/views/register/account_infomation_view.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController userName = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController rePassword = TextEditingController();
  String noti = '';

  Future<void> registerUser() async {
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
              Text('Đang kiểm tra thông tin...'),
            ],
          ),
        );
      },
    );
    try {
      RegExp emailRegExp = RegExp(
        r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$',
      );

      RegExp passwordRegExp = RegExp(
        r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*()_+{}|:"<>?~`]).{8,}$',
      );

      if (userName.text.isEmpty ||
          password.text.isEmpty ||
          rePassword.text.isEmpty) {
        noti = 'Cần nhập đầy đủ thông tin!';
      } else if (!emailRegExp.hasMatch(userName.text)) {
        noti = 'Email không hợp lệ!';
      } else if (!passwordRegExp.hasMatch(password.text)) {
        noti =
            'Mật khẩu ít nhất 8 ký tự, có ít nhất 1 ký tự đặc biệt, 1 chữ hoa và 1 chữ thường!';
      } else if (password.text != rePassword.text) {
        noti = 'Mật khẩu và xác nhận mật khẩu không khớp!';
      } else {
        final UserAPI userApi = UserAPI.instance;

        try {
          final result = await userApi.checkEmail(userName.text);
          if (result.containsKey('error')) {
            noti = result['error'];
          } else if (result.containsKey('code') && result['code'] == 1) {
            noti = '';
            // ignore: use_build_context_synchronously
            Navigator.maybePop(context);
            Future.delayed(Duration.zero, () {
              // ignore: use_build_context_synchronously
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AccountInformation(
                    email: userName.text,
                    passWord: password.text,
                  ),
                ),
              );
            });
          } else {
            noti = 'Email đã tồn tại!';
          }
        } catch (e) {
          noti = 'Lỗi kết nối';
        }
      }
    } finally {
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    }
    if(mounted){
      setState(() {});
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
            children: [
              const SizedBox(height: 15),
              const LoginLogo(),
              const Text(
                'Tạo tài khoản',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
              ),
              const SizedBox(height: 30),
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
              MyTextPass(
                name: 'Xác Nhận Mật khẩu',
                iconLeft: const Icon(Icons.lock_outlined),
                controller: rePassword,
              ),
              if (noti != '')
                Text(
                  noti,
                  style: const TextStyle(fontSize: 18, color: Colors.red),
                  textAlign: TextAlign.center,
                ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: MyButton(
                  onTap: registerUser,
                  content: 'Đăng Ký',
                ),
              ),
              const SizedBox(height: 40),
              RichTextLog(
                question: 'Bạn đã có tài khoản?',
                name: 'Đăng Nhập',
                onTap: () {
                  log('đang đăng nhập');
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const Login()),
                    (route) => route is Login,
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
