import 'package:app_thuong_mai_dien_tu/data_sources/api_url.dart';
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
      print(res.data['review']);
    } catch (e) {
      rethrow;
    }
  }
}
