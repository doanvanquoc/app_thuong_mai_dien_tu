import 'package:app_thuong_mai_dien_tu/data_sources/repo/user_api.dart';
import 'package:app_thuong_mai_dien_tu/nav_bar.dart';
import 'package:app_thuong_mai_dien_tu/resources/widgets/my_button.dart';
import 'package:app_thuong_mai_dien_tu/resources/widgets/my_textfile.dart';
import 'package:app_thuong_mai_dien_tu/resources/widgets/my_textfilepass.dart';
import 'package:app_thuong_mai_dien_tu/views/login/widgets/loading.dart';
import 'package:app_thuong_mai_dien_tu/views/login/widgets/log_logo.dart';
import 'package:app_thuong_mai_dien_tu/views/login/widgets/log_richText.dart';
import 'package:app_thuong_mai_dien_tu/views/register/register_view.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController userName = TextEditingController();
  final TextEditingController password = TextEditingController();
  String notifications = '';

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
                style: const TextStyle(color: Colors.red, fontSize: 16),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: MyButton(
                  onTap: () async {
                    if (userName.text.isEmpty || password.text.isEmpty) {
                      setState(() {
                        notifications = 'Cần nhập đầy đủ thông tin!';
                      });
                    } else {
                      setState(() {
                        notifications = '';
                      });

                      final result = await UserAPI.instance.loginUser(
                        userName.text,
                        password.text,
                      );

                      print(result);

                      if (result.containsKey('error')) {
                        setState(() {
                          notifications = result['error'];
                        });
                      } else if (result.containsKey('message') &&
                          result['message'] == 'OK') {
                        // Check for a success message or other indication of a successful login
                        openDialog(
                          context,
                          'Đăng nhập thành công',
                          'Chúng tôi sẽ đưa bạn đến Trang chủ trong vài giây...',
                        );
                        Future.delayed(
                          const Duration(seconds: 2),
                          () {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const MyNavBar(),
                              ),
                              (route) => false,
                            );
                          },
                        );
                      } else {
                        setState(() {
                          notifications = 'Sai email hoặc mật khẩu';
                        });
                      }
                    }
                  },
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
