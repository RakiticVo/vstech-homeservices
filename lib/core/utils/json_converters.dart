import 'package:json_annotation/json_annotation.dart';

/// Money arrives as an unformatted numeric string (`"200000"`) per the API foundation doc, but the
/// OpenAPI spec types it as `number` — accept both. Sent back as a number.
class MoneyConverter implements JsonConverter<num, Object> {
  const MoneyConverter();

  @override
  num fromJson(Object json) => json is num ? json : num.parse(json as String);

  @override
  Object toJson(num object) => object;
}

class NullableMoneyConverter implements JsonConverter<num?, Object?> {
  const NullableMoneyConverter();

  @override
  num? fromJson(Object? json) => json == null ? null : const MoneyConverter().fromJson(json);

  @override
  Object? toJson(num? object) => object;
}

/// API timestamps are ISO-8601 with offset/`Z`; kept in UTC inside models, converted to local
/// time only when displayed.
class UtcDateTimeConverter implements JsonConverter<DateTime, String> {
  const UtcDateTimeConverter();

  @override
  DateTime fromJson(String json) => DateTime.parse(json).toUtc();

  @override
  String toJson(DateTime object) => object.toUtc().toIso8601String();
}

class NullableUtcDateTimeConverter implements JsonConverter<DateTime?, String?> {
  const NullableUtcDateTimeConverter();

  @override
  DateTime? fromJson(String? json) => json == null ? null : DateTime.parse(json).toUtc();

  @override
  String? toJson(DateTime? object) => object?.toUtc().toIso8601String();
}
