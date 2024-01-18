import 'dart:developer';

import 'package:app_thuong_mai_dien_tu/data_sources/repo/order_api.dart';
import 'package:app_thuong_mai_dien_tu/models/company.dart';
import 'package:app_thuong_mai_dien_tu/models/order.dart';

class OrderPresenter {
  OrderPresenter._internal();
  static final OrderPresenter instance = OrderPresenter._internal();

  final api = OrderAPI.instance;

  Future<List<Order>> getUserOrders() async {
    try {
      List<Order> orders = await api.getUserOrders();
      return orders;
    } catch (e) {
      log(e.toString());
      return [];
    }
  }

}
