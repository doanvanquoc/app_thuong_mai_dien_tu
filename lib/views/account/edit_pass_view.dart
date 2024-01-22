import 'dart:developer';

import 'package:app_thuong_mai_dien_tu/data_sources/repo/user_api.dart';
import 'package:app_thuong_mai_dien_tu/models/user.dart';
import 'package:app_thuong_mai_dien_tu/nav_bar.dart';
import 'package:app_thuong_mai_dien_tu/resources/widgets/my_button.dart';
import 'package:app_thuong_mai_dien_tu/resources/widgets/my_textfilepass.dart';
import 'package:app_thuong_mai_dien_tu/views/login/widgets/loading.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class EditPass extends StatefulWidget {
  EditPass({super.key, required this.user});
  User user;

  @override
  State<EditPass> createState() => _EditPassState();
}

class _EditPassState extends State<EditPass> {
  TextEditingController oldPassWord = TextEditingController();
  TextEditingController newPassWord = TextEditingController();
  TextEditingController confirmNewPassWord = TextEditingController();
  String notifications = '';

  // ignore: non_constant_identifier_names
  Future<void> editPassWord() async {
    RegExp passwordRegExp = RegExp(
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*()_+{}|:"<>?~`]).{8,}$',
    );
    if (oldPassWord.text.isEmpty ||
        newPassWord.text.isEmpty ||
        confirmNewPassWord.text.isEmpty) {
      if(mounted){
        setState(() {
        notifications = 'Cần nhập đầy đủ thông tin!';
      });
      }
    } else if (!passwordRegExp.hasMatch(newPassWord.text)) {
      notifications =
          'Mật khẩu ít nhất 8 ký tự, có ít nhất 1 ký tự đặc biệt, 1 chữ hoa và 1 chữ thường!';
    } else if (newPassWord.text != confirmNewPassWord.text) {
      notifications = 'Mật khẩu mới và xác nhận mật khẩu mới không trùng!';
    }
    else if(oldPassWord.text==newPassWord.text){
      notifications = 'Mật khẩu cũ và xác nhận mật khẩu mới trùng nhau!';
    } else {
      notifications = '';
      final UserAPI userApi = UserAPI.instance;
      final result = await userApi.changePass(widget.user.userID, oldPassWord.text, newPassWord.text);

      if (result.containsKey('error')) {
        if(mounted){
          setState(() {
          notifications = result['error'];
        });
        }
        log(result.toString());
      } else if (result.containsKey('code') && result['code'] == 1) {
        // ignore: use_build_context_synchronously
        openDialog(
          context,
          'Đổi mật khẩu thành công',
          'Chúng tôi sẽ đưa bạn đến trang tài khoản trong vài giây...',
        );
        Future.delayed(
          const Duration(seconds: 2),
          () {
           Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (_) => MyNavBar(user: widget.user,index: 3,),
              ),
              (route) => false,
            );
          },
        );
      } else {
        notifications = 'Mật khẩu cũ không chính xác!';
      }
    }
    if(mounted){
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              size: 30,
            )),
        title: const Text(
          'Tạo mật khẩu mới',
          style: TextStyle(
            color: Color(0xFF212121),
            fontFamily: 'Sarabun',
            height: 0.05,
          ),
        ),
      ),
      body: ListView(
        children: [
          Image.asset('assets/images/editpass.png'),
          const SizedBox(
            height: 20,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 25, horizontal: 15),
            child: Text(
              'Nhập mật khẩu',
              style: TextStyle(
                color: Color(0xFF212121),
                fontSize: 22,
                fontFamily: 'Sarabun',
                fontWeight: FontWeight.w500,
                height: 0.08,
                letterSpacing: 0.20,
              ),
            ),
          ),
          MyTextPass(
            name: 'Nhập mật khẩu hiện tại',
            iconLeft: const Icon(Icons.lock_outline),
            controller: oldPassWord,
          ),
          MyTextPass(
            name: 'Mật khẩu mới',
            iconLeft: const Icon(Icons.lock_outline),
            controller: newPassWord,
          ),
          MyTextPass(
            name: 'Xác nhận mật khẩu mới',
            iconLeft: const Icon(Icons.lock_outline),
            controller: confirmNewPassWord,
          ),
          if(notifications!='')
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              notifications,
              style: const TextStyle(fontSize: 18, color: Colors.red),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: MyButton(onTap: editPassWord, content: 'Tiếp tục'),
          )
        ],
      ),
    );
  }
}
