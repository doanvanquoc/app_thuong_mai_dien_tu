import 'package:app_thuong_mai_dien_tu/resources/app_colors.dart';
import 'package:flutter/material.dart';

class OrderTrackingItem extends StatelessWidget {
  const OrderTrackingItem({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Image.network(
              'https://cdn.hoanghamobile.com/i/preview/Uploads/2022/09/08/2222.png',
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 10),
          const Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Iphone 15 Pro Max 8G/ 128GB - VN',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 25),
                Text(
                  'SL: 1',
                  style: TextStyle(
                    color: Colors.black45,
                  ),
                ),
                SizedBox(height: 25),
                Text(
                  '38.000.000đ',
                  style: TextStyle(
                    color: AppColor.primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
