import 'dart:developer';

import 'package:app_thuong_mai_dien_tu/data_sources/local/order_local.dart';
import 'package:app_thuong_mai_dien_tu/models/order.dart';
import 'package:app_thuong_mai_dien_tu/presenters/order_presenter.dart';
import 'package:flutter/material.dart';

class SocketPresenter extends ChangeNotifier {
  List<Order> orders = [];
  List<Order> orderStatus1 = [];
  List<Order> orderStatus2 = [];
  List<Order> orderStatus3 = [];

  void onListenEvent(orders, orderStatus1, orderStatus2, orderStatus3) {
    this.orders = orders;
    this.orderStatus1 = orderStatus1;
    this.orderStatus2 = orderStatus2;
    this.orderStatus3 = orderStatus3;
    log('Có vào đây nha: socket_presenter');
    notifyListeners();
  }

  void initData() async {
    final value = await OrderLocal.instance.loadListOrderFromLocal();
    if (value == null || value.isEmpty) {
      final orders = await OrderPresenter.instance.getUserOrders();
      orderStatus1 =
          orders.where((element) => element.status.statusID == 1).toList();
      orderStatus2 =
          orders.where((element) => element.status.statusID == 2).toList();
      orderStatus3 =
          orders.where((element) => element.status.statusID == 3).toList();

      OrderLocal.instance.saveListOrderToLocal(orders);
    } else {
      orders = value;
      orderStatus1 =
          orders.where((element) => element.status.statusID == 1).toList();
      orderStatus2 =
          orders.where((element) => element.status.statusID == 2).toList();
      orderStatus3 =
          orders.where((element) => element.status.statusID == 3).toList();
    }
    notifyListeners();
  }
}