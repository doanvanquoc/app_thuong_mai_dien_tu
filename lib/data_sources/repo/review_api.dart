import 'package:app_thuong_mai_dien_tu/data_sources/api_url.dart';
import 'dart:developer';

import 'package:app_thuong_mai_dien_tu/models/review.dart';
import 'package:dio/dio.dart';

class ReviewAPI {
  ReviewAPI._internal();
  static final ReviewAPI instance = ReviewAPI._internal();

  final dio = Dio();

  Future<void> createReview(content, rating, userID, productID) async {
    try {
      final res = await dio.post('${APIConfig.API_URL}/review/create', data: {
        'content': content,
        'rating': rating,
        'userID': userID,
        'productID': productID
      });
      log(res.data['review'].toString());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateReview(content, rating, userID, productID) async {
    try {
      final res = await dio.post('${APIConfig.API_URL}/review/update', data: {
        'content': content,
        'rating': rating,
        'userID': userID,
        'productID': productID
      });
      log(res.data['review'].toString());
    } catch (e) {
      rethrow;
    }
  }

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

  Future<Review> getReviewByIdProductAndUserID(int productID, int userID) async {
    Review review;
    try {
      final res = await dio.get('${APIConfig.API_URL}/review/product/$productID/user/$userID');
      review = Review.fromJson(res.data['data']);
      return review;
    } catch (e) {
      rethrow;
    }
  }
}
