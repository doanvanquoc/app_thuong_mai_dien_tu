import 'package:app_thuong_mai_dien_tu/models/history_search.dart';
import 'package:app_thuong_mai_dien_tu/models/notification.dart';
import 'package:app_thuong_mai_dien_tu/views/home/home_view.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(HistoryAdapter()); // Đăng ký adapter
  Hive.registerAdapter(NotificationCKCAdapter()); // Đăng ký adapter
  await Hive.openBox<History>('history');
  await Hive.openBox<NotificationCKC>('notification');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CKCPhoneStore',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          fontFamily: GoogleFonts.sarabun().fontFamily),
      home: const HomePage(),
    );
  }
}
