import 'package:flutter/material.dart';

class RateContent extends StatefulWidget {
  const RateContent({super.key});

  @override
  State<RateContent> createState() => _RateContentState();
}

class _RateContentState extends State<RateContent> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12 + 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Row(
              children: [
                SizedBox(
                  height: 48,
                  width: 48,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                      'https://randomuser.me/api/portraits/men/15.jpg',
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Text(
                  "Avatar",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(right: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(width: 2, color: const Color(0xFF01B763)),
                borderRadius: BorderRadius.circular(100),
              ),
              height: 32,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.star,
                    size: 20,
                    color: Color(0xFF01B763),
                  ),
                  Text(
                    '5',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF01B763),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        const Text(
          'Sắn sale được cái Iphone 15 giá chỉ có 10k mà thôi, Shop 5 sao!',
          style: TextStyle(fontSize: 12),
        ),
        const SizedBox(height: 12),
        const Text("1 ngày trước")
      ],
    );
  }
}
