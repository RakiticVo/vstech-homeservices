import 'package:flutter_test/flutter_test.dart';
import 'package:vstech_home_services/core/utils/json_converters.dart';
import 'package:vstech_home_services/core/utils/money_formatter.dart';

void main() {
  group('MoneyConverter', () {
    test('accepts numeric strings and numbers', () {
      expect(const MoneyConverter().fromJson('200000'), 200000);
      expect(const MoneyConverter().fromJson(150000.5), 150000.5);
      expect(const NullableMoneyConverter().fromJson(null), isNull);
    });
  });

  group('UtcDateTimeConverter', () {
    test('normalizes offsets to UTC', () {
      final value = const UtcDateTimeConverter().fromJson('2026-08-11T17:30:00+07:00');
      expect(value.isUtc, isTrue);
      expect(value, DateTime.utc(2026, 8, 11, 10, 30));
      expect(const NullableUtcDateTimeConverter().fromJson(null), isNull);
    });
  });

  test('MoneyFormatter formats VND without spaces', () {
    expect(MoneyFormatter.format(4860000), '4.860.000đ');
    expect(MoneyFormatter.format(0), '0đ');
  });
}
