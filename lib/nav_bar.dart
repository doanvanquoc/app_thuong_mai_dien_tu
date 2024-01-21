import 'package:app_thuong_mai_dien_tu/models/user.dart';
import 'package:app_thuong_mai_dien_tu/resources/app_colors.dart';
import 'package:app_thuong_mai_dien_tu/views/account/account_view.dart';
import 'package:app_thuong_mai_dien_tu/views/cart/cart_view.dart';
import 'package:app_thuong_mai_dien_tu/views/home/home_view.dart';
import 'package:app_thuong_mai_dien_tu/views/order/order_view.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyNavBar extends StatefulWidget {
  const MyNavBar({super.key, required this.user, required this.index});
  final User user;
  final int index;
  @override
  State<MyNavBar> createState() => _MyNavBarState();
}

class _MyNavBarState extends State<MyNavBar> {
  List<Widget> pages = [];
  late int currentIndex = widget.index;

  @override
  void initState() {
    pages = [
      HomePage(
        user: widget.user,
      ),
      const CartView(),
      const OrderPage(),
      Account(
        user: widget.user,
      ),
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
              icon: FaIcon(FontAwesomeIcons.house), label: 'Trang chủ'),
          BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.bagShopping), label: 'Giỏ hàng'),
          BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.cartShopping), label: 'Đơn hàng'),
          BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.user), label: 'Tài khoản'),
        ],
      ),
    );
  }
}
