import 'package:intl/intl.dart';

class Product {
  final String image;
  final String name;
  final int price;
  int quantity;

  Product({
    required this.image,
    required this.name,
    required this.price,
    required this.quantity,
  });

  static String formatPrice(int price) {
    final numberFormat = NumberFormat('#,##0', 'vi_VN');
    return '${numberFormat.format(price)}đ';
  }
}
