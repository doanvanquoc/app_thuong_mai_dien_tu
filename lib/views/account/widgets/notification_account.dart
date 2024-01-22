import 'package:app_thuong_mai_dien_tu/resources/app_colors.dart';
import 'package:app_thuong_mai_dien_tu/resources/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

Future notiAcconut(BuildContext context, String title, String detail) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      content: Container(
        padding: const EdgeInsets.all(20),
        height: 500,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Lottie.asset(
              'assets/animations/error.json',
              width: 190,
              height: 190,
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColor.secondaryColor,
                fontSize: 24,
                fontFamily: 'Sarabun',
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              detail,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColor.secondaryColor,
                fontSize: 16,
                fontFamily: 'Sarabun',
                fontWeight: FontWeight.w400,
                letterSpacing: 0.20,
              ),
            ),
            MyButton(onTap: (){
              Navigator.pop(context);
            }, content: 'Đóng')
          ],
        ),
      ),
    ),
  );
}
