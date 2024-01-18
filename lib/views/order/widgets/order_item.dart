import 'package:app_thuong_mai_dien_tu/models/order.dart';
import 'package:app_thuong_mai_dien_tu/resources/app_colors.dart';
import 'package:flutter/material.dart';

class OrderITem extends StatelessWidget {
  const OrderITem(
      {super.key,
      required this.status,
      this.isShow = true,
      this.onTap,
      this.action = 'Theo dõi',
      required this.order});
  final Function()? onTap;
  final String status;
  final bool isShow;
  final String action;
  final Order order;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white54,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Image.network(
              order.orderDetails[0].product.images[0].imagePath,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  order.orderDetails[0].product.productName,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                Text(
                  'SL: ${order.orderDetails[0].quantity}',
                  style: const TextStyle(
                    color: Colors.black45,
                  ),
                ),
                Chip(
                  label: Text(status),
                  backgroundColor: AppColor.primaryColor.withOpacity(0.2),
                  labelStyle: const TextStyle(
                    color: AppColor.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.all(2),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      order.orderDetails[0].product.price.toString(),
                      style: const TextStyle(
                        color: AppColor.primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    isShow
                        ? GestureDetector(
                            onTap: onTap,
                            child: Chip(
                              label: Text(action),
                              backgroundColor: AppColor.primaryColor,
                              labelStyle: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              shape: RoundedRectangleBorder(
                                side:
                                    const BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: const EdgeInsets.all(0),
                            ),
                          )
                        : const SizedBox.shrink()
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
