import 'package:app_thuong_mai_dien_tu/resources/app_colors.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class InfomationAccount extends StatefulWidget {
  InfomationAccount({super.key, required this.name, required this.phone});
  String name;
  String phone;
  @override
  State<InfomationAccount> createState() => _InfomationAccountState();
}

class _InfomationAccountState extends State<InfomationAccount> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          widget.name,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: AppColor.secondaryColor,
            fontSize: 20,
            fontFamily: 'Sarabun',
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          widget.phone,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: AppColor.secondaryColor,
            fontSize: 20,
            fontFamily: 'Sarabun',
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
