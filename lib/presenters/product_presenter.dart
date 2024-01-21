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

  Future<List<Product>> getLatestProduct([int? limit]) async {
    try {
      List<Product> products = await api.getLatestProduct(limit);
      return products;
    } catch (e) {
      log(e.toString());
      return [];
    }
  }

  Future<List<Product>> getBestSellingProduct([int? limit]) async {
    try {
      List<Product> products = await api.getBestSellingProduct(limit);
      return products;
    } catch (e) {
      log('Lỗi prod: dòng 37 - $e');
      return [];
    }
  }

  Future<List<Product>> getBestSellingProductByCompanyID(int companyID,
      [int? limit]) async {
    try {
      List<Product> products =
          await api.getBestSellingProductByCompanyID(limit, companyID);
      return products;
    } catch (e) {
      log('Lỗi prod: dòng 47 - $e');
      return [];
    }
  }

  // static void productSearch(
  //     String value, List<Product> lstData, List<Product> lstSearch) {
  //   lstSearch.clear();
  //   for (var element in lstData) {
  //     if (element.productName.toUpperCase().contains(value.toUpperCase())) {
  //       lstSearch.add(element);
  //     }
  //   }
  // }
}
