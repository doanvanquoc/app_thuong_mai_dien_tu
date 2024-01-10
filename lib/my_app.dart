import 'package:app_thuong_mai_dien_tu/resources/app_colors.dart';
import 'package:app_thuong_mai_dien_tu/views/home/home_view.dart';
import 'package:app_thuong_mai_dien_tu/views/order/order_view.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyApp2 extends StatefulWidget {
  const MyApp2({super.key});
  @override
  State<MyApp2> createState() => _MyApp2State();
}

class _MyApp2State extends State<MyApp2> {
  List<Widget> pages = [];
  int currentIndex = 0;
  @override
  void initState() {
    pages = [
      HomePage(),
      HomePage(),
      OrderPage(),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (value) {
          setState(() {
            currentIndex = value;
          });
        },
        type: BottomNavigationBarType.shifting,
        fixedColor: AppColor.primaryColor,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        unselectedLabelStyle: const TextStyle(color: Colors.grey),
        items: const [
          BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.houseMedical), label: 'Trang chủ'),
          BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.bagShopping), label: 'Giỏ hàng'),
          BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.cartShopping), label: 'Đơn hàng'),
          BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.wallet), label: 'Ví của tôi'),
          BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.user), label: 'Tài khoản'),
        ],
      ),
    );
  }
}
