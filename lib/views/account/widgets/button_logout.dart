import 'package:flutter/material.dart';

class ButtonLogOut extends StatelessWidget {
  const ButtonLogOut({super.key,required this.onTap,required this.content,required this.colorr,required this.colorContent});
  final Function() onTap;
  final String content;
  final Color colorr;
  final Color colorContent;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width/2-20,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        decoration: BoxDecoration(
          color: colorr,
          borderRadius: BorderRadius.circular(30),
        ),
        alignment: Alignment.center,
        child: Text(
          content,
          style:  TextStyle(color: colorContent, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}