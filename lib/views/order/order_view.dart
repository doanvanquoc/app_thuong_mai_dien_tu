import 'dart:developer';

import 'package:app_thuong_mai_dien_tu/data_sources/local/order_local.dart';
import 'package:app_thuong_mai_dien_tu/models/order.dart';
import 'package:app_thuong_mai_dien_tu/presenters/order_presenter.dart';
import 'package:app_thuong_mai_dien_tu/resources/app_colors.dart';
import 'package:app_thuong_mai_dien_tu/views/order/order_detail_view.dart';
import 'package:app_thuong_mai_dien_tu/views/order/widgets/order_item.dart';
import 'package:app_thuong_mai_dien_tu/views/order/widgets/order_rating.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  late io.Socket socket;
  List<Order> orders = [];
  List<Order> orderStatus1 = [];
  List<Order> orderStatus2 = [];
  List<Order> orderStatus3 = [];
  @override
  void initState() {
    socket = io.io('https://api.vanquoc.id.vn', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });
    socket.on('order_updated', (_) {
      log('Nhận được tín hiệu vũ trụ từ server');
      OrderPresenter.instance.getUserOrders().then((value) => {
            setState(() {
              orders = value;
              orderStatus1 = orders
                  .where((element) => element.status.statusID == 1)
                  .toList();
              orderStatus2 = orders
                  .where((element) => element.status.statusID == 2)
                  .toList();
              orderStatus3 = orders
                  .where((element) => element.status.statusID == 3)
                  .toList();
            }),
            OrderLocal.instance.saveListOrderToLocal(orders)
          });
    });
    socket.connect();
    OrderLocal.instance.loadListOrderFromLocal().then((value) => {
          if (value == null)
            {
              OrderPresenter.instance.getUserOrders().then((value) => {
                    setState(() {
                      orders = value;
                      orderStatus1 = orders
                          .where((element) => element.status.statusID == 1)
                          .toList();
                      orderStatus2 = orders
                          .where((element) => element.status.statusID == 2)
                          .toList();
                      orderStatus3 = orders
                          .where((element) => element.status.statusID == 3)
                          .toList();
                    }),
                    OrderLocal.instance.saveListOrderToLocal(orders)
                  })
            }
          else
            {
              setState(() {
                orders = value;
                orderStatus1 = orders
                    .where((element) => element.status.statusID == 1)
                    .toList();
                orderStatus2 = orders
                    .where((element) => element.status.statusID == 2)
                    .toList();
                orderStatus3 = orders
                    .where((element) => element.status.statusID == 3)
                    .toList();
              })
            }
        });
    super.initState();
  }

  @override
  void dispose() {
    socket.disconnect();
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
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: TabBarView(
            children: [
              ListView.builder(
                itemCount: orderStatus1.length,
                itemBuilder: (context, index) => OrderITem(
                  order: orderStatus1[index],
                  status: 'Chờ xác nhận',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OrderDetailPage(
                          order: orderStatus1[index],
                        ),
                      ),
                    );
                  },
                ),
              ),
              ListView.builder(
                itemCount: orderStatus2.length,
                itemBuilder: (context, index) => OrderITem(
                  order: orderStatus2[index],
                  status: 'Đang giao',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            OrderDetailPage(order: orderStatus2[index]),
                      ),
                    );
                  },
                ),
              ),
              ListView.builder(
                itemCount: orderStatus3.length,
                itemBuilder: (context, index) => OrderITem(
                  order: orderStatus3[index],
                  status: 'Hoàn thành',
                  action: 'Đánh giá',
                  onTap: () => showRating(context, orderStatus3[index]),
                ),
              ),
            ],
          ),
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
