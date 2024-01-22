import 'dart:developer';

import 'package:app_thuong_mai_dien_tu/data_sources/repo/review_api.dart';
import 'package:app_thuong_mai_dien_tu/models/product.dart';
import 'package:app_thuong_mai_dien_tu/models/review.dart';

class ReviewPresenter {
  ReviewPresenter._internal();
  static final ReviewPresenter instance = ReviewPresenter._internal();

  final api = ReviewAPI.instance;

  Future<void> addReview(content, rating, userID, productID) async {
    try {
      await ReviewAPI.instance.createReview(content, rating, userID, productID);
    } catch (e) {
      log(e.toString());
    }
  }

  Future<List<Review>> getReviewByIdProduct(int id) async {
    try {
      List<Review> reviews = await api.getReviewByIdProduct(id);
      return reviews;
    } catch (e) {
      log(e.toString());
      return [];
    }
  }

  static double avgRating(List<Review> lst) {
    if (lst.isEmpty) return 0;
    double total = 0;
    double avg = 0;
    for (var element in lst) {
      total += element.rating;
    }
    avg = total / lst.length;
    return avg;
  }

  static String converDate(String dateString) {
    DateTime dateTime = DateTime.parse(dateString);
    // Lấy ngày hiện tại
    DateTime currentDate = DateTime.now();
    if (dateTime.year != currentDate.year) return dateString;
    if (dateTime.month != currentDate.month) return dateString;
    if (dateTime.day == currentDate.day) return "Hôm nay";
    if (currentDate.day - 1 == dateTime.day) return "1 Ngày trước";
    if (currentDate.day - 2 == dateTime.day) return "2 Ngày trước";
    return dateString;
  }

  Future<bool> getProductStar(Product product, String star) async {
    try {
      List<Review> reviews = await getReviewByIdProduct(product.productID);

      if (ReviewPresenter.avgRating(reviews).toStringAsFixed(0).toString() ==
          star) {
        print("object");
        return true;
      }
      return false;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }
  //  Future<List<Product>> getProductStar(
  //     List<Product> proAll, String star, int categoryID) async {
  //   List<Product> pro = [];
  //   List<Review> reviews = [];
  //   try {
  //     for (var element in proAll) {
  //       await getReviewByIdProduct(element.productID).then((value) {
  //         reviews = value;
  //         if (ReviewPresenter.avgRating(reviews).toStringAsFixed(0) == star) {
  //           pro.add(element);
  //           log(element.toString());
  //         }
  //       });
  //     }
  //     return pro;
  //   } catch (e) {
  //     log(e.toString());
  //     return [];
  //   }
  // }
}
