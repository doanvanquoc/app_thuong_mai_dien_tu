import 'dart:developer';

import 'package:app_thuong_mai_dien_tu/models/order.dart';
import 'package:app_thuong_mai_dien_tu/presenters/review_presenter.dart';
import 'package:app_thuong_mai_dien_tu/resources/app_colors.dart';
import 'package:app_thuong_mai_dien_tu/resources/widgets/my_button.dart';
import 'package:app_thuong_mai_dien_tu/views/order/widgets/order_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class OrderRating extends StatefulWidget {
  const OrderRating({super.key, required this.order});
  final Order order;

  @override
  State<OrderRating> createState() => _OrderRatingState();
}

class _OrderRatingState extends State<OrderRating> {
  final controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  double rating = 5;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
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
            OrderITem(
              isShow: false,
              order: widget.order,
            ),
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
              onRatingUpdate: (value) {
                rating = value;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: controller,
              cursorColor: AppColor.primaryColor,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: AppColor.primaryColor),
                  borderRadius: BorderRadius.circular(10),
                ),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: AppColor.primaryColor),
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: 'Để lại đánh giá của bạn nhé...',
              ),
              validator: (value) {
                return (value == null || value.isEmpty)
                    ? 'Vui lòng điền đánh giá'
                    : null;
              },
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
                Expanded(
                    child: MyButton(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            ReviewPresenter.instance
                                .addReview(controller.text, rating, 1, widget.order.orderDetails[0].product.productID);
                          }
                        },
                        content: 'Gửi đánh giá')),
              ],
            )
          ],
        ),
      ),
    );
  }
}
