import 'package:flutter/material.dart';

class InfomationAccount extends StatefulWidget {
  InfomationAccount({super.key,required this.name,required this.phone});
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
              color: Color(0xFF212121),
              fontSize: 24,
              fontFamily: 'Sarabun',
              fontWeight: FontWeight.w700,
            ),
        ),
        Text(
            widget.phone,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xFF212121),
              fontSize: 20,
              fontFamily: 'Sarabun',
              fontWeight: FontWeight.w600,
            ),
          ),
      ],
    );
  }
}