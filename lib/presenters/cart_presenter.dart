import 'dart:developer';

import 'package:app_thuong_mai_dien_tu/data_sources/repo/cart_api.dart';
import 'package:app_thuong_mai_dien_tu/models/product.dart';

class CartPresenter {
  CartPresenter._internal();
  static final CartPresenter instance = CartPresenter._internal();

  final api = CartAPI.instanse;

  Future<Map<String, dynamic>> addToCart(
      {required int userID,
      required int productID,
      required int quanlity}) async {
    try {
      Map<String, dynamic> cart = await api.addToCart(
        userID: userID,
        productID: productID,
        quanlity: quanlity,
      );
      return cart;
    } catch (e) {
      log(e.toString());
      return {};
    }
  }
}
