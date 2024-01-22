import 'package:app_thuong_mai_dien_tu/data_sources/push_noti.dart';
import 'package:app_thuong_mai_dien_tu/data_sources/socket.io.dart';
import 'package:app_thuong_mai_dien_tu/firebase_options.dart';
import 'package:app_thuong_mai_dien_tu/models/history_search.dart';
import 'package:app_thuong_mai_dien_tu/models/notification.dart';
import 'package:app_thuong_mai_dien_tu/presenters/notification_service_presenter.dart';
import 'package:app_thuong_mai_dien_tu/presenters/socket_presenter.dart';
import 'package:app_thuong_mai_dien_tu/views/welcome/splash_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

final navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initNotification();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await PushNoti.instance.configNotification();
  await Hive.initFlutter();
  Hive.registerAdapter(HistoryAdapter()); // Đăng ký adapter
  Hive.registerAdapter(NotificationCKCAdapter()); // Đăng ký adapter
  await Hive.openBox<History>('history');
  await Hive.openBox<NotificationCKC>('notification');

  runApp(
    ChangeNotifierProvider(
      create: (context) => SocketPresenter(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SocketManager().init(context);
    return MaterialApp(
      title: 'CKCPhoneStore',
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          fontFamily: GoogleFonts.sarabun().fontFamily),
      home: const SplashScreen(),
    );
  }
}
