import 'package:app_thuong_mai_dien_tu/resources/widgets/my_button.dart';
import 'package:app_thuong_mai_dien_tu/resources/widgets/my_textfile.dart';
import 'package:app_thuong_mai_dien_tu/views/login/widgets/loading.dart';
import 'package:app_thuong_mai_dien_tu/views/register/widgets/datetime.dart';
import 'package:app_thuong_mai_dien_tu/views/register/widgets/gender.dart';
import 'package:flutter/material.dart';

class EditAccount extends StatefulWidget {
  const EditAccount({super.key});

  @override
  State<EditAccount> createState() => _EditAccountState();
}

class _EditAccountState extends State<EditAccount> {
  TextEditingController name=TextEditingController();
  TextEditingController nickName=TextEditingController();
  TextEditingController dateTime=TextEditingController();
  TextEditingController email=TextEditingController();
  TextEditingController phoneNumber =TextEditingController();


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
            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
            child: DateTimeBirthDay(controller: dateTime),
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
            iconRight: const Icon(Icons.smartphone_outlined),
            controller: phoneNumber,
          ),
          const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0,vertical: 8.0),
                child: Gender(),
              ),

              const SizedBox(height: 50,),
              
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: MyButton(
                  onTap: (){
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
