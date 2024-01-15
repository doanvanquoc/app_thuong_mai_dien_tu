import 'dart:math';

import 'package:app_thuong_mai_dien_tu/models/address.dart';
import 'package:app_thuong_mai_dien_tu/models/product.dart';
import 'package:app_thuong_mai_dien_tu/views/checkout/address_view.dart';
import 'package:app_thuong_mai_dien_tu/views/checkout/widgets/address_widget.dart';
import 'package:app_thuong_mai_dien_tu/views/checkout/widgets/comfirm_widget.dart';
import 'package:app_thuong_mai_dien_tu/views/checkout/widgets/loading.dart';
import 'package:app_thuong_mai_dien_tu/views/checkout/widgets/product_widget.dart';
import 'package:flutter/material.dart';

class CheckoutView extends StatefulWidget {
  const CheckoutView({
    super.key,
    required this.products,
    required this.totalPrice,
  });

  final List<Product> products;
  final int totalPrice;

  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  List<Address> addresses = [
    Address(
      name: 'Nhà',
      street: '65 Huỳnh Thúc Kháng, Quận 1',
      isDefault: true,
    ),
    Address(
      name: 'Công ty',
      street: '652/37 Cộng Hòa, P13, Tân Bình',
      isDefault: false,
    ),
    Address(
      name: 'Trọ',
      street: '231/93/5 Dương Bá Trạc, P1, Quận 8',
      isDefault: false,
    ),
    Address(
      name: 'Một Buổi Sáng',
      street: '27/4 Cộng Hòa, P4, Tân Bình',
      isDefault: false,
    ),
  ];
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

  void clearCart() {
    setState(() {
      widget.products.clear();
    });
  }

  int ship = 123456;

  @override
  void initState() {
    super.initState();
    selectedAddress = Address.getDefaultAddress(addresses);
  }

  @override
  Widget build(BuildContext context) {
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
                  name: selectedAddress!.name,
                  isDefault: selectedAddress!.isDefault!,
                  street: selectedAddress!.street,
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
                      image: 'assets/images/iphone15_3.png',
                      name: 'product.name',
                      price:' Product.formatPrice(product.price',
                      qty : product.quantity,
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
                            Product.formatPrice(widget.totalPrice.toString()).toString(),
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
                            Product.formatPrice(totalBill.toString()).toString(),
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
        onTap: () {
          DateTime now = DateTime.now();
          String formattedDate = formatDate(now);

          String eCode = generateOrderCode();
          openDialog(
            context,
            'Đặt hàng thành công!',
            'Đơn hàng của bạn sẽ sớm được vận chuyển',
            widget.products,
            formattedDate,
            eCode,
            widget.totalPrice,
            ship,
            totalBill,
          );
        },
      ),
    );
  }

  void selectAddress() async {
    final Address? result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddressView(selectedAddress: selectedAddress),
      ),
    );

    if (result != null) {
      setState(() {
        selectedAddress = result;
        if (!addresses.contains(selectedAddress)) {
          addresses.add(selectedAddress!);
        }
      });
    }
  }
}
