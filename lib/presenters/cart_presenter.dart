import 'dart:developer';

import 'package:app_thuong_mai_dien_tu/data_sources/repo/cart_api.dart';
import 'package:app_thuong_mai_dien_tu/models/cart.dart';
import 'package:dio/dio.dart';

class CartPresenter {
  CartPresenter._internal();
  static final CartPresenter instance = CartPresenter._internal();

  final api = CartAPI.instance;

  Future<List<Cart>> getCartDetails(int userID) async {
    try {
      final a = await api.getCartDetailsByUserID(userID);
      return a;
    } on DioException catch (e) {
      log('pre: Lỗi khi gọi API: ${e.message}');
      return [];
    } catch (e) {
      log(e.toString());
      return [];
    }
  }

  Future<bool> updateCartQuantity(int cartID, int quantity) async {
    try {
      bool isSuccess = await api.updateQuantity(cartID, quantity);
      return isSuccess;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  Future<bool> removeProductFromCart(int productID) async {
    return await api.deleteProductFromCart(productID);
  }

  Future<Map<String, dynamic>> addToCart(
      {required int userID,
      required int productID,
      required int quantity}) async {
    try {
      Map<String, dynamic> cart = await api.addToCart(
        userID: userID,
        productID: productID,
        quantity: quantity,
      );
      return cart;
    } catch (e) {
      log(e.toString());
      return {};
    }
  }
}
