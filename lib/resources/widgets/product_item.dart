import 'package:app_thuong_mai_dien_tu/models/product.dart';
import 'package:app_thuong_mai_dien_tu/resources/app_colors.dart';
import 'package:app_thuong_mai_dien_tu/views/home/widget/home_add_to_cart.dart';
import 'package:app_thuong_mai_dien_tu/views/product_detail/product_detail_view.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key, required this.product});
  final Product product;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context, MaterialPageRoute(builder: (_) => const ProductDetail())),
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.only(right: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 150,
              alignment: Alignment.center,
              child: Image.network(
                product.images[0].imagePath,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              product.productName,
              style: const TextStyle(fontWeight: FontWeight.bold),
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
                  const SizedBox(width: 5),
                  const Text('|'),
                  const SizedBox(width: 5),
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
            Text(
              NumberFormat.currency(locale: 'vi_VN', symbol: 'VND')
                  .format(product.price),
              style: const TextStyle(
                fontSize: 16,
                color: AppColor.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const HomeAddToCart(),
          ],
        ),
      ),
    );
  }
}
