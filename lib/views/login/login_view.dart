import 'package:app_thuong_mai_dien_tu/resources/widgets/my_button.dart';
import 'package:app_thuong_mai_dien_tu/resources/widgets/my_textfile.dart';
import 'package:app_thuong_mai_dien_tu/resources/widgets/my_textfilepass.dart';
import 'package:app_thuong_mai_dien_tu/views/login/widgets/loading.dart';
import 'package:app_thuong_mai_dien_tu/views/login/widgets/log_logo.dart';
import 'package:app_thuong_mai_dien_tu/views/login/widgets/log_richText.dart';
import 'package:app_thuong_mai_dien_tu/views/register/register_view.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController userName = TextEditingController();
  final TextEditingController password = TextEditingController();
  String notifications='';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
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
                iconLeft: const Icon(Icons.password_outlined),
                controller: password,
              ),
              Text(notifications,style: const TextStyle(color: Colors.red,fontSize: 16),),
              // const CheckLogin(),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: MyButton(
                  onTap: () {
                    if(userName.text.isEmpty||password.text.isEmpty){
                      notifications='Cần nhập đầy đủ thông tin!';
                    }
                    else{
                      notifications='';
                      if(userName.text!='username@gmail.com'||password.text!='123456'){
                        notifications='Tên đăng nhập hoặc mật khẩu sai!';
                      }
                      else{
                        notifications='';
                        openDialog(
                          context,
                          'Đăng nhập thành công',
                          'Chúng tôi sẽ đưa bạn đến Trang chủ trong vài giây...',
                        );
                      }
                    }
                    setState(() {});
                  },
                  content: 'Đăng Nhập'
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


