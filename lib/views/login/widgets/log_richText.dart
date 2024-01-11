import 'package:flutter/material.dart';

class RichTextLog extends StatefulWidget {
  RichTextLog({Key? key, required this.question, required this.name, required this.onTap})
      : super(key: key);

  String question;
  String name;
  final Function() onTap;

  @override
  State<RichTextLog> createState() => _RichTextLogState();
}

class _RichTextLogState extends State<RichTextLog> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: widget.question,
                style: const TextStyle(
                  color: Color(0xFF9E9E9E),
                  fontSize: 18,
                  fontFamily: 'Sarabun',
                  fontWeight: FontWeight.w400,
                  height: 1.0,
                  letterSpacing: 0.20,
                ),
              ),
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: TextButton(
                  onPressed: widget.onTap,
                  child: Text(
                    widget.name,
                    style: const TextStyle(
                      color: Color(0xFF01B763),
                      fontSize: 18,
                      fontFamily: 'Sarabun',
                      fontWeight: FontWeight.w600,
                      height: 1.0,
                      letterSpacing: 0.20,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
