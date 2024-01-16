import 'dart:developer';

import 'package:app_thuong_mai_dien_tu/data_sources/repo/review_api.dart';
import 'package:app_thuong_mai_dien_tu/models/review.dart';

class ReviewPresenter {
  ReviewPresenter._internal();
  static final ReviewPresenter instanse = ReviewPresenter._internal();

  final api = ReviewAPI.instance;

  Future<List<Review>> getReviewByIdProduct(int id) async {
    try {
      List<Review> reviews = await api.getReviewByIdProduct(id);
      return reviews;
    } catch (e) {
      log(e.toString());
      return [];
    }
  }
}
