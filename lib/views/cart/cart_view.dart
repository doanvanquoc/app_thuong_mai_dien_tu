import 'package:app_thuong_mai_dien_tu/models/product.dart';
import 'package:app_thuong_mai_dien_tu/views/cart/widgets/cart_widget.dart';
import 'package:app_thuong_mai_dien_tu/views/cart/widgets/total_widget.dart';
import 'package:flutter/material.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  List<Product> cartProducts = [
    // Product(
    //   image: 'assets/images/image.png',
    //   name: 'Samsung Galaxy S23 Ultra 8G/128GB',
    //   price: '31.900.000đ',
    //   quantity: 1,
    // ),
    // Product(
    //   image: 'assets/images/image.png',
    //   name: 'Samsung Galaxy S23 Ultra 8G/128GB',
    //   price: '31.900.000đ',
    //   quantity: 6,
    // ),
    // Product(
    //   image: 'assets/images/image.png',
    //   name: 'Samsung Galaxy S23 Ultra 8G/128GB',
    //   price: '31.900.000đ',
    //   quantity: 3,
    // ),
    // Product(
    //   image: 'assets/images/image.png',
    //   name: 'Samsung Galaxy S23 Ultra 8G/128GB',
    //   price: '31.900.000đ',
    //   quantity: 9,
    // ),
  ];
  void updateProductQuantity(int index, int newQuantity) {
    // setState(() {
    //   cartProducts[index].quantity = newQuantity;
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        leading: Image.asset(
          'assets/images/vector.png',
          scale: 2,
        ),
        title: const Text(
          'Giỏ hàng',
          style: TextStyle(
            color: Color(0xFF212121),
          ),
        ),
        actions: <Widget>[
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.search,
                size: 35,
              ))
        ],
      ),
      body: cartProducts.isNotEmpty
          ? Stack(children: [
              ListView.builder(
                itemCount: cartProducts.length,
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 85),
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: CartWidget(
                      image: 'assets/images/iphone15_3.png',
                      name: 'cartProducts[index].name',
                      price: 'cartProducts[index].price',
                      qty: 1,
                      onQuantityChanged: (newQuantity) {
                        updateProductQuantity(index, newQuantity);
                      },
                    ),
                  );
                },
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: TotalWidget(products: cartProducts),
              )
            ])
          : Center(
              child: Column(
                children: [
                  const SizedBox(height: 110),
                  Image.asset('assets/images/empty.png'),
                  const SizedBox(height: 40),
                  const Text(
                    'Giỏ hàng của bạn đang trống',
                    style: TextStyle(
                      color: Color(0xFF212121),
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      height: 2.2,
                    ),
                  ),
                  const Text(
                    'Bạn chưa thêm gì cả!',
                    style: TextStyle(
                      color: Color(0xFF212121),
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
