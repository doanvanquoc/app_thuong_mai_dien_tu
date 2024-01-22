import 'package:flutter/material.dart';

class CheckLogin extends StatefulWidget {
  const CheckLogin({super.key});

  @override
  State<CheckLogin> createState() => _CheckLoginState();
}

class _CheckLoginState extends State<CheckLogin> {
  bool isChecked = false;

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.green; // Màu xanh lá khi được nhấn hoặc hover
    }
    return Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Checkbox(
          checkColor: Colors.green,
          fillColor: MaterialStateProperty.resolveWith(getColor),
          value: isChecked,
          onChanged: (bool? value) {
            if(mounted){
              setState(() {
              isChecked = value!;
            });
            }
          },
          shape: RoundedRectangleBorder(
            side: const BorderSide(
              color: Colors.green,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(4.0),
          ),
        ),
        const SizedBox(width: 5.0),
        const Text(
          'Ghi nhớ đăng nhập',
          style: TextStyle(
            color: Color(0xFF212121),
            fontSize: 20,
            fontFamily: 'Sarabun',
            fontWeight: FontWeight.w600,
            height: 0.10,
            letterSpacing: 0.20,
          ),
        ),
      ],
    );
  }
}
