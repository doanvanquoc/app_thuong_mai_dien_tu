import 'dart:developer';

import 'package:app_thuong_mai_dien_tu/models/product.dart';
import 'package:app_thuong_mai_dien_tu/presenters/cart_presenter.dart';
import 'package:app_thuong_mai_dien_tu/presenters/notification_presenter.dart';
import 'package:app_thuong_mai_dien_tu/resources/app_colors.dart';
import 'package:app_thuong_mai_dien_tu/resources/widgets/my_button.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DetailChange extends StatefulWidget {
  const DetailChange({super.key, required this.product});
  final Product product;
  @override
  State<DetailChange> createState() => _DetailChangeState();
}

class _DetailChangeState extends State<DetailChange> {
  final cartPresenter = CartPresenter.instance;

  int count = 1;
  void incrQ(int productQuanlity) {
    if(mounted){
      setState(() {
      if (count >= productQuanlity) {
        count == productQuanlity;
      } else {
        count++;
      }
    });
    }
  }

  void decrQ() {
    if(mounted){
      setState(() {
      if (widget.product.quantity == 0) {
        count = 0;
        return;
      }
      if (count <= 1) {
        count = 1;
      } else {
        count -= 1;
      }
    });
    }
  }

  @override
  void initState() {
    if (widget.product.quantity == 0) {
      count = 0;
      return;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadiusDirectional.vertical(
          top: Radius.circular(40),
        ),
      ),
      height: 138,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Số lượng",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColor.secondaryColor,
                ),
              ),
              const SizedBox(width: 20),
              Container(
                width: 139,
                height: 48,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: const Color.fromARGB(255, 248, 248, 248),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                        onPressed: () {
                          decrQ();
                        },
                        icon: const Icon(
                          Icons.remove,
                          color: AppColor.primaryColor,
                        )),
                    Text(
                      '$count ',
                      style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppColor.primaryColor),
                    ),
                    IconButton(
                      onPressed: () {
                        incrQ(widget.product.quantity);
                      },
                      icon: const Icon(
                        Icons.add,
                        color: AppColor.primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          MyButton(
              onTap: () async {
                if (widget.product.quantity == 0) {
                  return;
                }
                Map<String, dynamic> result = await cartPresenter.addToCart(
                    userID: NotificationPresenter.userID,
                    productID: widget.product.productID,
                    quantity: count);
                log(result.entries.last.toString());

                NotificationPresenter.addNotificationServer(
                    "Giỏ hàng",
                    "Thêm vào giỏ hàng thành công",
                    NotificationPresenter.userID);
                // NotificationPresenter.notificationBox.clear();
                // ignore: use_build_context_synchronously
                Navigator.pop(context);
              },
              content: "Xác nhận thêm vào giỏ hàng")
        ],
      ),
    );
  }
}
