import 'package:app_thuong_mai_dien_tu/models/order.dart';
import 'package:app_thuong_mai_dien_tu/presenters/socket_presenter.dart';
import 'package:app_thuong_mai_dien_tu/resources/app_colors.dart';
import 'package:app_thuong_mai_dien_tu/resources/widgets/empty_view.dart';
import 'package:app_thuong_mai_dien_tu/views/order/order_detail_view.dart';
import 'package:app_thuong_mai_dien_tu/views/order/widgets/order_item.dart';
import 'package:app_thuong_mai_dien_tu/views/order/widgets/order_rating.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  List<Order> orders = [];
  List<Order> orderStatus1 = [];
  List<Order> orderStatus2 = [];
  List<Order> orderStatus3 = [];

  @override
  void initState() {
    super.initState();
    context.read<SocketPresenter>().initData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Đơn hàng',
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const FaIcon(
                FontAwesomeIcons.magnifyingGlass,
                color: Colors.grey,
              ),
            ),
          ],
          bottom: const TabBar(
            tabs: [
              Text('Chờ xác nhận'),
              Text('Đang giao'),
              Text('Hoàn thành'),
            ],
            indicatorColor: AppColor.primaryColor,
            unselectedLabelColor: Colors.grey,
            labelStyle: TextStyle(fontWeight: FontWeight.bold),
            labelColor: AppColor.primaryColor,
          ),
        ),
        body: Consumer<SocketPresenter>(
          builder: (context, socketPresenter, child) {
            return socketPresenter.isLoading
                ? const Center(
                    child:
                        CircularProgressIndicator(color: AppColor.primaryColor),
                  )
                : Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: TabBarView(
                      children: [
                        socketPresenter.orderStatus1.isNotEmpty
                            ? ListView.builder(
                                itemCount: socketPresenter.orderStatus1.length,
                                itemBuilder: (context, index) => OrderITem(
                                  order: socketPresenter.orderStatus1[index],
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => OrderDetailPage(
                                          order: socketPresenter
                                              .orderStatus1[index],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              )
                            : const EmptyView(
                                text1: 'Đơn hàng chờ xác nhận trống',
                                text2:
                                    'Bạn không có đơn hàng nào trong danh sách chờ xác nhận'),
                        socketPresenter.orderStatus2.isNotEmpty
                            ? ListView.builder(
                                itemCount: socketPresenter.orderStatus2.length,
                                itemBuilder: (context, index) => OrderITem(
                                  order: socketPresenter.orderStatus2[index],
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => OrderDetailPage(
                                            order: socketPresenter
                                                .orderStatus2[index]),
                                      ),
                                    );
                                  },
                                ),
                              )
                            : const EmptyView(
                                text1: 'Đơn hàng đang giao đang trống',
                                text2: 'Bạn chưa có đơn hàng nào đang giao cả'),
                        socketPresenter.orderStatus3.isNotEmpty
                            ? ListView.builder(
                                itemCount: socketPresenter.orderStatus3.length,
                                itemBuilder: (context, index) => OrderITem(
                                  order: socketPresenter.orderStatus3[index],
                                  action: 'Đánh giá',
                                  onTap: () => showRating(context,
                                      socketPresenter.orderStatus3[index]),
                                ),
                              )
                            : const EmptyView(
                                text1: 'Đơn hàng hoàn thành của bạn đang trống',
                                text2:
                                    'Bạn không có đơn hàng nào đã hoàn thành cả'),
                      ],
                    ),
                  );
          },
        ),
      ),
    );
  }

  void showRating(BuildContext context, Order order) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => Container(
        // height: MediaQuery.of(context).size.height * 0.75,
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Wrap(
          children: [
            OrderRating(
              order: order,
            )
          ],
        ),
      ),
    );
  }
}
