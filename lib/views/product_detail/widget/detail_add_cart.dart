import 'package:app_thuong_mai_dien_tu/models/product.dart';
import 'package:app_thuong_mai_dien_tu/resources/app_colors.dart';
import 'package:app_thuong_mai_dien_tu/views/product_detail/widget/detail_change.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class AddCartDetail extends StatefulWidget {
  const AddCartDetail({super.key, required this.product});
  final Product product;

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
        padding: const EdgeInsets.symmetric(horizontal: 20),
        height: 64,
        color: const Color.fromARGB(255, 255, 255, 255),
        width: double.infinity,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Giá bán',
                        style: TextStyle(fontSize: 14),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: Text(
                          NumberFormat.currency(locale: 'vi_VN', symbol: 'VNĐ')
                              .format(widget.product.price),
                          style: const TextStyle(
                              fontSize: 21, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                          isScrollControlled: true,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadiusDirectional.vertical(
                                  top: Radius.circular(40))),
                          context: context,
                          builder: (_) {
                            return DetailChange(
                              product: widget.product,
                            );
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
                              color: AppColor.primaryColor,
                            ),
                          ],
                          borderRadius: BorderRadius.circular(100),
                          color: AppColor.primaryColor),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.shopping_bag_rounded,
                            size: 22,
                            color: Colors.white,
                          ),

                          SizedBox(width: 8),
                          //add cart
                          Text(
                            'Thêm vào giỏ hàng',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
