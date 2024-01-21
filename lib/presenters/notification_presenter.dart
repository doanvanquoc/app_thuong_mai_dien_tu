import 'package:app_thuong_mai_dien_tu/models/notification.dart';
import 'package:hive/hive.dart';

class NotificationPresenter {
  static var notificationBox = Hive.box<NotificationCKC>('notification');

  static void addNotification(
      int iconNumb, DateTime notiDate, String title, String content) {
    final notification = NotificationCKC(
      iconNumb: iconNumb,
      notiDate: notiDate,
      title: title,
      content: content,
    );
    notificationBox.add(notification);
  }

  static List notifications = [];
  static List notificationsReversed = [];

  static void getNotification() {
    notifications = [];
    notificationsReversed = [];
    for (var element in notificationBox.values) {
      notifications.add(element);
    }
    notificationsReversed.addAll(notifications.reversed);
  }
}
