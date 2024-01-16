import 'package:app_thuong_mai_dien_tu/models/user.dart';
import 'package:app_thuong_mai_dien_tu/resources/widgets/my_button.dart';
import 'package:app_thuong_mai_dien_tu/resources/widgets/my_textfile.dart';
import 'package:app_thuong_mai_dien_tu/views/login/widgets/loading.dart';
import 'package:app_thuong_mai_dien_tu/views/register/widgets/datetime.dart';
import 'package:app_thuong_mai_dien_tu/views/register/widgets/gender.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EditAccount extends StatefulWidget {
  EditAccount({super.key,required this.user});
  User user;
  @override
  State<EditAccount> createState() => _EditAccountState();
}

class _EditAccountState extends State<EditAccount> {
  TextEditingController name=TextEditingController();
  TextEditingController nickName=TextEditingController();
  TextEditingController dateTime=TextEditingController();
  TextEditingController email=TextEditingController();
  TextEditingController phoneNumber =TextEditingController();
  TextEditingController gender=TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          }, 
          icon: const Icon(Icons.arrow_back,size: 30,)
        ),
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
        children:  [
          const SizedBox(height: 20,),
          MyTextFile(
            name: widget.user.fullname==''?'Họ và tên':widget.user.fullname, 
            iconLeft: null, 
            iconRight: null, 
            controller: name,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
            child: DateTimeBirthDay(
              controller: dateTime,
              date: widget.user.birthday == ''? 'Ngày sinh': DateFormat('dd/MM/yyyy').format(DateTime.parse(widget.user.birthday)).toString(),
            )
          ),
          MyTextFile(
            name: widget.user.email==''?'Email':widget.user.email, 
            iconLeft: null, 
            iconRight: const Icon(Icons.email_outlined), 
            controller: email,
          ),
          MyTextFile(
            name: widget.user.phoneNumber==''?'Số điện thoại':widget.user.phoneNumber, 
            iconLeft: null, 
            iconRight: const Icon(Icons.smartphone_outlined),
            controller: phoneNumber,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 8.0),
            child: Gender(controller: gender,selectedGender: widget.user.sex==''?'Giới tính':widget.user.sex),
          ),
      
          const SizedBox(height: 50,),
              
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: MyButton(
              onTap: (){
                print(widget.user.sex);
                openDialog(
                  context,
                  'Chỉnh sửa thông tin thành công!',
                  'Thông tin đã được thay đổi thành công!',
                );
              }, 
              content: 'Cập nhật'
            ),
          )
        ],
      ),
    );
  }
}
