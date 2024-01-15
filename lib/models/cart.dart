class Cart {
  final int cartID;
  final int userID;
  final int productID;
  final int quantity;
  Cart(
    this.userID,
    this.productID,
    this.quantity, {
    required this.cartID,
  });

  Cart.fromJson(Map<String, dynamic> json)
      : cartID = json['cartID'],
        userID = json['userID'],
        productID = json['productID'],
        quantity = json['quantity'];
}
