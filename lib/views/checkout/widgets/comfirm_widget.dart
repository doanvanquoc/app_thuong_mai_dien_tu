import 'package:app_thuong_mai_dien_tu/resources/widgets/my_button.dart';
import 'package:flutter/material.dart';

class ComfirmWidget extends StatelessWidget {
  const ComfirmWidget({
    super.key,
    required this.content,
    this.destinationScreen,
    this.onTap,
  });

  final String content;
  final Widget? destinationScreen;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      clipBehavior: Clip.antiAlias,
      decoration: const ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 0.7,
              strokeAlign: BorderSide.strokeAlignOutside,
              color: Color.fromARGB(255, 229, 228, 228),
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32),
              topRight: Radius.circular(32),
            ),
          ),
          shadows: [
            BoxShadow(
              color: Color(0x0C04060F),
              blurRadius: 60,
              offset: Offset(0, -4),
            )
          ]),
      child: Row(
        children: [
          Expanded(
            child: MyButton(
              onTap: () {
                if (onTap != null) {
                  onTap!();
                } else if (destinationScreen != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => destinationScreen!),
                  );
                }
              },
              content: content,
            ),
          ),
        ],
      ),
    );
  }
}
