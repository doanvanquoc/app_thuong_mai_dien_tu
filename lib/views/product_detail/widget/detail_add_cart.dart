import 'package:app_thuong_mai_dien_tu/views/product_detail/widget/detail_change.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AddCartDetail extends StatefulWidget {
  const AddCartDetail({
    super.key,
  });

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
        height: 80,
        color: const Color.fromARGB(255, 255, 255, 255),
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tổng cộng',
                    style: TextStyle(fontSize: 12),
                  ),
                  Text(
                    '35.000.000d',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                showModalBottomSheet(
                    isScrollControlled: true,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadiusDirectional.vertical(
                            top: Radius.circular(40))),
                    context: context,
                    builder: (_) {
                      return const DetailChange();
                    });
              },
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
                    ),
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
