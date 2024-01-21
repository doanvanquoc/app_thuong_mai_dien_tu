import 'dart:developer';

import 'package:app_thuong_mai_dien_tu/data_sources/api_url.dart';
import 'package:app_thuong_mai_dien_tu/models/product.dart';
import 'package:dio/dio.dart';

class ProductAPI {
  ProductAPI._internal();
  static final ProductAPI instance = ProductAPI._internal();

  final dio = Dio();

  Future<List<Product>> getLatestProduct(int? limit) async {
    String url;
    if (limit != null) {
      url = '${APIConfig.API_URL}/product/latest?limit=$limit';
    } else {
      url = '${APIConfig.API_URL}/product/latest';
    }
    List<Product> products = [];
    try {
      final res = await dio.get(url);
      products =
          (res.data['data'] as List).map((e) => Product.fromJson(e)).toList();
      return products;
    } catch (e) {
      log('Lỗi product dòng 21: $e');
      return [];
    }
  }

  Future<List<Product>> getBestSellingProduct(int? limit) async {
    String url;
    if (limit != null) {
      url = '${APIConfig.API_URL}/product/best-sell?limit=$limit';
    } else {
      url = '${APIConfig.API_URL}/product/best-sell';
    }
    List<Product> products = [];
    try {
      final res = await dio.get(url);
      products =
          (res.data['data'] as List).map((e) => Product.fromJson(e)).toList();
      return products;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Product>> getBestSellingProductByCompanyID(
      int? limit, int companyID) async {
    String url;
    if (limit != null) {
      url = '${APIConfig.API_URL}/product/best-sell/$companyID?limit=$limit';
    } else {
      url = '${APIConfig.API_URL}/product/best-sell/$companyID';
    }
    List<Product> products = [];
    try {
      final res = await dio.get(url);
      products =
          (res.data['data'] as List).map((e) => Product.fromJson(e)).toList();
      return products;
    } catch (e) {
      rethrow;
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
