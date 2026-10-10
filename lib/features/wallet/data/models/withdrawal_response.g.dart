// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'withdrawal_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WithdrawalResponse _$WithdrawalResponseFromJson(Map<String, dynamic> json) =>
    _WithdrawalResponse(
      id: const NullableIdConverter().fromJson(json['id']),
      requestId: const NullableIdConverter().fromJson(json['requestId']),
      amount: const NullableMoneyConverter().fromJson(json['amount']),
      bankCode: json['bankCode'] as String?,
      bankAccountNumber: json['bankAccountNumber'] as String?,
      status: json['status'] as String?,
      reason: json['reason'] as String?,
      rejectionReason: json['rejectionReason'] as String?,
      createdAt: const NullableUtcDateTimeConverter().fromJson(
        json['createdAt'] as String?,
      ),
      updatedAt: const NullableUtcDateTimeConverter().fromJson(
        json['updatedAt'] as String?,
      ),
    );

Map<String, dynamic> _$WithdrawalResponseToJson(
  _WithdrawalResponse instance,
) => <String, dynamic>{
  'id': const NullableIdConverter().toJson(instance.id),
  'requestId': const NullableIdConverter().toJson(instance.requestId),
  'amount': const NullableMoneyConverter().toJson(instance.amount),
  'bankCode': instance.bankCode,
  'bankAccountNumber': instance.bankAccountNumber,
  'status': instance.status,
  'reason': instance.reason,
  'rejectionReason': instance.rejectionReason,
  'createdAt': const NullableUtcDateTimeConverter().toJson(instance.createdAt),
  'updatedAt': const NullableUtcDateTimeConverter().toJson(instance.updatedAt),
};
