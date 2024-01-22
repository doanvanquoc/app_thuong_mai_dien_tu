import 'package:app_thuong_mai_dien_tu/data_sources/api_url.dart';
import 'package:app_thuong_mai_dien_tu/models/noti.dart';
import 'package:dio/dio.dart';

class NotificationAPI {
  NotificationAPI._internal();
  static final NotificationAPI instance = NotificationAPI._internal();

  final dio = Dio();

  Future<Noti> addNoti(String title, String content, int userID) async {
    Noti notification;
    try {
      final res = await dio.post('${APIConfig.API_URL}/notification/add',
          data: {'title': title, 'content': content, 'userID': userID});
      notification = Noti.fromJson(res.data['data']);
      return notification;
    } catch (e) {
      rethrow;
    }
  }
}
