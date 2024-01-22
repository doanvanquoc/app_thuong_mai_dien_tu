import 'package:flutter/material.dart';

class AddAddressWidget extends StatelessWidget {
  const AddAddressWidget({
    super.key,
    required this.title,
    required this.content,
    required this.controller,
    required this.focusNode,
  });

  final String title;
  final String content;
  final TextEditingController controller;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        textSelectionTheme: const TextSelectionThemeData(
          selectionColor: Color(0xff01B763),
        ),
      ),
      child: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Color(0xFF212121),
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: controller,
              focusNode: focusNode,
              clipBehavior: Clip.antiAlias,
              cursorColor: const Color(0xff01B763),
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
                hintText: content,
                hintStyle: const TextStyle(
                  color: Color(0xFF616161),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide:
                        const BorderSide(width: 0.9, color: Colors.grey)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide:
                        const BorderSide(width: 0.9, color: Color(0xff01B763))),
                filled: true,
                fillColor: const Color(0xffFAFAFA),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
