class Product {
  final String image;
  final String name;
  final description; //mô tả bên chi tiết
  final String price;
  int quantity;

  Product(
      {required this.image,
      required this.name,
      required this.description,
      required this.price,
      required this.quantity});
}
