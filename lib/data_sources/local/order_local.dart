import 'dart:convert';
import 'dart:developer';

import 'package:app_thuong_mai_dien_tu/models/order.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderLocal {
  OrderLocal._internal();
  static final OrderLocal instance = OrderLocal._internal();

  Future<void> savePreUserID(int userID) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setInt('preUser', userID);
  }

  Future<int?> getPreUserID() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final userID = pref.getInt('preUser');
    return userID;
  }

  Future<void> saveListOrderToLocal(List<Order> orders) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    List<String> ordersJson =
        orders.map((e) => jsonEncode(e.toJson())).toList();
    await pref.setStringList('orders', ordersJson);
  }

  Future<List<Order>?> loadListOrderFromLocal() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    List<String>? ordersJson = pref.getStringList('orders');
    List<Order> orders = [];
    log('Log ỏ trong local nè');
    if (ordersJson != null) {
      for (String orderJson in ordersJson) {
        Map<String, dynamic> orderMap = jsonDecode(orderJson);
        orders.add(Order.fromJson(orderMap));
      }
      return orders;
    }
    return null;
  }
}
