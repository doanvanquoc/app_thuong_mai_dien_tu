// ignore_for_file: use_build_context_synchronously

import 'dart:math';

import 'package:app_thuong_mai_dien_tu/data_sources/socket.io.dart';
import 'package:app_thuong_mai_dien_tu/models/address.dart';
import 'package:app_thuong_mai_dien_tu/models/cart.dart';
import 'package:app_thuong_mai_dien_tu/models/product.dart';
import 'package:app_thuong_mai_dien_tu/models/user.dart';
import 'package:app_thuong_mai_dien_tu/presenters/address_presenter.dart';
import 'package:app_thuong_mai_dien_tu/presenters/order_presenter.dart';
import 'package:app_thuong_mai_dien_tu/views/checkout/address_view.dart';
import 'package:app_thuong_mai_dien_tu/views/checkout/widgets/address_widget.dart';
import 'package:app_thuong_mai_dien_tu/views/checkout/widgets/comfirm_widget.dart';
import 'package:app_thuong_mai_dien_tu/views/checkout/widgets/loading.dart';
import 'package:app_thuong_mai_dien_tu/views/checkout/widgets/product_widget.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckoutView extends StatefulWidget {
  const CheckoutView({
    super.key,
    required this.products,
    required this.totalPrice, required this.user,
  });

  final List<Cart> products;
  final int totalPrice; 
  final User user;

  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  List<Address> addresses = [];
  Address? selectedAddress;

  String formatDate(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year} | ${dateTime.hour}:${dateTime.minute}:${dateTime.second} ${dateTime.hour >= 12 ? 'PM' : 'AM'}';
  }

  String generateOrderCode() {
    const letters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    Random random = Random();

    String letter = String.fromCharCodes(Iterable.generate(
        2, (_) => letters.codeUnitAt(random.nextInt(letters.length))));

    String number =
        Iterable.generate(10, (_) => random.nextInt(10).toString()).join('');

    return letter + number;
  }

  int ship = 123456;

  @override
  void initState() {
    super.initState();
    loadAddresses().then((loadedAddresses) {
      setState(() {
        addresses = loadedAddresses;
        selectedAddress = Address.getDefaultAddress(addresses);
      });
    });
  }

  Future<List<Address>> loadAddresses() async {
    return await AddressPresenter.instance.getUserAddresses(1);
  }

  void selectAddress() async {
    final Address? result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => AddressView(selectedAddress: selectedAddress)),
    );

    if (result != null) {
      setState(() {
        selectedAddress = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    //int totalPriceParse = int.parse(widget.totalPrice);
    int totalBill = widget.totalPrice + ship;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        title: const Text(
          'Đặt hàng',
          style: TextStyle(
            color: Color(0xFF212121),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 10, 24, 15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Địa chỉ giao hàng',
                style: TextStyle(
                  color: Color(0xFF212121),
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 24),
              if (selectedAddress != null)
                AddressItem(
                  addressID: selectedAddress!.addressID!,
                  isDefault: selectedAddress!.isDefault,
                  address: selectedAddress!.address,
                  isIcon: true,
                  isRadioButton: false,
                  onSelected: () {
                    selectAddress();
                  },
                ),
              const SizedBox(height: 18),
              const Divider(),
              const Text(
                'Danh sách sản phẩm',
                style: TextStyle(
                  color: Color(0xFF212121),
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 5),
              ListView.builder(
                itemCount: widget.products.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  final product = widget.products[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: ProductWidget(
                      image: product.product.images[0].imagePath,
                      name: product.product.productName,
                      price:
                          Product.formatPrice(product.product.price.toString()),
                      qty: product.quantity,
                    ),
                  );
                },
              ),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  shadows: const [
                    BoxShadow(
                      color: Color(0x0C04060F),
                      blurRadius: 60,
                      offset: Offset(0, 4),
                      spreadRadius: 0,
                    )
                  ],
                ),
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            'Giá',
                            style: TextStyle(
                              color: Color(0xFF616161),
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const Expanded(child: SizedBox()),
                          Text(
                            Product.formatPrice(widget.totalPrice.toString()),
                            textAlign: TextAlign.right,
                            style: const TextStyle(
                              color: Color(0xFF424242),
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            'Phí giao hàng',
                            style: TextStyle(
                              color: Color(0xFF616161),
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const Expanded(child: SizedBox()),
                          Text(
                            Product.formatPrice(ship.toString()),
                            textAlign: TextAlign.right,
                            style: const TextStyle(
                              color: Color(0xFF424242),
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 20),
                      const Divider(),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            'Tổng',
                            style: TextStyle(
                              color: Color(0xFF34C582),
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const Expanded(child: SizedBox()),
                          Text(
                            Product.formatPrice(totalBill.toString()),
                            textAlign: TextAlign.right,
                            style: const TextStyle(
                              color: Color(0xFF34C582),
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        ],
                      ),
                    ]),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: ComfirmWidget(
        content: 'Đặt hàng',
        onTap: () async {
          // DateTime now = DateTime.now();
          // String formattedDate = formatDate(now);
          // String eCode = generateOrderCode();
          final pref = await SharedPreferences.getInstance();
          int userID = pref.getInt('curUser')!;
          final order = await OrderPresenter.instance.createOrder(userID);
          print('Log ktra socket: $userID');
          if (order != null) {
            SocketManager().emitEvent('add_order', userID);
            openDialog(
              context,
              'Đặt hàng thành công!',
              'Đơn hàng của bạn sẽ sớm được vận chuyển',
              widget.products,
              formatDate(DateTime.now()),
              order.orderID.toString(),
              ship,
              widget.totalPrice,
              totalBill,
              widget.user
            );
          } else {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(44),
                ),
                content: Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Lottie.asset(
                        'assets/animations/error.json',
                        width: 180,
                        height: 180,
                        frameRate: FrameRate(100),
                      ),
                      const SizedBox(height: 32),
                      const Text(
                        'Đặt hàng thất bại',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF212121),
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Có lỗi trong quá trình đặt hàng. Vui lòng thử lại sau ít phút!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF212121),
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
