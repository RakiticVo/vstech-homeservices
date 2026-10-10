// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_transaction_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WalletTransactionResponse _$WalletTransactionResponseFromJson(
  Map<String, dynamic> json,
) => _WalletTransactionResponse(
  id: const NullableIdConverter().fromJson(json['id']),
  transactionId: const NullableIdConverter().fromJson(json['transactionId']),
  type: json['type'] as String?,
  txType: json['txType'] as String?,
  amount: const NullableMoneyConverter().fromJson(json['amount']),
  delta: const NullableMoneyConverter().fromJson(json['delta']),
  status: json['status'] as String?,
  description: json['description'] as String?,
  referenceRequestId: const NullableIdConverter().fromJson(
    json['referenceRequestId'],
  ),
  createdAt: const NullableUtcDateTimeConverter().fromJson(
    json['createdAt'] as String?,
  ),
);

Map<String, dynamic> _$WalletTransactionResponseToJson(
  _WalletTransactionResponse instance,
) => <String, dynamic>{
  'id': const NullableIdConverter().toJson(instance.id),
  'transactionId': const NullableIdConverter().toJson(instance.transactionId),
  'type': instance.type,
  'txType': instance.txType,
  'amount': const NullableMoneyConverter().toJson(instance.amount),
  'delta': const NullableMoneyConverter().toJson(instance.delta),
  'status': instance.status,
  'description': instance.description,
  'referenceRequestId': const NullableIdConverter().toJson(
    instance.referenceRequestId,
  ),
  'createdAt': const NullableUtcDateTimeConverter().toJson(instance.createdAt),
};
