import 'package:app_thuong_mai_dien_tu/models/product.dart';
import 'package:app_thuong_mai_dien_tu/resources/widgets/my_button.dart';
import 'package:app_thuong_mai_dien_tu/views/checkout/checkout_view.dart';
import 'package:flutter/material.dart';

class TotalWidget extends StatelessWidget {
  const TotalWidget({super.key, required this.products});

  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
      clipBehavior: Clip.antiAlias,
      decoration: const ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 0.7,
              strokeAlign: BorderSide.strokeAlignOutside,
              color: Color.fromARGB(255, 229, 228, 228),
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32),
              topRight: Radius.circular(32),
            ),
          ),
          shadows: [
            BoxShadow(
              color: Color(0x0C04060F),
              blurRadius: 60,
              offset: Offset(0, -4),
            )
          ]),
      child: Row(
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Tổng cộng',
                style: TextStyle(
                  color: Color(0xFF757575),
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 6),
              Text(
                '15.000.000đ',
                style: TextStyle(
                  color: Color(0xFF212121),
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(width: 32),
          Expanded(
            child: MyButton(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CheckoutView(products: products)),
                  );
                },
                content: 'Thanh toán'),
          ),
        ],
      ),
    );
  }
}