import 'package:app_thuong_mai_dien_tu/models/cart.dart';
import 'package:app_thuong_mai_dien_tu/models/product.dart';
import 'package:app_thuong_mai_dien_tu/views/checkout/widgets/prod_of_e_invoice_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EInvoiceView extends StatelessWidget {
  const EInvoiceView({
    super.key,
    required this.cartProducts,
    required this.orderDateTime,
    required this.eCode,
    required this.ship,
    required this.totalPrice,
    required this.totalBill,
  });

  final List<Cart> cartProducts;
  final String orderDateTime;
  final String eCode;
  final int ship;
  final int totalPrice;
  final int totalBill;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        title: const Text(
          'Hóa đơn điện tử',
          style: TextStyle(
            color: Color(0xFF212121),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 24,
            left: 24,
            right: 24,
            bottom: 48,
          ),
          child: Column(
            children: [
              ListView.builder(
                itemCount: cartProducts.length,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  Cart product = cartProducts[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: ProductOfInvoiceWidget(
                      image: product.product.images[0].imagePath,
                      name: product.product.productName,
                      qty: product.quantity.toString(),
                    ),
                  );
                },
              ),
              Container(
                height: 174,
                padding: const EdgeInsets.all(24),
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
                            Product.formatPrice(totalPrice.toString()),
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
                      const SizedBox(height: 10),
                      const Divider(),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            'Tổng cộng',
                            style: TextStyle(
                              color: Color(0xFF34C582),
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const Expanded(child: SizedBox()),
                          Text(
                            Product.formatPrice(totalBill.toString()),
                            textAlign: TextAlign.right,
                            style: const TextStyle(
                              color: Color(0xFF34C582),
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          )
                        ],
                      ),
                    ]),
              ),
              const SizedBox(height: 20),
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
                      const Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Phương thức thanh toán',
                            style: TextStyle(
                              color: Color(0xFF616161),
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Expanded(child: SizedBox()),
                          Text(
                            'COD',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: Color(0xFF424242),
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            'Ngày',
                            style: TextStyle(
                              color: Color(0xFF616161),
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const Expanded(child: SizedBox()),
                          Text(
                            orderDateTime,
                            textAlign: TextAlign.right,
                            style: const TextStyle(
                              color: Color(0xFF424242),
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            'Mã đơn hàng',
                            style: TextStyle(
                              color: Color(0xFF616161),
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const Expanded(child: SizedBox()),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                eCode,
                                textAlign: TextAlign.right,
                                style: const TextStyle(
                                  color: Color(0xFF424242),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(width: 8),
                              IconButton(
                                icon: const Icon(Icons.file_copy_outlined),
                                onPressed: () {
                                  Clipboard.setData(ClipboardData(text: eCode))
                                      .then((_) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.6,
                                          child: const Text(
                                              'Mã đơn hàng đã được sao chép!'),
                                        ),
                                        behavior: SnackBarBehavior.floating,
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 24),
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(4.0)),
                                        ),
                                      ),
                                    );
                                  });
                                },
                                color: const Color(0xFF34C582),
                              ),
                            ],
                          )
                        ],
                      ),
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // String generateOrderCode() {
  //   const letters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  //   Random random = Random();

  //   String letterPart = String.fromCharCodes(Iterable.generate(
  //       2, (_) => letters.codeUnitAt(random.nextInt(letters.length))));

  //   String numberPart =
  //       Iterable.generate(10, (_) => random.nextInt(10).toString()).join('');

  //   return letterPart + numberPart;
  // }
}
