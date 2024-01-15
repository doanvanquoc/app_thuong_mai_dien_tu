class Order {
  final int orderID;
  final double totalPrice;
  final DateTime orderDate;
  final int userID;
  Order(
      {required this.orderID,
      required this.totalPrice,
      required this.orderDate,
      required this.userID});

  Order.fromJson(Map<String, dynamic> json)
      : orderID = json['orderID'],
        totalPrice = json['totalPrice'],
        orderDate = json['orderDate'],
        userID = json['userID'];
}
