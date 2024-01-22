import 'dart:developer';

import 'package:app_thuong_mai_dien_tu/data_sources/repo/notification_api.dart';
import 'package:app_thuong_mai_dien_tu/models/noti.dart';

class NotiPresenter {
  NotiPresenter._internal();
  static final NotiPresenter instance = NotiPresenter._internal();

  Future<Noti> addNoti(String title, String content, int userID) async {
    try {
      final noti =
          await NotificationAPI.instance.addNoti(title, content, userID);
      return noti;
    } catch (e) {
      log('${e}Lỗi noti api');
      return Noti(1, 'Lỗi', 'Lỗi APi', DateTime.now().toString(), 1);
    }
  }
}
