import 'dart:convert';
import 'dart:developer';

import 'package:app_thuong_mai_dien_tu/data_sources/api_url.dart';
import 'package:app_thuong_mai_dien_tu/models/order.dart';
import 'package:dio/dio.dart';

class OrderAPI {
  OrderAPI._internal();
  static final OrderAPI instance = OrderAPI._internal();

  final dio = Dio();

  Future<Order?> createOrder(int userID) async {
    try {
      final res = await dio.post('${APIConfig.API_URL}/order/create',
          data: jsonEncode({'id': userID}));

      if (res.statusCode == 200) {
        log(res.data['order'].toString());
        return Order.fromJson(res.data['order']);
      } else {
        log('Lỗi khi tạo đơn hàng: ${res.statusCode}');
        return null;
      }
    } catch (e) {
      log('Lỗi kết nối: $e');
      return null;
    }
  }
}
