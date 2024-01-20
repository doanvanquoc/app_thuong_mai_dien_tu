import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesPresenter {
  static final Future<SharedPreferences> _prefs =
      SharedPreferences.getInstance();

  static Future<void> setCartData(String cartData) async {
    final SharedPreferences prefs = await _prefs;
    await prefs.setString('cartData', cartData);
  }

  static Future<String?> getCartData() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getString('cartData');
  }
}
