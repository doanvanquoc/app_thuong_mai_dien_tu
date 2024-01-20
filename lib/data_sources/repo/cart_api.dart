import 'dart:math';

import 'package:app_thuong_mai_dien_tu/data_sources/api_url.dart';
import 'package:dio/dio.dart';

class CartAPI {
  CartAPI._internal();
  static final CartAPI instanse = CartAPI._internal();

  final dio = Dio();

  Future<Map<String, dynamic>> addToCart(
      {required int userID,
      required int productID,
      required int quanlity}) async {
    try {
      final res = await dio.post(
        '${APIConfig.API_URL}/cart/add',
        data: {
          'userID': userID,
          'productID': productID,
          'quantity': quanlity,
        },
      );
      if (res.statusCode == 200) {
        final resData = res.data;
        if (resData != null && resData.containsKey('code')) {
          if (resData['code'] == 1) {
            return {'succesful': 'Thêm vào giỏ hàng thành công'};
          } else {
            return {'error': 'Lỗi dữ liệu thêm vào giỏ hàng'};
          }
        } else {
          return {'error': 'Lỗi dữ liệu thêm vào giỏ hàng'};
        }
      } else {
        return {'error': 'Thêm vào giỏ hàng thất bại'};
      }
    } catch (e) {
      return {'error': 'Lỗi kết nối'};
    }
  }
}
