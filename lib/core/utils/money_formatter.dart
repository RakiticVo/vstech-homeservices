import 'package:intl/intl.dart';

/// Display formatting for VND amounts, e.g. `4860000` → `4.860.000đ` (matches the design spec).
abstract final class MoneyFormatter {
  static final NumberFormat _vnd = NumberFormat.currency(locale: 'vi_VN', symbol: 'đ', decimalDigits: 0);

  static String format(num amount) => _vnd.format(amount).replaceAll(RegExp(r'\s'), '');
}
