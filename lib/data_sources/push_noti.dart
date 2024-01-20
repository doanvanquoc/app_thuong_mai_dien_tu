import 'dart:async';
import 'dart:developer';

import 'package:app_thuong_mai_dien_tu/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PushNoti {
  PushNoti._internal();
  static final PushNoti instance = PushNoti._internal();

  //get token
  // Future<String> getToken() async {
  //   log('Get token');
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   String token = pref.getString('fcmToken') ?? '';
  //   log('get token succesful: $token');
  //   return token;
  // }

  //init noti
  Future<void> configNotification() async {
    const channel = AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      description: 'description',
      importance: Importance.max,
    );

    final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    final fcmToken = await FirebaseMessaging.instance.getToken();
    log(fcmToken ?? "");
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('fcmToken', fcmToken!);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channelDescription: channel.description,
                icon: android.smallIcon ?? 'mipmap/ic_launcher',
                // other properties...
              ),
            ));
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      log('onMessageOpenApp: $event');
    });
    FirebaseMessaging.onBackgroundMessage(_fcmMessageBackgroundHandler);
  }
}

Future<void> _fcmMessageBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  print("fcmMessage: $message");
}
