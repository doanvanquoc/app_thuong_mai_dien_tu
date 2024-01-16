import 'dart:math';

import 'package:app_thuong_mai_dien_tu/data_sources/repo/user_api.dart';
import 'package:app_thuong_mai_dien_tu/models/user.dart';
import 'package:app_thuong_mai_dien_tu/nav_bar.dart';
import 'package:app_thuong_mai_dien_tu/resources/widgets/my_button.dart';
import 'package:app_thuong_mai_dien_tu/resources/widgets/my_textfile.dart';
import 'package:app_thuong_mai_dien_tu/views/login/login_view.dart';
import 'package:app_thuong_mai_dien_tu/views/login/widgets/loading.dart';
import 'package:app_thuong_mai_dien_tu/views/register/widgets/avartar.dart';
import 'package:app_thuong_mai_dien_tu/views/register/widgets/datetime.dart';
import 'package:app_thuong_mai_dien_tu/views/register/widgets/gender.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountInformation extends StatefulWidget {
  const AccountInformation(
      {super.key, required this.email, required this.passWord});
  final String email;
  final String passWord;

  @override
  State<AccountInformation> createState() => _AccountInformationState();
}

class _AccountInformationState extends State<AccountInformation> {
  String dropdownValue = 'Nam';
  TextEditingController name = TextEditingController();
  TextEditingController dateTime = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController gender = TextEditingController();
  String avatar =
      'https://res.cloudinary.com/dxe8ykmrn/image/upload/v1705375410/user-avatar/tgaudfhwukm4c6gm0zzy.jpg';
  String notifications = '';

  Future<void> registerUser() async {
    if (name.text.isEmpty ||
        dateTime.text.isEmpty ||
        phoneNumber.text.isEmpty ||
        gender.text.isEmpty) {
      setState(() {
        notifications = 'Cần nhập đầy đủ thông tin!';
      });
    } else {
      setState(() {
        notifications = '';
      });

      final UserAPI userApi = UserAPI.instance;
      DateTime birthdayy = DateFormat('dd/MM/yyyy').parse(dateTime.text);

      try {
        final result = await userApi.registerUser(widget.email, widget.passWord,
            name.text, birthdayy, phoneNumber.text, gender.text, avatar);
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
          print('line 63: ${decodedToken['id']}');
          final user = User(
              userID: decodedToken['id'],
              email: decodedToken['email'],
              fullname: decodedToken['fullname'],
              birthday: decodedToken['birthday'],
              phoneNumber: decodedToken['phone_number'],
              avatar: decodedToken['avatar'],
              sex: decodedToken['sex']);
          notifications = '';
          // ignore: use_build_context_synchronously
          openDialog(context, 'Đăng ký thành công',
              'Chúng tôi sẽ đưa bạn đến Trang chủ trong vài giây...');

          Future.delayed(
            const Duration(seconds: 2),
            () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (_) => MyNavBar(user: user),
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
      } catch (e) {
        setState(() {
          notifications = 'Lỗi kết nối';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        title: const Text(
          'Thông tin tài khoản',
          style: TextStyle(
            color: Color(0xFF212121),
            fontSize: 24,
            fontFamily: 'Sarabun',
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(5),
          child: Column(
            children: [
              Avatar(
                src:
                    'https://res.cloudinary.com/dxe8ykmrn/image/upload/v1705375410/user-avatar/tgaudfhwukm4c6gm0zzy.jpg',
              ),
              const SizedBox(
                height: 10,
              ),
              MyTextFile(
                name: 'Họ và tên',
                iconLeft: null,
                iconRight: null,
                controller: name,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: DateTimeBirthDay(
                  controller: dateTime,
                  date: 'Ngày sinh',
                ),
              ),
              MyTextFile(
                name: 'Số điện thoại',
                iconLeft: null,
                iconRight: const Icon(Icons.phone_android),
                controller: phoneNumber,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10, top: 10),
                child: Gender(controller: gender, selectedGender: 'Giới tính'),
              ),
              Text(
                notifications,
                style: const TextStyle(fontSize: 16, color: Colors.red),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: MyButton(
                  onTap: registerUser,
                  content: 'Tiếp tục',
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
