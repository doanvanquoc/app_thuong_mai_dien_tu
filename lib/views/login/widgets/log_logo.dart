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
              color: Color(0xFF212121),
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
