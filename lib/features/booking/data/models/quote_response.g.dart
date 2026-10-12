// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quote_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_QuoteResponse _$QuoteResponseFromJson(Map<String, dynamic> json) =>
    _QuoteResponse(
      status: json['status'] as String?,
      totalAmount: const NullableMoneyConverter().fromJson(json['totalAmount']),
      submittedAt: const NullableUtcDateTimeConverter().fromJson(
        json['submittedAt'] as String?,
      ),
      createdAt: const NullableUtcDateTimeConverter().fromJson(
        json['createdAt'] as String?,
      ),
    );

Map<String, dynamic> _$QuoteResponseToJson(
  _QuoteResponse instance,
) => <String, dynamic>{
  'status': instance.status,
  'totalAmount': const NullableMoneyConverter().toJson(instance.totalAmount),
  'submittedAt': const NullableUtcDateTimeConverter().toJson(
    instance.submittedAt,
  ),
  'createdAt': const NullableUtcDateTimeConverter().toJson(instance.createdAt),
};
