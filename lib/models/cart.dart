import 'package:app_thuong_mai_dien_tu/models/product.dart';

class Cart {
  Cart({
    required this.cartID,
    required this.userID,
    required this.product,
    required this.quantity,
  });

  final int cartID;
  final int? userID;
  final Product product;
  int quantity;

  Cart.fromJson(Map<String, dynamic> json)
      : cartID = json['cartID'] ?? 1,
        userID = json['userID'],
        product = Product.fromJson(json['product'] as Map<String, dynamic>),
        quantity = json['quantity'];

  Map<String, dynamic> toJson() {
    return {
      'cartID': cartID,
      'userID': userID ?? 1,
      'product': product.toJson(),
      'quantity': quantity,
    };
  }
}
