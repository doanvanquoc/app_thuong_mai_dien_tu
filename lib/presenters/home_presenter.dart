import 'dart:developer';

import 'package:app_thuong_mai_dien_tu/data_sources/repo/product_api.dart';
import 'package:app_thuong_mai_dien_tu/models/product.dart';

class HomePresenter {
  HomePresenter._internal();
  static final HomePresenter instance = HomePresenter._internal();

  final api = ProductAPI.instance;

  Future<List<Product>> getLatestProduct() async {
    try {
      List<Product> products = await api.getLatestProduct();
      return products;
    } catch (e) {
      log(e.toString());
      return [];
    }
  }

  Future<List<Product>> getProductByCompanyID(int id) async {
    try {
      List<Product> products = [];
      if (id == 0) {
        products = await api.getAllProduct();
      } else {
        products = await api.getProductByCompanyID(id);
      }
      return products;
    } catch (e) {
      return [];
    }
  }
}
