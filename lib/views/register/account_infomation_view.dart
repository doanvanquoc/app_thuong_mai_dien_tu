// ignore: file_names
import 'dart:io';

import 'package:app_thuong_mai_dien_tu/data_sources/repo/user_api.dart';
import 'package:app_thuong_mai_dien_tu/models/user.dart';
import 'package:app_thuong_mai_dien_tu/nav_bar.dart';
import 'package:app_thuong_mai_dien_tu/resources/widgets/my_button.dart';
import 'package:app_thuong_mai_dien_tu/resources/widgets/my_textfile.dart';
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
  TextEditingController name = TextEditingController();
  TextEditingController dateTime = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController gender = TextEditingController();
  String notiName = '';
  String notiDateTime = '';
  String notiPhoneNumber = '';
  String notiGender = '';
  File? selectedImage;

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
              Text('Đang kiểm tra thông tin đăng ký...'),
            ],
          ),
        );
      },
    );
    try {
      RegExp regExp = RegExp(r'^0[0-9]{9}$');

      if (name.text.isEmpty) {
        notiName = 'Vui lòng nhập họ và tên!';
      } else {
        notiName = '';
      }

      if (dateTime.text.isEmpty) {
        notiDateTime = 'Vui lòng chọn ngày sinh!';
      } else if (!kiemtratuoi(dateTime.text)) {
        notiDateTime = 'Không đủ tuổi( tuổi >=18)';
      } else {
        notiDateTime = '';
      }

      if (phoneNumber.text.isEmpty) {
        notiPhoneNumber = 'Vui lòng nhập số điện thoại!';
      } else if (!regExp.hasMatch(phoneNumber.text)) {
        notiPhoneNumber = 'Số điện thoại phải có định dạng "0xxxxxxxxx"';
      } else {
        notiPhoneNumber = '';
      }

      if (gender.text.isEmpty) {
        notiGender = 'Vui lòng chọn giới tính!';
      } else {
        notiGender = '';
      }

      if (name.text.isNotEmpty &&
          dateTime.text.isNotEmpty &&
          phoneNumber.text.isNotEmpty &&
          regExp.hasMatch(phoneNumber.text) &&
          gender.text.isNotEmpty) {
        notiDateTime = '';
        notiGender = '';
        notiPhoneNumber = '';
        notiName = '';
        final UserAPI userApi = UserAPI.instance;
        DateTime birthdayy = DateFormat('dd/MM/yyyy').parse(dateTime.text);

        try {
          String fullname =
              name.text.toString().replaceAll(RegExp(r'\s+'), ' ').trim();
          final result = await userApi.registerUser(
              widget.email,
              widget.passWord,
              fullname,
              birthdayy,
              phoneNumber.text,
              gender.text,
              selectedImage);

          await Future.delayed(const Duration(seconds: 2));

          if (result.containsKey('code') && result['code'] == 1) {
            final token = result['token'];

            // Lưu token vào local
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setString('auth_token', token);
            prefs.setBool('is_logged_out', false);

            Map<String, dynamic> decodedToken = JwtDecoder.decode(token);

            final user = User(
                userID: decodedToken['user']['id'],
                email: decodedToken['user']['email'],
                fullname: decodedToken['user']['fullname'],
                birthday: decodedToken['user']['birthday'],
                phoneNumber: decodedToken['user']['phone_number'],
                avatar: decodedToken['user']['avatar'],
                sex: decodedToken['user']['sex']);
            // ignore: use_build_context_synchronously
            Navigator.maybePop(context);
            Future.delayed(Duration.zero, () {
              // ignore: use_build_context_synchronously
              openDialog(context, 'Đăng ký thành công',
                  'Chúng tôi sẽ đưa bạn đến Trang chủ trong vài giây...');
            });
            Future.delayed(const Duration(seconds: 2), () {
              // ignore: use_build_context_synchronously
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (_) => MyNavBar(
                    user: user,
                    index: 0,
                  ),
                ),
                (route) => false,
              );
            });
          } else {
            // ignore: use_build_context_synchronously
            openDialog(context, 'Đăng ký tài khoản thất bại',
                'Có lỗi trong quá trình đăng ký');
          }
        } catch (e) {
          // ignore: use_build_context_synchronously
          openDialog(context, 'Đăng ký tài khoản thất bại',
              'Có lỗi trong quá trình đăng ký');
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Avatar(
                  src:
                      'https://res.cloudinary.com/dxe8ykmrn/image/upload/v1705375410/user-avatar/tgaudfhwukm4c6gm0zzy.jpg',
                  onImageSelected: (File? image) {
                    if(mounted){
                      setState(() {
                      selectedImage = image;
                    });
                    }
                  }),
              const SizedBox(
                height: 10,
              ),
              MyTextFile(
                name: 'Họ và tên',
                iconLeft: null,
                iconRight: null,
                controller: name,
              ),
              notiName.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: Text(
                        notiName,
                        style: const TextStyle(fontSize: 16, color: Colors.red),
                        textAlign: TextAlign.left,
                      ),
                    )
                  : const SizedBox(),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: DateTimeBirthDay(
                  controller: dateTime,
                  datetime: 'Ngày sinh',
                ),
              ),
              notiDateTime.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: Text(
                        notiDateTime,
                        style: const TextStyle(fontSize: 16, color: Colors.red),
                        textAlign: TextAlign.left,
                      ),
                    )
                  : const SizedBox(),
              MyTextFile(
                name: 'Số điện thoại',
                iconLeft: null,
                iconRight: const Icon(Icons.phone_android),
                controller: phoneNumber,
              ),
              notiPhoneNumber.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: Text(
                        notiPhoneNumber,
                        style: const TextStyle(fontSize: 16, color: Colors.red),
                        textAlign: TextAlign.left,
                      ),
                    )
                  : const SizedBox(),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10, top: 10),
                child: Gender(controller: gender, selectedGender: 'Giới tính'),
              ),
              notiGender.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: Text(
                        notiGender,
                        style: const TextStyle(fontSize: 16, color: Colors.red),
                        textAlign: TextAlign.left,
                      ),
                    )
                  : const SizedBox(),
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

  bool kiemtratuoi(String birthDate) {
    try {
      List<String> dateParts = birthDate.split("/");
      String formattedDate = "${dateParts[2]}-${dateParts[1]}-${dateParts[0]}";

      DateTime parsedDate = DateTime.parse(formattedDate);
      DateTime currentDate = DateTime.now();
      Duration difference = currentDate.difference(parsedDate);
      int age = (difference.inDays / 365).floor();
      return age >= 18;
    } catch (e) {
      return false;
    }
  }
}
