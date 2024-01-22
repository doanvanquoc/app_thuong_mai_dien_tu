import 'dart:developer';

import 'package:app_thuong_mai_dien_tu/data_sources/api_url.dart';
import 'package:app_thuong_mai_dien_tu/models/banner.dart';
import 'package:dio/dio.dart';

class BannerAPI {
  BannerAPI._internal();
  static final BannerAPI instance = BannerAPI._internal();

  final dio = Dio();

  Future<List<Banner>> getBanners() async {
    List<Banner> banners = [];
    try {
      final res = await dio.get('${APIConfig.API_URL}/banners');
      banners =
          (res.data['data'] as List).map((e) => Banner.fromJson(e)).toList();
      return banners;
    } catch (e) {
      log('Lỗi api banners: $e');
      rethrow;
    }
  }
}
