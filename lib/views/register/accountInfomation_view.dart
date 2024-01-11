import 'package:app_thuong_mai_dien_tu/nav_bar.dart';
import 'package:app_thuong_mai_dien_tu/resources/widgets/my_button.dart';
import 'package:app_thuong_mai_dien_tu/resources/widgets/my_textfile.dart';
import 'package:app_thuong_mai_dien_tu/views/login/widgets/loading.dart';
import 'package:app_thuong_mai_dien_tu/views/register/widgets/avartar.dart';
import 'package:app_thuong_mai_dien_tu/views/register/widgets/datetime.dart';
import 'package:app_thuong_mai_dien_tu/views/register/widgets/gender.dart';
import 'package:flutter/material.dart';

class AccountInformation extends StatefulWidget {
  const AccountInformation({super.key});

  @override
  State<AccountInformation> createState() => _AccountInformationState();
}

class _AccountInformationState extends State<AccountInformation> {
  String dropdownValue = 'Nam';
  TextEditingController name = TextEditingController();
  TextEditingController nickName = TextEditingController();
  TextEditingController dateTime = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // leading: IconButton(
          //   onPressed: (){},
          //   icon: const Icon(Icons.arrow_back_sharp,size: 30,)
          // ),
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
      )),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(5),
          child: Column(
            children: [
              Avatar(
                src: 'assets/images/avartar.png',
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
              MyTextFile(
                name: 'Biệt danh',
                iconLeft: null,
                iconRight: null,
                controller: nickName,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: DateTimeBirthDay(
                  controller: dateTime,
                ),
              ),
              MyTextFile(
                name: 'Email',
                iconLeft: null,
                iconRight: const Icon(Icons.email_outlined),
                controller: email,
              ),
              MyTextFile(
                name: 'Số điện thoại',
                iconLeft: null,
                iconRight: const Icon(Icons.phone_android),
                controller: phoneNumber,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
                child: Gender(),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: MyButton(
                    onTap: () {
                      openDialog(
                        context,
                        'Tạo tài khoản thành công',
                        'Tài khoản của bạn đã có thể sử dụng. Chúng tôi sẽ đưa bạn đến Trang chủ trong vài giây...',
                      );
                      Future.delayed(
                          const Duration(seconds: 2),
                          () => {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => const MyNavBar()),
                                    (route) => false)
                              });
                    },
                    content: 'Tiếp tục'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
