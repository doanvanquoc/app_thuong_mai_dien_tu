import 'package:app_thuong_mai_dien_tu/models/order_detail.dart';
import 'package:app_thuong_mai_dien_tu/models/status.dart';

class Order {
  final int orderID;
  final int totalPrice;
  final String orderDate;
  final int userID;
  final Status status;
  final List<OrderDetail> orderDetails;

  Order.fromJson(Map<String, dynamic> json)
      : orderID = json['orderID'],
        totalPrice = json['total_price'],
        orderDate = json['order_date'],
        userID = json['userID'],
        status = Status.fromJson(json['status']),
        orderDetails = List.from(
            (json['orderDetails'] as List).map((e) => OrderDetail.fromJson(e)));

  Map<String, dynamic> toJson() {
    return {
      'orderID': orderID,
      'total_price': totalPrice,
      'order_date': orderDate,
      'userID': userID,
      'status': status.toJson(),
      'orderDetails': orderDetails.map((e) => e.toJson()).toList(),
    };
  }
}
