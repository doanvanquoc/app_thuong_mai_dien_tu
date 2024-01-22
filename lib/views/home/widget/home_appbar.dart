import 'package:app_thuong_mai_dien_tu/models/user.dart';
import 'package:app_thuong_mai_dien_tu/views/notification/notification_view.dart';
import 'package:flutter/material.dart';

class HomeAppbar extends StatelessWidget {
  const HomeAppbar({super.key, required this.user});
  final User user;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: NetworkImage(user.avatar),
              fit: BoxFit.cover,
            )),
      ),
      title: const Text('Welcome,'),
      subtitle: Text(
        user.fullname,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      trailing: IconButton(
        icon: const Icon(Icons.notifications_none),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (_) => NotificationPage(user: user)));
        },
        iconSize: 30,
      ),
    );
  }
}
