import 'package:app_thuong_mai_dien_tu/resources/widgets/my_button.dart';
import 'package:app_thuong_mai_dien_tu/resources/widgets/my_textfilepass.dart';
import 'package:app_thuong_mai_dien_tu/views/login/widgets/loading.dart';
import 'package:flutter/material.dart';

class EditPass extends StatefulWidget {
  const EditPass({super.key});

  @override
  State<EditPass> createState() => _EditPassState();
}

class _EditPassState extends State<EditPass> {
  TextEditingController oldPassWord =TextEditingController();
  TextEditingController newPassWord=TextEditingController();
  TextEditingController confirmNewPassWord=TextEditingController();

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
          'Tạo mật khẩu mới',
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
          Image.asset('assets/images/editpass.png'),
          const SizedBox(height: 20,),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 25,horizontal: 15),
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

          const SizedBox(height: 50,),
              
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: MyButton(
              onTap: (){
                openDialog(
                  context,
                  'Đổi mật khẩu thành công!',
                  'Mật khẩu đã được thay đổi thành công',
                );
              }, 
              content: 'Tiếp tục'
            ),
          )
        ],
      ),
    );
  }
}
