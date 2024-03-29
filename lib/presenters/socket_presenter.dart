import 'dart:developer';

import 'package:app_thuong_mai_dien_tu/data_sources/local/order_local.dart';
import 'package:app_thuong_mai_dien_tu/models/order.dart';
import 'package:app_thuong_mai_dien_tu/presenters/order_presenter.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SocketPresenter extends ChangeNotifier {
  List<Order> orders = [];
  List<Order> orderStatus1 = [];
  List<Order> orderStatus2 = [];
  List<Order> orderStatus3 = [];
  bool isLoading = true;

  void onListenEvent(List<Order> orders, List<Order> orderStatus1,
      List<Order> orderStatus2, List<Order> orderStatus3) {
    this.orders = orders.reversed.toList();
    this.orderStatus1 = orderStatus1.reversed.toList();
    this.orderStatus2 = orderStatus2.reversed.toList();
    this.orderStatus3 = orderStatus3.reversed.toList();
    log('Cập nhật lại order từ server');
    notifyListeners();
  }

  void startLoading() {
    isLoading = true;
    log('start loading: $isLoading');
  }

  void stopLoading() {
    isLoading = false;
    log('stop loading: $isLoading');
    notifyListeners();
  }

  void initData() async {
    startLoading();
    final preUserID = await OrderLocal.instance.getPreUserID();
    final pref = await SharedPreferences.getInstance();
    final curUserID = pref.getInt('curUser');
    log('pre: $preUserID - cur: $curUserID');
    if (preUserID != null && preUserID == curUserID) {
      final value = await OrderLocal.instance.loadListOrderFromLocal();
      if (value == null || value.isEmpty) {
        log('load list form server');
        final orders = await OrderPresenter.instance.getUserOrders(curUserID);
        orderStatus1 = orders
            .where((element) => element.status.statusID == 1)
            .toList()
            .reversed
            .toList();
        orderStatus2 = orders
            .where((element) => element.status.statusID == 2)
            .toList()
            .reversed
            .toList();
        orderStatus3 = orders
            .where((element) => element.status.statusID == 3)
            .toList()
            .reversed
            .toList();
        OrderLocal.instance.saveListOrderToLocal(orders);
      } else {
        orders = value;
        orderStatus1 = orders
            .where((element) => element.status.statusID == 1)
            .toList()
            .reversed
            .toList();
        orderStatus2 = orders
            .where((element) => element.status.statusID == 2)
            .toList()
            .reversed
            .toList();
        orderStatus3 = orders
            .where((element) => element.status.statusID == 3)
            .toList()
            .reversed
            .toList();
      }
    } else {
      final orders = await OrderPresenter.instance.getUserOrders(curUserID);
      orderStatus1 = orders
          .where((element) => element.status.statusID == 1)
          .toList()
          .reversed
          .toList();
      orderStatus2 = orders
          .where((element) => element.status.statusID == 2)
          .toList()
          .reversed
          .toList();
      orderStatus3 = orders
          .where((element) => element.status.statusID == 3)
          .toList()
          .reversed
          .toList();

      OrderLocal.instance.saveListOrderToLocal(orders);
      OrderLocal.instance.savePreUserID(curUserID!);
    }
    stopLoading();
  }
}
