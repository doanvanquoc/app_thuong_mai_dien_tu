import 'dart:developer';

import 'package:app_thuong_mai_dien_tu/data_sources/repo/product_api.dart';
import 'package:app_thuong_mai_dien_tu/models/product.dart';

class ProductPresenter {
  ProductPresenter._internal();
  static final ProductPresenter instance = ProductPresenter._internal();

  final api = ProductAPI.instance;

  Future<List<Product>> getAllProduct() async {
    try {
      List<Product> products = await api.getAllProduct();
      return products;
    } catch (e) {
      log(e.toString());
      return [];
    }
  }

  Future<List<Product>> getLatestProduct() async {
    try {
      List<Product> products = await api.getLatestProduct();
      return products;
    } catch (e) {
      log(e.toString());
      return [];
    }
  }
}
