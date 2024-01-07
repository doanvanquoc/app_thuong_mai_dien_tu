import 'package:app_thuong_mai_dien_tu/resources/app_colors.dart';
import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key, required this.product});
  final String product;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 5),
      width: MediaQuery.of(context).size.width / 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              height: 200,
              child: Image.network(
                product,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 15),
          const Text(
            'Iphone 15 Pro Max 8G/ 128GB - VN',
            style: TextStyle(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Row(
              children: [
                const Icon(
                  Icons.star_border,
                  color: AppColor.primaryColor,
                ),
                const Text('4.5'),
                const SizedBox(width: 10),
                const Text('|'),
                const SizedBox(width: 10),
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColor.primaryColor),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    '3000 đã bán',
                    style: TextStyle(color: AppColor.primaryColor),
                  ),
                )
              ],
            ),
          ),
          const Text(
            '32.900.000đ',
            style: TextStyle(
              fontSize: 20,
              color: AppColor.primaryColor,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}
