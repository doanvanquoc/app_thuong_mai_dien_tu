import 'package:flutter/material.dart';

class LoginLogo extends StatelessWidget {
  const LoginLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 70,
          height: 120,
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(1000),
            ),
          ),
          child: const Image(image: AssetImage("assets/images/logo.png")),
        ),
        const Align(
          alignment: Alignment.center,
          child: Text(
            'CKCPhoneStore',
            style: TextStyle(
              color: Color(0xFF212121),
              fontSize: 40,
              fontFamily: 'Sarabun',
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}