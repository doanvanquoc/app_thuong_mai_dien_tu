import 'dart:developer';

import 'package:app_thuong_mai_dien_tu/data_sources/api_url.dart';
import 'package:app_thuong_mai_dien_tu/models/product.dart';
import 'package:dio/dio.dart';

class ProductAPI {
  ProductAPI._internal();
  static final ProductAPI instance = ProductAPI._internal();

  final dio = Dio();

  Future<List<Product>> getLatestProduct() async {
    List<Product> products = [];
    try {
      final res = await dio.get('${APIConfig.API_URL}/product/latest');
      products =
          (res.data['data'] as List).map((e) => Product.fromJson(e)).toList();
      return products;
    } catch (e) {
      log('Lỗi product dòng 21: $e');
      return [];
    }
  }

  Future<List<Product>> getProductByCompanyID(int id) async {
    List<Product> products = [];
    try {
      final res = await dio.get('${APIConfig.API_URL}/product/$id');
      products =
          (res.data['data'] as List).map((e) => Product.fromJson(e)).toList();
      return products;
    } catch (e) {
      log('Lỗi product dòng 34: $e');
      return [];
    }
  }

  Future<List<Product>> getAllProduct() async {
    List<Product> products = [];
    try {
      final res = await dio.get('${APIConfig.API_URL}/product/all');
      products =
          (res.data['data'] as List).map((e) => Product.fromJson(e)).toList();
      return products;
    } catch (e) {
      log('Lỗi product dòng 47: $e');
      return [];
    }
  }
}

