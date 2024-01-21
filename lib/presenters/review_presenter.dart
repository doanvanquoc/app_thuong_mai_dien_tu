import 'dart:developer';

import 'package:app_thuong_mai_dien_tu/data_sources/repo/review_api.dart';

class ReviewPresenter {
  ReviewPresenter._internal();
  static final ReviewPresenter instance = ReviewPresenter._internal();

  Future<void> addReview(content, rating, userID, productID) async {
    try {
      await ReviewAPI.instance.createReview(content, rating, userID, productID);
    } catch (e) {
      log(e.toString());
    }
  }
}
