import 'package:app_thuong_mai_dien_tu/views/order/widgets/order_tracking_item.dart';
import 'package:app_thuong_mai_dien_tu/views/order/widgets/order_tracking_status.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class OrderTrackingPage extends StatelessWidget {
  const OrderTrackingPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Hành trình đơn hàng',
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const FaIcon(
              FontAwesomeIcons.magnifyingGlass,
              color: Colors.grey,
            ),
          ),
        ],
      ),
      body: const Column(
        children: [
          OrderTrackingItem(),
          SizedBox(height: 20),
          OrderTrackingStatus(),
        ],
      ),
    );
  }
}
