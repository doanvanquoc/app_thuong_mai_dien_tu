import 'package:app_thuong_mai_dien_tu/data_sources/repo/user_api.dart';
import 'package:app_thuong_mai_dien_tu/models/user.dart';
import 'package:app_thuong_mai_dien_tu/nav_bar.dart';
import 'package:app_thuong_mai_dien_tu/resources/widgets/my_button.dart';
import 'package:app_thuong_mai_dien_tu/resources/widgets/my_textfile.dart';
import 'package:app_thuong_mai_dien_tu/views/account/widgets/notification_account.dart';
import 'package:app_thuong_mai_dien_tu/views/login/widgets/loading.dart';
import 'package:app_thuong_mai_dien_tu/views/register/widgets/datetime.dart';
import 'package:app_thuong_mai_dien_tu/views/register/widgets/gender.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class EditAccount extends StatefulWidget {
  EditAccount({super.key, required this.user});
  User user;
  @override
  State<EditAccount> createState() => _EditAccountState();
}

class _EditAccountState extends State<EditAccount> {
  TextEditingController name = TextEditingController();
  TextEditingController dateTime = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController gender = TextEditingController();
  String notiName = '';
  String notiDateTime = '';
  String notiPhoneNumber = '';
  String notiGender = '';
  String notiEmail = '';

  Future<void> updateAccount() async {
    RegExp regExp = RegExp(r'^0[0-9]{9}$');
    RegExp emailRegExp = RegExp(
      r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$',
    );

    if (email.text.isNotEmpty && !emailRegExp.hasMatch(email.text)) {
      notiEmail = 'Email không hợp lệ!';
    } else {
      notiEmail = '';
    }

    if (phoneNumber.text.isNotEmpty && !regExp.hasMatch(phoneNumber.text)) {
      notiPhoneNumber = 'Số điện thoại phải có định dạng "0xxxxxxxxx"';
    } else {
      notiPhoneNumber = '';
    }

    if (dateTime.text.isNotEmpty && !kiemtratuoi(dateTime.text)) {
      notiDateTime = 'Không đủ tuổi( tuổi >= 18)';
    } else {
      notiDateTime = '';
    }

    if (notiEmail.isNotEmpty ||
        notiPhoneNumber.isNotEmpty ||
        notiDateTime.isNotEmpty) {
      setState(() {});
      return;
    }
    DateTime birthdayy = dateTime.text.isNotEmpty
        ? DateFormat('dd/MM/yyyy').parse(dateTime.text)
        : DateTime.parse(widget.user.birthday);
    if ((name.text.trim().isNotEmpty &&
            name.text.toString().replaceAll(RegExp(r'\s+'), ' ').trim() !=
                widget.user.fullname) ||
        (dateTime.text.isNotEmpty &&
            birthdayy != DateTime.parse(widget.user.birthday)) ||
        (phoneNumber.text.isNotEmpty &&
            phoneNumber.text.replaceAll(RegExp(r'\s+'), '') !=
                widget.user.phoneNumber) ||
        (gender.text.isNotEmpty && gender.text != widget.user.sex) ||
        (email.text.isNotEmpty)) {
      notiDateTime = '';
      notiGender = '';
      notiPhoneNumber = '';
      notiName = '';

      print(
          'Name: ${name.text}; Date: ${dateTime.text}; Phone: ${phoneNumber.text}; sex: ${gender.text}; Email: ${email.text}');
      final UserAPI userApi = UserAPI.instance;
      final result = await userApi.updateUser(
        userId: widget.user.userID,
        email: email.text.replaceAll(RegExp(r'\s+'), ''),
        fullname: name.text.trim().isEmpty
            ? widget.user.fullname
            : name.text.toString().replaceAll(RegExp(r'\s+'), ' ').trim(),
        birthday: birthdayy,
        phoneNumber: phoneNumber.text.isEmpty
            ? widget.user.phoneNumber
            : phoneNumber.text.replaceAll(RegExp(r'\s+'), ''),
        sex: gender.text.isEmpty ? widget.user.sex : gender.text,
      );

      if (result.containsKey('code') && result['code'] == 1) {
        final token = result['token'];

        //Lưu token vào local
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('auth_token', token);

        Map<String, dynamic> decodedToken = JwtDecoder.decode(token);

        widget.user = User.fromJson(decodedToken['user']);
        // ignore: use_build_context_synchronously
        openDialog(
          context,
          'Chỉnh sửa thông tin thành công!',
          'Thông tin đã được thay đổi thành công!',
        );
        Future.delayed(
          const Duration(seconds: 2),
          () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (_) => MyNavBar(
                  user: widget.user,
                  index: 3,
                ),
              ),
              (route) => false,
            );
          },
        );
      } else {
        // ignore: use_build_context_synchronously
        notiEmail = 'Email đã tồn tại trong hệ thống!';
      }
    }else{
      notiAcconut(context, 'Cập nhật thất bại!', 'Vui lòng nhập thông tin muốn cập nhật');
    }
    setState(() {});
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
          'Chỉnh sửa thông tin',
          style: TextStyle(
            color: Color(0xFF212121),
            fontSize: 28,
            fontFamily: 'Sarabun',
            fontWeight: FontWeight.w700,
            height: 0.05,
          ),
        ),
      ),
      body: ListView(
        children: [
          const SizedBox(
            height: 20,
          ),
          MyTextFile(
            name:
                widget.user.fullname == '' ? 'Họ và tên' : widget.user.fullname,
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
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: DateTimeBirthDay(
                controller: dateTime,
                datetime: widget.user.birthday == ''
                    ? 'Ngày sinh'
                    : DateFormat('dd/MM/yyyy')
                        .format(DateTime.parse(widget.user.birthday))
                        .toString(),
              )),
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
            name: widget.user.email == '' ? 'Email' : widget.user.email,
            iconLeft: null,
            iconRight: const Icon(Icons.email_outlined),
            controller: email,
          ),
          notiEmail.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Text(
                    notiEmail,
                    style: const TextStyle(fontSize: 16, color: Colors.red),
                    textAlign: TextAlign.left,
                  ),
                )
              : const SizedBox(),
          MyTextFile(
            name: widget.user.phoneNumber == ''
                ? 'Số điện thoại'
                : widget.user.phoneNumber,
            iconLeft: null,
            iconRight: const Icon(Icons.smartphone_outlined),
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
            padding: const EdgeInsets.only(left: 10, right: 10, top: 10.0),
            child: Gender(
                controller: gender,
                selectedGender:
                    widget.user.sex == '' ? 'Giới tính' : widget.user.sex),
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
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: MyButton(onTap: updateAccount, content: 'Cập nhật'),
          )
        ],
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
