import 'package:app_thuong_mai_dien_tu/models/product.dart';
class OrderDetail {
  final int orderDetailID;
  final int quantity;
  final Product product;

  OrderDetail.fromJson(Map<String, dynamic> json)
      : orderDetailID = json['orderDetailID'],
        quantity = json['quantity'],
        product = Product.fromJson(json['product']);

        Map<String, dynamic> toJson() {
    return {
      'orderDetailID': orderDetailID,
      
      'quantity': quantity,
      'product': product.toJson(),
    };
  }
}
