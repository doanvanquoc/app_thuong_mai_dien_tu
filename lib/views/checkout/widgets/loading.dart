import 'package:app_thuong_mai_dien_tu/models/cart.dart';
import 'package:app_thuong_mai_dien_tu/models/order_detail.dart';
import 'package:app_thuong_mai_dien_tu/models/user.dart';
import 'package:app_thuong_mai_dien_tu/nav_bar.dart';
import 'package:app_thuong_mai_dien_tu/resources/widgets/my_button.dart';
import 'package:app_thuong_mai_dien_tu/views/checkout/e_invoice_view.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

Future openDialog(
  BuildContext context,
  String title,
  String detail,
  List<OrderDetail> orderDetails,
  String formatDate,
  int ship,
  String eCode,
  int totalPrice,
  int totalBill,
  User user,
) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(44),
      ),
      content: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Lottie.asset(
              'assets/animations/headerIcon.json',
              width: 180,
              height: 180,
              frameRate: FrameRate(100),
            ),
            const SizedBox(height: 32),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFF212121),
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              detail,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFF212121),
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 20),
            MyButton(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (_) => MyNavBar(
                        user: user,
                        index: 2,
                      ),
                    ),
                    (router) => false,
                  );
                },
                content: 'Theo dõi đơn hàng'),
            const SizedBox(height: 20),
            MyButton(
              onTap: () async {
                Navigator.pop(context);
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => EInvoiceView(
                      orderDetails: orderDetails,
                      orderDateTime: formatDate,
                      eCode: eCode,
                      ship: ship,
                      totalPrice: totalPrice,
                      totalBill: totalBill,
                    ),
                  ),
                );
              },
              content: 'Xem thông tin hóa đơn',
              backgroundColor: const Color(0xffE6F8EF),
              textColor: const Color(0xff01B763),
            ),
          ],
        ),
      ),
    ),
  );
}
