import 'package:app_thuong_mai_dien_tu/resources/app_colors.dart';
import 'package:app_thuong_mai_dien_tu/views/order/order_tracking_view.dart';
import 'package:app_thuong_mai_dien_tu/views/order/widgets/order_item.dart';
import 'package:app_thuong_mai_dien_tu/views/order/widgets/order_rating.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({super.key});
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Đơn hàng',
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
          bottom: const TabBar(
            tabs: [
              Text('Chờ xác nhận'),
              Text('Đang giao'),
              Text('Hoàn thành'),
            ],
            indicatorColor: AppColor.primaryColor,
            unselectedLabelColor: Colors.grey,
            labelStyle: TextStyle(fontWeight: FontWeight.bold),
            labelColor: AppColor.primaryColor,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: TabBarView(
            children: [
              ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) => OrderITem(
                  status: 'Chờ xác nhận',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const OrderTrackingPage(),
                      ),
                    );
                  },
                ),
              ),
              ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) => OrderITem(
                  status: 'Đang giao',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const OrderTrackingPage(),
                      ),
                    );
                  },
                ),
              ),
              ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) => OrderITem(
                  status: 'Hoàn thành',
                  action: 'Đánh giá',
                  onTap: () => showRating(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showRating(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => Container(
        // height: MediaQuery.of(context).size.height * 0.75,
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: const Wrap(
          children: [OrderRating()],
        ),
      ),
    );
  }
}
