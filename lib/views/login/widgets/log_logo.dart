import 'package:app_thuong_mai_dien_tu/resources/app_colors.dart';
import 'package:flutter/material.dart';

class LoginLogo extends StatelessWidget {
  const LoginLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 90,
          height: 90,
          // decoration: ShapeDecoration(
          //   shape: RoundedRectangleBorder(
          //     borderRadius: BorderRadius.circular(1000),
          //   ),
          // ),
          child: Image(image: AssetImage("assets/images/logo.png")),
        ),
        Align(
          alignment: Alignment.center,
          child: Text(
            'CKCPhoneStore',
            style: TextStyle(
              color: AppColor.secondaryColor,
              fontSize: 30,
              fontFamily: 'Sarabun',
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}
