import 'package:app_thuong_mai_dien_tu/models/user.dart';
import 'package:app_thuong_mai_dien_tu/views/account/edit_pass_view.dart';
import 'package:app_thuong_mai_dien_tu/views/account/editaccount_view.dart';
import 'package:app_thuong_mai_dien_tu/views/account/widgets/button_logout.dart';
import 'package:app_thuong_mai_dien_tu/views/account/widgets/infomation_account.dart';
import 'package:app_thuong_mai_dien_tu/views/account/widgets/item_account.dart';
import 'package:app_thuong_mai_dien_tu/views/checkout/address_view.dart';
import 'package:app_thuong_mai_dien_tu/views/login/login_view.dart';
import 'package:app_thuong_mai_dien_tu/views/notification/notification_view.dart';
import 'package:app_thuong_mai_dien_tu/views/register/widgets/avartar.dart';
import 'package:flutter/material.dart';

class Account extends StatefulWidget {
  const Account({super.key,required this.user});
  final User? user;
  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset('assets/images/logo.png'),
        title: const Text(
          'Tài khoản',
          style: TextStyle(
            color: Color(0xFF212121),
            fontSize: 28,
            fontFamily: 'Sarabun',
            fontWeight: FontWeight.w700,
            height: 0.05,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.more_horiz_rounded))
        ],
      ),
      body: ListView(
        children: [
          Avatar(src: widget.user?.avatar??'assets/images/avartar.png'),
          const SizedBox(
            height: 10,
          ),
          InfomationAccount(name: widget.user?.fullname??'Username', phone: widget.user?.phoneNumber??'03699999999'),
          const SizedBox(
            height: 40,
          ),
          ItemAccount(
            title: 'Chỉnh sửa thông tin',
            colorr: const Color(0xFF212121),
            iconLeft: const Icon(
              Icons.person_outline,
              size: 35,
            ),
            iconRight: const Icon(
              Icons.chevron_right,
              size: 35,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const EditAccount()),
              );
            },
          ),
          const SizedBox(
            height: 35,
          ),
          ItemAccount(
            title: 'Đổi mật khẩu',
            iconLeft: const Icon(
              Icons.lock_outlined,
              size: 35,
            ),
            iconRight: const Icon(
              Icons.chevron_right,
              size: 35,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const EditPass()),
              );
            },
          ),
          const SizedBox(
            height: 35,
          ),
          ItemAccount(
            title: 'Địa chỉ',
            iconLeft: const Icon(
              Icons.location_on_outlined,
              size: 35,
            ),
            iconRight: const Icon(
              Icons.chevron_right,
              size: 35,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const AddressView(),
                ),
              );
            },
          ),
          const SizedBox(
            height: 35,
          ),
          ItemAccount(
            title: 'Thông báo',
            iconLeft: const Icon(
              Icons.notifications_outlined,
              size: 35,
            ),
            iconRight: const Icon(
              Icons.chevron_right,
              size: 35,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const NotificationPage(),
                ),
              );
            },
          ),
          const SizedBox(
            height: 35,
          ),
          ItemAccount(
            title: 'Đăng xuất',
            colorr: Colors.red,
            iconLeft: const Icon(
              Icons.logout,
              size: 35,
              color: Colors.red,
            ),
            iconRight: null,
            onTap: () {
              _displayBottomSheet(context);
            },
          ),
        ],
      ),
    );
  }
}

Future _displayBottomSheet(BuildContext context) {
  return showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
      builder: (context) => SizedBox(
            height: 220,
            // width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Đăng xuất',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFFF75555),
                    fontSize: 28,
                    fontFamily: 'Sarabun',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Bạn có chắc chắn muốn đăng xuất?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF424242),
                    fontSize: 22,
                    fontFamily: 'Sarabun',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: Row(
                    children: [
                      ButtonLogOut(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          content: 'Đóng',
                          colorr: const Color(0xFFE6F8EF),
                          colorContent: const Color(0xff109C5B)),
                      const SizedBox(
                        width: 15,
                      ),
                      ButtonLogOut(
                          onTap: () {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Login()),
                              (route) => route is Login,
                            );
                          },
                          content: 'Đăng xuất',
                          colorr: const Color(0xff109C5B),
                          colorContent: const Color(0xFFE6F8EF))
                    ],
                  ),
                )
              ],
            ),
          ));
}
