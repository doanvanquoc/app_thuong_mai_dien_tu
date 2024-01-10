import 'dart:developer';

import 'package:app_thuong_mai_dien_tu/resources/app_colors.dart';
import 'package:app_thuong_mai_dien_tu/resources/widgets/my_button.dart';
import 'package:app_thuong_mai_dien_tu/views/order/widgets/order_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class OrderRating extends StatelessWidget {
  const OrderRating({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          const Text(
            'Đánh giá',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 12),
          const Divider(),
          const SizedBox(height: 12),
          const OrderITem(status: 'Hoàn thành', isShow: false),
          const SizedBox(height: 24),
          const Text(
            'Đơn hàng của bạn như thế nào?',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          const Text('Hãy để lại số sao và đánh giá của bạn nhé!'),
          RatingBar.builder(
            initialRating: 5,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
            itemBuilder: (context, _) => const Icon(
              Icons.star,
              color: AppColor.primaryColor,
            ),
            onRatingUpdate: (rating) {
              log(rating.toString());
            },
          ),
          const SizedBox(height: 10),
          TextField(
            cursorColor: AppColor.primaryColor,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: AppColor.primaryColor),
                borderRadius: BorderRadius.circular(10),
              ),
              hintText: 'Để lại đánh giá của bạn nhé...',
            ),
          ),
          const SizedBox(height: 12),
          const Divider(),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: MyButton(
                  onTap: () => Navigator.pop(context),
                  content: 'Đóng',
                  backgroundColor: const Color(0xffe6f8ef),
                  textColor: AppColor.primaryColor,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(child: MyButton(onTap: () {}, content: 'Gửi đánh giá')),
            ],
          )
        ],
      ),
    );
  }
}
