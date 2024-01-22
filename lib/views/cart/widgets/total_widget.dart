// ignore_for_file: use_build_context_synchronously

import 'package:app_thuong_mai_dien_tu/models/cart.dart';
import 'package:app_thuong_mai_dien_tu/models/product.dart';
import 'package:app_thuong_mai_dien_tu/models/user.dart';
import 'package:app_thuong_mai_dien_tu/resources/widgets/my_button.dart';
import 'package:app_thuong_mai_dien_tu/views/checkout/checkout_view.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TotalWidget extends StatelessWidget {
  TotalWidget({
    super.key,
    this.products,
    required this.totalPrice,
    required this.user,
  });

  List<Cart>? products;
  final String totalPrice;
  final User user;

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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Tổng cộng',
                style: TextStyle(
                  color: Color(0xFF757575),
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                totalPrice.toString(),
                style: const TextStyle(
                  color: Color(0xFF212121),
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(width: 15),
          Expanded(
            child: MyButton(
                onTap: () async {
                  var connectivityResult =
                      await (Connectivity().checkConnectivity());
                  if (connectivityResult != ConnectivityResult.none) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CheckoutView(
                                user: user,
                                products: products!,
                                totalPrice: Product.parsePrice(totalPrice),
                              )),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Lỗi kết nối'),
                      backgroundColor: Colors.red,
                      behavior: SnackBarBehavior.floating,
                      margin:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4.0)),
                      ),
                    ));
                  }
                },
                content: 'Đặt hàng'),
          ),
        ],
      ),
    );
  }
}
