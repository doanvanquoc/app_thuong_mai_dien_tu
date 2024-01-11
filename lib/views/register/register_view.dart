import 'package:app_thuong_mai_dien_tu/resources/widgets/my_button.dart';
import 'package:app_thuong_mai_dien_tu/resources/widgets/my_textfile.dart';
import 'package:app_thuong_mai_dien_tu/resources/widgets/my_textfilepass.dart';
import 'package:app_thuong_mai_dien_tu/views/login/login_view.dart';
import 'package:app_thuong_mai_dien_tu/views/login/widgets/loading.dart';
import 'package:app_thuong_mai_dien_tu/views/login/widgets/log_check.dart';
import 'package:app_thuong_mai_dien_tu/views/login/widgets/log_logo.dart';
import 'package:app_thuong_mai_dien_tu/views/login/widgets/log_richText.dart';
import 'package:app_thuong_mai_dien_tu/views/register/accountInfomation_view.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController userName = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController rePassword=TextEditingController();
  String noti='';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                iconLeft: const Icon(Icons.password_outlined),
                controller: password,
              ),
              MyTextPass(
                name: 'Xác Nhận Mật khẩu',
                iconLeft: const Icon(Icons.password_outlined),
                controller: rePassword,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 15),
                child: Text(noti,style: const TextStyle(fontSize: 16,color: Colors.red),textAlign: TextAlign.center,),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: MyButton(
                  onTap: () {
                    //Định dạng email
                    RegExp emailRegExp = RegExp(
                      r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$',
                    );

                    //Định dạng mật khẩu
                    RegExp passwordRegExp = RegExp(
                      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*()_+{}|:"<>?~`]).{8,}$',
                    );

                    if (userName.text.isEmpty || password.text.isEmpty || rePassword.text.isEmpty) {
                      noti = 'Cần nhập đầy đủ thông tin!';
                    } else if (!emailRegExp.hasMatch(userName.text)) {
                      noti = 'Email không hợp lệ!';
                    } else if (!passwordRegExp.hasMatch(password.text)) {
                      noti = 'Mật khẩu ít nhất 8 ký tự, có ít nhất 1 ký tự đặc biệt, 1 chữ hoa và 1 chữ thường!';
                    } else if (password.text != rePassword.text) {
                      noti = 'Mật khẩu và xác nhận mật khẩu không khớp!';
                    } else {
                      noti = '';
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const AccountInformation()),
                      );
                    }

                    setState(() {});

                    // Future.delayed(const Duration(seconds: 2), () {
                      
                    // });
                    
                  },
                  content: 'Đăng Ký'
                ),
              ),
              const SizedBox(height: 40),
              RichTextLog(
                question: 'Bạn đã có tài khoản?',
                name: 'Đăng Nhập',
                onTap: (){
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const Login()),
                    (route) => route is Login,
                  );
                }
              ),
            ],
          ),
        ),
      ),
    );
  }
}