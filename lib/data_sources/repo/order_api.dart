import 'dart:developer';

import 'package:app_thuong_mai_dien_tu/data_sources/api_url.dart';
import 'package:app_thuong_mai_dien_tu/models/order.dart';
import 'package:dio/dio.dart';

class OrderAPI {
  OrderAPI._internal();
  static final OrderAPI instance = OrderAPI._internal();

  final dio = Dio();

  Future<List<Order>> getUserOrders(userID) async {
    List<Order> orders = [];
    try {
      final res = await dio.get('${APIConfig.API_URL}/order/$userID');
      log('Gọi API get orders: $userID');
      orders =
          (res.data['data'] as List).map((e) => Order.fromJson(e)).toList();

      return orders;
    } catch (e) {
      log('Lỗi order: $e');
      return [];
    }
  }
}
