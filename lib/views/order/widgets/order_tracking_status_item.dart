import 'package:app_thuong_mai_dien_tu/resources/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class OrderTrackingStatusItem extends StatelessWidget {
  const OrderTrackingStatusItem({super.key, required this.icon});
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FaIcon(
          icon,
          color: AppColor.primaryColor,
        ),
        const SizedBox(height: 5),
        const FaIcon(
          FontAwesomeIcons.circleCheck,
          color: AppColor.primaryColor,
        ),
      ],
    );
  }
}
