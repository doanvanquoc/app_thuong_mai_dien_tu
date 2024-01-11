import 'package:app_thuong_mai_dien_tu/models/product.dart';
import 'package:app_thuong_mai_dien_tu/resources/widgets/my_button.dart';
import 'package:app_thuong_mai_dien_tu/views/checkout/e_invoice_view.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

Future openDialog(BuildContext context, String title, String detail,
    List<Product> products, String formatDate, String eCode) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(44),
      ),
      content: Container(
        padding: const EdgeInsets.all(20),
        height: 511,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
            const SizedBox(height: 32),
            Expanded(
                child: MyButton(onTap: () {}, content: 'Theo dõi đơn hàng')),
            const SizedBox(height: 20),
            Expanded(
              child: MyButton(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => EInvoiceView(
                      products: products,
                      orderDateTime: formatDate,
                      eCode: eCode,
                    ),
                  ));
                },
                content: 'Xem hóa đơn điện tử',
                backgroundColor: const Color(0xffE6F8EF),
                textColor: const Color(0xff01B763),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
