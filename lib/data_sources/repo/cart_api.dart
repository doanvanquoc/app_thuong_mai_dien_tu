import 'dart:convert';
import 'dart:developer';

import 'package:app_thuong_mai_dien_tu/data_sources/api_url.dart';
import 'package:app_thuong_mai_dien_tu/models/cart.dart';
import 'package:dio/dio.dart';

class CartAPI {
  CartAPI._internal();
  static final CartAPI instance = CartAPI._internal();

  final dio = Dio();

  Future<List<Cart>> getCartDetailsByUserID(int userID) async {
    try {
      final res = await dio.get('${APIConfig.API_URL}/cart/user/$userID');
      if (res.statusCode == 200 && res.data is List) {
        return (res.data as List).map((e) => Cart.fromJson(e)).toList();
      } else {
        log('Lỗi khi lấy thông tin giỏ hàng: ${res.statusCode}');
        return [];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> updateProductQuantity(int productID, int quantity) async {
    try {
      final res = await dio.put('${APIConfig.API_URL}/product/updateQuantity',
          data: jsonEncode({
            'productID': productID,
            'newQuantity': quantity,
          }));
      if (res.statusCode == 200) {
        return true;
      } else {
        log('Lỗi khi cập nhật số lượng sản phẩm: ${res.statusCode}');
        return false;
      }
    } catch (e) {
      rethrow;
      return false;
    }
  }
}
