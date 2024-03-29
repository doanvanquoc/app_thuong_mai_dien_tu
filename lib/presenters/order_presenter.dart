import 'dart:developer';

import 'package:app_thuong_mai_dien_tu/data_sources/repo/order_api.dart';
import 'package:app_thuong_mai_dien_tu/models/order.dart';

class OrderPresenter {
  OrderPresenter._internal();
  static final OrderPresenter instance = OrderPresenter._internal();

  final api = OrderAPI.instance;

  Future<List<Order>> getUserOrders(userID) async {
    try {
      List<Order> orders = await api.getUserOrders(userID);
      return orders;
    } catch (e) {
      log(e.toString());
      return [];
    }
  }
  Future<Order?> createOrder(int userID) async {
    try {
      Order? order = await api.createOrder(userID);
      return order;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }
}
