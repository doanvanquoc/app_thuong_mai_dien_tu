import 'package:app_thuong_mai_dien_tu/data_sources/repo/user_api.dart';
import 'package:app_thuong_mai_dien_tu/models/user.dart';
import 'package:app_thuong_mai_dien_tu/resources/widgets/my_button.dart';
import 'package:app_thuong_mai_dien_tu/resources/widgets/my_textfile.dart';
import 'package:app_thuong_mai_dien_tu/views/account/account_view.dart';
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
  String notifications = '';

  Future<void> updateAccount() async {
    if (name.text.isEmpty ||
        dateTime.text.isEmpty ||
        phoneNumber.text.isEmpty ||
        gender.text.isEmpty ||
        email.text.isEmpty) {
      setState(() {
        notifications = 'Cần nhập đầy đủ thông tin!';
      });
    } else {
      notifications = '';
      final UserAPI userApi = UserAPI.instance;
      DateTime birthdayy = DateFormat('dd/MM/yyyy').parse(dateTime.text);

      final result = await userApi.updateUser(
          userId: widget.user.userID,
          email: email.text,
          fullname: name.text,
          birthday: birthdayy,
          phoneNumber: phoneNumber.text,
          sex: gender.text);

      if (result.containsKey('error')) {
        notifications = result['error'];
      } else if (result.containsKey('code') && result['code'] == 1) {
        final token = result['token'];

        //Lưu token vào local
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('auth_token', token);

        Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
        print('line 62: $decodedToken');

        final newUser = User.fromJson(decodedToken['user']);

        print(newUser);
        notifications = '';
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
              MaterialPageRoute(builder: (_) => Account(user: newUser)),
              (route) => false,
            );
          },
        );
      } else {
        notifications = 'Email đã tồn tại!';
      }
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
          MyTextFile(
            name: widget.user.email == '' ? 'Email' : widget.user.email,
            iconLeft: null,
            iconRight: const Icon(Icons.email_outlined),
            controller: email,
          ),
          MyTextFile(
            name: widget.user.phoneNumber == ''
                ? 'Số điện thoại'
                : widget.user.phoneNumber,
            iconLeft: null,
            iconRight: const Icon(Icons.smartphone_outlined),
            controller: phoneNumber,
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
            child: Gender(
                controller: gender,
                selectedGender:
                    widget.user.sex == '' ? 'Giới tính' : widget.user.sex),
          ),
          Text(
            notifications,
            style: const TextStyle(fontSize: 18, color: Colors.red),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: MyButton(onTap: updateAccount, content: 'Cập nhật'),
          )
        ],
      ),
    );
  }
}
