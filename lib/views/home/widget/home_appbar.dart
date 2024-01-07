import 'package:flutter/material.dart';

class HomeAppbar extends StatelessWidget {
  const HomeAppbar({super.key});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ClipRRect(
        clipBehavior: Clip.hardEdge,
        borderRadius: BorderRadius.circular(50),
        child: Image.network(
          'https://randomuser.me/api/portraits/men/91.jpg',
          fit: BoxFit.cover,
        ),
      ),
      title: const Text('Chào buổi sáng sớm 👋'),
      subtitle: const Text(
        'Đoàn Văn Quốc',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      trailing: IconButton(
        icon: const Icon(Icons.notifications_none),
        onPressed: () {},
        iconSize: 30,
      ),
    );
  }
}
