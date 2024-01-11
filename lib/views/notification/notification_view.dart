import 'package:app_thuong_mai_dien_tu/views/notification/widgets/notification_item.dart';
import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  List lstNotifications = [
    '2024-01-08 21:52:23.546415',
    'Thiết lập tài khoản thành công!',
    'Tài khoản của bạn đã được tạo!'
  ];

  int countDate(DateTime value) {
    DateTime now = DateTime.now();
    if (now.day == value.day && now.month == value.month) {
      return 0;
    } else {
      return now.day - value.day;
    }
  }

  @override
  Widget build(BuildContext context) {
    // print(countDate(DateTime.parse(lstNotifications[0])));
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 252, 252, 252),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        title: const Text(
          "Thông báo",
          style: TextStyle(fontSize: 24),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Hôm nay",
              style: TextStyle(fontSize: 18),
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: 20,
                itemBuilder: (_, index) {
                  return const NotificationItem();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
