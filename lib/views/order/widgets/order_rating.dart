import 'dart:developer';

import 'package:app_thuong_mai_dien_tu/models/order.dart';
import 'package:app_thuong_mai_dien_tu/models/product.dart';
import 'package:app_thuong_mai_dien_tu/presenters/product_presenter.dart';
import 'package:app_thuong_mai_dien_tu/presenters/review_presenter.dart';
import 'package:app_thuong_mai_dien_tu/resources/app_colors.dart';
import 'package:app_thuong_mai_dien_tu/resources/widgets/my_button.dart';
import 'package:app_thuong_mai_dien_tu/views/order/widgets/rating_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderRating extends StatefulWidget {
  const OrderRating({super.key, required this.order});
  final Order order;

  @override
  State<OrderRating> createState() => _OrderRatingState();
}

class _OrderRatingState extends State<OrderRating> {
  final controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  List<Product> productsUserReviewed = [];
  int? currentDetailID;
  double rating = 5;
  @override
  void initState() {
    currentDetailID = widget.order.orderDetails[0].orderDetailID;

    SharedPreferences.getInstance().then((value) {
      if (mounted) {
        final userID = value.getInt('curUser')!;
        ProductPresenter.instance.getProductByReviewUser(userID).then((value) {
          if (mounted) {
            setState(() {
              productsUserReviewed = value;
            });
          }
        });
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool check = productsUserReviewed
        .map(
          (e) => e.productID,
        )
        .toList()
        .contains(currentDetailID != null
            ? widget.order.orderDetails
                .singleWhere(
                    (element) => element.orderDetailID == currentDetailID)
                .product
                .productID
            : widget.order.orderDetails[0].product.productID);
    log('Kiểm tra: $check');
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
            DropdownButton<int>(
              isExpanded: true,
              value: currentDetailID,
              items: widget.order.orderDetails.map((detail) {
                return DropdownMenuItem<int>(
                  value: detail.orderDetailID,
                  child: Text(detail.product.productName),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  currentDetailID = value!;
                });
              },
            ),
            const SizedBox(height: 12),
            RatingItem(
                detail: currentDetailID != null
                    ? widget.order.orderDetails.singleWhere(
                        (element) => element.orderDetailID == currentDetailID)
                    : widget.order.orderDetails[0]),
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
                        onTap: () async {
                          if (!check) {
                            if (_formKey.currentState!.validate()) {
                              showDialog(
                                  context: context,
                                  builder: (context) => const AlertDialog(
                                        backgroundColor: Colors.transparent,
                                        shadowColor: Colors.transparent,
                                        surfaceTintColor: Colors.transparent,
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 30),
                                        content: SizedBox(
                                          width: 50, // Đặt chiều rộng mong muốn
                                          height: 50, // Đặt chiều cao mong muốn
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              CircularProgressIndicator(
                                                color: AppColor.primaryColor,
                                              ),
                                              // Các phần tử khác nếu cần
                                            ],
                                          ),
                                        ),
                                      ));
                              await ReviewPresenter.instance.addReview(
                                  controller.text,
                                  rating,
                                  1,
                                  widget.order.orderDetails
                                      .singleWhere((element) =>
                                          element.orderDetailID ==
                                          currentDetailID)
                                      .product
                                      .productID);
                              // ignore: use_build_context_synchronously
                              Navigator.pop(context);
                              // ignore: use_build_context_synchronously
                              Navigator.pop(context);
                              // ignore: use_build_context_synchronously
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Đánh giá thành công'),
                                  duration: Duration(seconds: 1),
                                ),
                              );
                            }
                          } else {
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Bạn đã đánh giá sản phẩm này'),
                                duration: Duration(seconds: 1),
                              ),
                            );
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
