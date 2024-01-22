import 'dart:developer';

import 'package:app_thuong_mai_dien_tu/data_sources/repo/notification_api.dart';
import 'package:app_thuong_mai_dien_tu/models/notification.dart';
import 'package:hive/hive.dart';

class NotificationPresenter {
  NotificationPresenter._internal();
  static final NotificationPresenter instance =
      NotificationPresenter._internal();

  final api = NotificationAPI.instance;

  Future<List<NotificationCKC>> getNotificationByUserID(int userID) async {
    try {
      List<NotificationCKC> notifications =
          await api.getNotificationByUserID(userID);
      return notifications;
    } catch (e) {
      log(e.toString());
      return [];
    }
  }

  static int userID = 0;

  static Future<void> addNotificationServer(title, content, userID) async {
    try {
      await NotificationAPI.instance.createNotification(title, content, userID);
    } catch (e) {
      log(e.toString());
    }
  }

  static var notificationBox = Hive.box<NotificationCKC>('notification');

  static void addNotification(int notificationID, int userID, String notiDate,
      String title, String content) {
    final notification = NotificationCKC(
      notificationID: notificationID,
      userID: userID,
      notiDate: notiDate,
      title: title,
      content: content,
    );
    notificationBox.add(notification);
  }

  static void addNotificationLocal(List<NotificationCKC> notificationLst) {
    notificationBox.clear();
    for (var element in notificationLst) {
      addNotification(element.notificationID, element.userID, element.notiDate,
          element.title, element.content);
    }
  }

  static List notifications = [];
  static List notificationsReversed = [];

  static void getNotification(int userID) {
    notifications = [];
    notificationsReversed = [];
    for (var element in notificationBox.values) {
      if (userID == element.userID) {
        notifications.add(element);
      }
    }
    notificationsReversed.addAll(notifications.reversed);
  }

  
}
