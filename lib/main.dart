import 'package:app_thuong_mai_dien_tu/views/account/acccount_view.dart';
import 'package:app_thuong_mai_dien_tu/views/register/accountInfomation_view.dart';
import 'package:app_thuong_mai_dien_tu/views/welcome/splash_view.dart';
import 'package:app_thuong_mai_dien_tu/views/welcome/welcome_view.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CKCPhoneStore',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  const AccountInformation()
      // Container(),
    );
  }
}
