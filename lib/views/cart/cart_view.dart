import 'package:app_thuong_mai_dien_tu/views/cart/widgets/cart_widget.dart';
import 'package:app_thuong_mai_dien_tu/views/cart/widgets/total_widget.dart';
import 'package:flutter/material.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  int count = 10;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: Image.asset(
          'assets/images/vector.png',
          scale: 2,
        ),
        title: const Text(
          'Giỏ hàng',
          style: TextStyle(
            color: Color(0xFF212121),
            fontSize: 24,
            fontWeight: FontWeight.w700,
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
      body: count != 0
          ? Stack(children: [
              ListView.builder(
                itemCount: count,
                padding: const EdgeInsets.all(20),
                itemBuilder: (BuildContext context, int index) {
                  return const Padding(
                    padding: EdgeInsets.only(bottom: 24),
                    child: CartWidget(
                      image: 'assets/images/image.png',
                      name: 'Samsung Galaxy S23 Ultra 8G/128GB',
                      price: '31.900.000đ',
                    ),
                  );
                },
              ),
              const Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: TotalWidget(),
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
