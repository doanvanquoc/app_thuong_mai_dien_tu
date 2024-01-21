import 'package:app_thuong_mai_dien_tu/models/user.dart';
import 'package:app_thuong_mai_dien_tu/views/notification/notification_view.dart';
import 'package:flutter/material.dart';

class HomeAppbar extends StatelessWidget {
  const HomeAppbar({super.key,required this.user});
  final User user;
  @override
  Widget build(BuildContext context) {
    print(user);
    return ListTile(
      leading: ClipRRect(
        clipBehavior: Clip.hardEdge,
        borderRadius: BorderRadius.circular(50),
        child: Image.network(user.avatar,
          fit: BoxFit.cover,
        ),
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
              MaterialPageRoute(builder: (_) => const NotificationPage()));
        },
        iconSize: 30,
      ),
    );
  }
}
