import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AddCartDetail extends StatefulWidget {
  AddCartDetail({super.key, required this.total});
  double total;
  @override
  State<AddCartDetail> createState() => _AddCartDetailState();
}

class _AddCartDetailState extends State<AddCartDetail> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      right: 0,
      left: 0,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        height: 65,
        color: const Color.fromARGB(255, 255, 255, 255),
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Tổng cộng',
                    style: TextStyle(fontSize: 12),
                  ),
                  Text(
                    '${widget.total}đ',
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                height: 58,
                width: MediaQuery.of(context).size.width / 2,
                decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                        offset: Offset(1, 2),
                        blurRadius: 8,
                        spreadRadius: 0,
                        color: Color(0xFF01B763),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(100),
                    color: const Color(0xFF01B763)),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.shopping_bag_rounded,
                      size: 22,
                      color: Colors.white,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Thêm vào giỏ hàng',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
