import 'package:app_thuong_mai_dien_tu/resources/app_colors.dart';
import 'package:app_thuong_mai_dien_tu/views/order/widgets/order_tracking_status_item.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class OrderTrackingStatus extends StatelessWidget {
  const OrderTrackingStatus({super.key});
  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            OrderTrackingStatusItem(icon: FontAwesomeIcons.boxOpen),
            SizedBox(width: 5),
            Text(
              '- - - -',
              style: TextStyle(color: AppColor.primaryColor),
            ),
            SizedBox(width: 5),
            OrderTrackingStatusItem(icon: FontAwesomeIcons.truck),
            SizedBox(width: 5),
            Text(
              '- - - -',
              style: TextStyle(color: AppColor.primaryColor),
            ),
            SizedBox(width: 5),
            OrderTrackingStatusItem(icon: FontAwesomeIcons.peopleCarryBox)
          ],
        ),
        SizedBox(height: 20),
        Text(
          'Đơn hàng đã giao thành công',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }
}
