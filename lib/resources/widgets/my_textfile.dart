import 'package:flutter/material.dart';

class MyTextFile extends StatefulWidget {
  const MyTextFile({
    super.key,
    required this.name,
    required this.iconLeft,
    required this.iconRight,
    required this.controller,
  });

  final String name;
  final Icon? iconLeft;
  final Icon? iconRight;
  final TextEditingController controller;

  @override
  State<MyTextFile> createState() => _MyTextFileState();
}

class _MyTextFileState extends State<MyTextFile> {
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
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: TextField(
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        controller: widget.controller,
        focusNode: _focusNode,
        obscureText: false,
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
        // controller: ,
      ),
    );
  }
}
