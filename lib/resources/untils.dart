import 'package:intl/intl.dart';

class AppUntil {
  static String formatCurrency(int currency) =>
      NumberFormat.currency(locale: 'vi_VN', symbol: 'VNĐ').format(currency);
}
