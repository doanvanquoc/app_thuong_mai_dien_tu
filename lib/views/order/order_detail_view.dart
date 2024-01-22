import 'package:app_thuong_mai_dien_tu/models/order.dart';
import 'package:app_thuong_mai_dien_tu/resources/app_colors.dart';
import 'package:app_thuong_mai_dien_tu/resources/widgets/my_button.dart';
import 'package:app_thuong_mai_dien_tu/views/checkout/e_invoice_view.dart';
import 'package:app_thuong_mai_dien_tu/views/order/widgets/order_detail_item.dart';
import 'package:app_thuong_mai_dien_tu/views/product_detail/product_detail_view.dart';
import 'package:flutter/material.dart';

class OrderDetailPage extends StatelessWidget {
  const OrderDetailPage({
    super.key,
    required this.order,
  });
  final Order order;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        title: const Text(
          'Chi tiết đơn hàng',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Mã đơn hàng: ${order.orderID}',
              style: const TextStyle(
                  color: Colors.black54, fontWeight: FontWeight.bold),
            ),
            RichText(
              text: TextSpan(
                  text:
                      'Bạn có tổng cộng ${order.orderDetails.length} sản phẩm trong trạng thái ',
                  style: const TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                  ),
                  children: [
                    TextSpan(
                        text: order.status.status,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColor.primaryColor,
                        ))
                  ]),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: order.orderDetails.length,
                itemBuilder: (_, index) => GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => ProductDetail(
                                  product: order.orderDetails[index].product)));
                    },
                    child: OrderDetailItem(
                        orderDetail: order.orderDetails[index])),
              ),
            ),
            const SizedBox(height: 10),
            MyButton(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => EInvoiceView(ship: 50000, order: order),
                    ),
                  );
                },
                content: 'Xem hóa đơn')
          ],
        ),
      ),
    );
  }
}
