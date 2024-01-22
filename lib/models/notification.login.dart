import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationLogin {
  final FlutterLocalNotificationsPlugin notificationsPlugin = FlutterLocalNotificationsPlugin();
  final AndroidInitializationSettings initializationSettingsAndroid = const AndroidInitializationSettings('logo');

  void initialNotification() async {
    InitializationSettings initializationSettings = InitializationSettings(android: initializationSettingsAndroid);
    await notificationsPlugin.initialize(initializationSettings);
  }

  void showNotification() async {
    AndroidNotificationDetails androidNotificationDetails = const AndroidNotificationDetails(
      "channelId",
      "channelName",
      importance: Importance.max,
      priority: Priority.max,
    );

    NotificationDetails notificationDetails = NotificationDetails(android: androidNotificationDetails);

    try {
      await notificationsPlugin.show(
        0,
        'Thông báo',
        'Đăng nhập thành công!',
        notificationDetails,
      );
    } catch (e) {
      print('Lỗi khi hiển thị thông báo: $e');
    }
  }
}
