import 'package:app_thuong_mai_dien_tu/data_sources/push_noti.dart';
import 'package:app_thuong_mai_dien_tu/data_sources/socket.io.dart';
import 'package:app_thuong_mai_dien_tu/firebase_options.dart';
import 'package:app_thuong_mai_dien_tu/presenters/socket_presenter.dart';
import 'package:app_thuong_mai_dien_tu/views/welcome/splash_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

final navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await PushNoti.instance.configNotification();

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
