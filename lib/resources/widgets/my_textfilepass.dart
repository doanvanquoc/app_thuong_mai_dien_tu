import 'package:flutter/material.dart';

class MyTextPass extends StatefulWidget {
  const MyTextPass({
    Key? key,
    required this.name,
    required this.iconLeft,
    required this.controller,
  }) : super(key: key);

  final String name;
  final Icon? iconLeft;
  final TextEditingController controller;

  @override
  State<MyTextPass> createState() => _MyTextPassState();
}

class _MyTextPassState extends State<MyTextPass> {
  bool isIconLeftPressed = false;
  bool isIconRightPressed = false;
  bool lock=true;

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
      child: TextFormField(
        controller: widget.controller,
        focusNode: _focusNode,
        obscureText: lock,
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
          suffixIcon: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () {
                  lock = !lock;
                  setState(() {});
                },
                icon: lock
                    ? Icon(
                        Icons.lock_outlined,
                        color: isIconRightPressed ? Colors.green : Colors.black,
                      )
                    : Icon(
                        Icons.lock_open_outlined,
                        color: isIconRightPressed ? Colors.green : Colors.black,
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
