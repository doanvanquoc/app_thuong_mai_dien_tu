import 'package:flutter/material.dart';

class LoginTextFile extends StatefulWidget {
  const LoginTextFile({
    Key? key,
    required this.name,
    required this.iconLeft,
    required this.iconRight,
    required this.lock,
  }) : super(key: key);

  final String name;
  final Icon? iconLeft;
  final Icon? iconRight;
  final bool lock;

  @override
  State<LoginTextFile> createState() => _LoginTextFileState();
}

class _LoginTextFileState extends State<LoginTextFile> {
  bool isIconLeftPressed = false;
  bool isIconRightPressed = false;

  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      setState(() {
        isIconLeftPressed = _focusNode.hasFocus;
        isIconRightPressed = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
      child: TextField(
        focusNode: _focusNode,
        obscureText: widget.lock,
        style: const TextStyle(color: Colors.black, fontSize: 16),
        decoration: InputDecoration(
          hintText: widget.name,
          hintStyle: const TextStyle(color: Color.fromRGBO(158, 155, 158, 1)),
          filled: true,
          fillColor: Colors.grey[200],
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
            borderSide: BorderSide(
              width: 2,
              color: Colors.grey[200]!,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
            borderSide: const BorderSide(
              width: 2,
              color: Color.fromRGBO(1, 183, 99, 1),
            ),
          ),
          prefixIcon: Icon(
            widget.iconLeft?.icon,
            color: isIconLeftPressed ? Colors.green : Colors.black,
          ),
          suffixIcon: Icon(
            widget.iconRight?.icon,
            color: isIconRightPressed ? Colors.green : Colors.black,
          ),
        ),
      ),
    );
  }
}
