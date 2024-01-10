import 'package:flutter/material.dart';

class NotificationItem extends StatefulWidget {
  const NotificationItem({super.key});

  @override
  State<NotificationItem> createState() => _NotificationItemState();
}

class _NotificationItemState extends State<NotificationItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      height: 100,
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ClipOval(
            child: Container(
              height: 68,
              width: 68,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color.fromARGB(255, 61, 225, 154),
                    Color(0xFF01B763)
                  ],
                ),
              ),
              child: const Icon(
                Icons.person,
                color: Colors.white,
              ),
            ),
          ),
          const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Thiết lập tài khoản thành công!",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                "Tài khoản của bạn đã được tạo!",
                style: TextStyle(fontSize: 14),
              ),
            ],
          )
        ],
      ),
    );
  }
}
