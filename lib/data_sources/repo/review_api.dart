import 'dart:developer';

import 'package:app_thuong_mai_dien_tu/data_sources/api_url.dart';
import 'package:app_thuong_mai_dien_tu/models/review.dart';
import 'package:dio/dio.dart';

class ReviewAPI {
  ReviewAPI._internal();
  static final ReviewAPI instance = ReviewAPI._internal();

  final dio = Dio();
  Future<List<Review>> getReviewByIdProduct(int id) async {
    List<Review> companies = [];
    try {
      final res = await dio.get('${APIConfig.API_URL}/review/$id');
      companies =
          (res.data['data'] as List).map((e) => Review.fromJson(e)).toList();
      return companies;
    } catch (e) {
      log(e.toString());
      return [];
    }
  }
}
