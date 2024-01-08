import 'package:app_thuong_mai_dien_tu/main.dart';
import 'package:app_thuong_mai_dien_tu/resources/widgets/my_button.dart';
import 'package:app_thuong_mai_dien_tu/views/login/widgets/log_textfield.dart';
import 'package:app_thuong_mai_dien_tu/views/register/widgets/avartar.dart';
import 'package:app_thuong_mai_dien_tu/views/register/widgets/gender.dart';
import 'package:flutter/material.dart';

class AccountInformation extends StatefulWidget {
  const AccountInformation({super.key});

  @override
  State<AccountInformation> createState() => _AccountInformationState();
}

class _AccountInformationState extends State<AccountInformation> {

  String dropdownValue='Nam';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.arrow_back_sharp, size: 30),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(5),
          child:  Column(
            children: [
              Avatar(src: 'assets/images/avartar.png',),
              const SizedBox(height: 20,),
              const LoginTextFile(name: 'Họ và tên', iconLeft: null, iconRight: null, lock: false),
              const LoginTextFile(name: 'Biệt danh', iconLeft: null, iconRight: null, lock: false),
              const LoginTextFile(name: 'Ngày sinh', iconLeft: null, iconRight: Icon(Icons.date_range), lock: false),
              const LoginTextFile(name: 'Email', iconLeft: null, iconRight: Icon(Icons.email), lock: false),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0,vertical: 8.0),
                child: Gender(),
              ),

              const SizedBox(height: 30,),
              
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: MyButton(onTap: (){}, content: 'Tiếp tục'),
              )

            ],
          ),
        ),
      ),
    );
  }
}
