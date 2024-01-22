import 'dart:developer';
import 'dart:io';

import 'package:app_thuong_mai_dien_tu/data_sources/repo/user_api.dart';
import 'package:app_thuong_mai_dien_tu/models/user.dart';
import 'package:app_thuong_mai_dien_tu/nav_bar.dart';
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
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class Account extends StatefulWidget {
  Account({super.key, required this.user});
  User user;

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  File? selectedImage;

  Future<void> updateUserAvatar(File? image) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(
                color: Colors.green,
              ),
              SizedBox(height: 10),
              Text('Đang cập nhật ảnh đại diện...'),
            ],
          ),
        );
      },
    );

    try {
      final UserAPI userApi = UserAPI.instance;
      final result = await userApi.updateUser(
        userId: widget.user.userID,
        email: null,
        fullname: null,
        birthday: null,
        phoneNumber: null,
        sex: null,
        avatar: image,
      );

      if (result.containsKey('code') && result['code'] == 1) {
        final token = result['token'];

        // Lưu token vào local
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('auth_token', token);
        prefs.setBool('is_logged_out', false);

        Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
        log('line 82: $decodedToken');

        widget.user = User.fromJson(decodedToken['user']);
        // ignore: use_build_context_synchronously
        Navigator.maybePop(context);
        Future.delayed(Duration.zero, () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (_) => MyNavBar(user: widget.user, index: 3),
            ),
            (route) => false,
          );
        });
      }
    } finally {
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset('assets/images/logo.png'),
        title: const Text(
          'Tài khoản',
          style: TextStyle(
            color: Color(0xFF212121),
            fontFamily: 'Sarabun',
          ),
        ),
      ),
      body: ListView(
        children: [
          Avatar(
            src: widget.user.avatar == ''
                ? 'https://res.cloudinary.com/dxe8ykmrn/image/upload/v1705375410/user-avatar/tgaudfhwukm4c6gm0zzy.jpg'
                : widget.user.avatar,
            onImageSelected: (File? image) {
              if(mounted){
                setState(() async {
                updateUserAvatar(image);
              });
              }
            },
          ),
          const SizedBox(
            height: 10,
          ),
          InfomationAccount(
            name:
                widget.user.fullname == '' ? 'Username' : widget.user.fullname,
            phone: widget.user.phoneNumber,
          ),
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
                MaterialPageRoute(
                  builder: (context) => EditAccount(user: widget.user),
                ),
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
                MaterialPageRoute(
                  builder: (context) => EditPass(
                    user: widget.user,
                  ),
                ),
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
                  builder: (_) =>  NotificationPage(user: widget.user),
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

  Future _displayBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      builder: (context) => SizedBox(
        height: 220,
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
                fontFamily: 'Sarabun',
                fontSize: 16,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Row(
                children: [
                  ButtonLogOut(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    content: 'Đóng',
                    colorr: const Color(0xFFE6F8EF),
                    colorContent: const Color(0xff109C5B),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  ButtonLogOut(
                    onTap: () async {
                      await logout();
                      // ignore: use_build_context_synchronously
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Login(),
                        ),
                        (route) => route is Login,
                      );
                    },
                    content: 'Đăng xuất',
                    colorr: const Color(0xff109C5B),
                    colorContent: const Color(0xFFE6F8EF),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('auth_token');
    prefs.setBool('is_logged_out', true);
  }
}
