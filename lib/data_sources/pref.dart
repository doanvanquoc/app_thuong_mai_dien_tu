import 'package:shared_preferences/shared_preferences.dart';

class MyPref {
  static MyPref? _instance;
  late SharedPreferences _preferences;

  MyPref._internal();

  factory MyPref() {
    _instance ??= MyPref._internal();
    return _instance!;
  }

  Future<void> initialize() async {
    _preferences = await SharedPreferences.getInstance();
  }

  // Getter để lấy SharedPreferences
  SharedPreferences get preferences => _preferences;
}
