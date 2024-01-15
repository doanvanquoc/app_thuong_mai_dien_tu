class OrderDetail {
  final int orderDetailID;
  final int orderID;
  final int quantity;
  final int productID;
  final double price;
  OrderDetail(
      {required this.orderDetailID,
      required this.orderID,
      required this.quantity,
      required this.productID,
      required this.price});

  OrderDetail.fromJson(Map<String, dynamic> json)
      : orderDetailID = json['orderDetailID'],
        orderID = json['orderID'],
        quantity = json['quantity'],
        productID = json['productID'],
        price = json['price'];
}
