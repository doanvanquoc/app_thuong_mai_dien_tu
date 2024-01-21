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
      final res = await dio.get('${APIConfig.API_URL}/cart/$userID');
      if (res.statusCode == 200 && res.data['data'] is List) {
        log(res.data['data'][0]['product'].toString());
        return (res.data['data'] as List).map((e) {
          return Cart.fromJson(e);
        }).toList();
      } else {
        log('Lỗi khi lấy thông tin giỏ hàng: ${res.statusCode}');
        return [];
      }
    } on DioException catch (e) {
      log('api: Lỗi khi gọi API: ${e.message}');
      return [];
    } catch (e) {
      return [];
    }
  }

  Future<bool> updateQuantity(int cartID, int quantity) async {
    try {
      final response = await dio.post(
        '${APIConfig.API_URL}/cart/update',
        data: jsonEncode({'cartID': cartID, 'quantity': quantity}),
      );
      if (response.statusCode == 200 && response.data['code'] == 1) {
        return true;
      } else {
        log('Cập nhật thất bại: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      log('Lỗi kết nối: $e');
      return false;
    }
  }

  Future<bool> deleteProductFromCart(int productID) async {
    try {
      final response = await dio.delete('${APIConfig.API_URL}/cart/$productID');
      if (response.data['code'] == 1) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  Future<Map<String, dynamic>> addToCart(
      {required int userID,
      required int productID,
      required int quantity}) async {
    try {
      final res = await dio.post(
        '${APIConfig.API_URL}/cart/add',
        data: {
          'userID': userID,
          'productID': productID,
          'quantity': quantity,
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
