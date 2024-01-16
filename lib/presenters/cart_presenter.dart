import 'dart:developer';

import 'package:app_thuong_mai_dien_tu/data_sources/repo/cart_api.dart';
import 'package:app_thuong_mai_dien_tu/models/cart.dart';

class CartPresenter {
  CartPresenter._internal();
  static final CartPresenter instance = CartPresenter._internal();

  final api = CartAPI.instance;

  Future<List<Cart>> getCartDetails(int userID) async {
    try {
      List<Cart> cartItem = await api.getCartDetailsByUserID(userID);
      return cartItem;
    } catch (e) {
      log(e.toString());
      return [];
    }
  }

  Future<bool> updateQuantity(int productID, int quantity) async {
    try {
      return await api.updateProductQuantity(productID, quantity);
    } catch (e) {
      log(e.toString());
      return false;
    }
  }
}
