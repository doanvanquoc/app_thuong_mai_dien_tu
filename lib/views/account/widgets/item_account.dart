import 'package:flutter/material.dart';

class ItemAccount extends StatefulWidget {
  const ItemAccount({
    super.key,
    required this.title,
    this.colorr,
    required this.iconLeft,
    required this.iconRight,
    required this.onTap,
  });

  final Icon iconLeft;
  final Icon? iconRight;
  final String title;
  final Color? colorr;
  final Function onTap;

  @override
  State<ItemAccount> createState() => _ItemAccountState();
}

class _ItemAccountState extends State<ItemAccount> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: InkWell(
        onTap: () {
          widget.onTap();
        },
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: widget.iconLeft,
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Text(
                widget.title,
                style: TextStyle(
                  color: widget.colorr,
                  fontSize: 16,
                  fontFamily: 'Sarabun',
                  fontWeight: FontWeight.w500,
                  height: 0.08,
                  letterSpacing: 0.20,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: widget.iconRight,
            ),
          ],
        ),
      ),
    );
  }
}
