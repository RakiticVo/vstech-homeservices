// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WalletResponse _$WalletResponseFromJson(Map<String, dynamic> json) =>
    _WalletResponse(
      walletId: const NullableIdConverter().fromJson(json['walletId']),
      ownerId: const NullableIdConverter().fromJson(json['ownerId']),
      balance: const NullableMoneyConverter().fromJson(json['balance']),
      frozenBalance: const NullableMoneyConverter().fromJson(
        json['frozenBalance'],
      ),
      currency: json['currency'] as String?,
      walletType: json['walletType'] as String?,
      createdAt: const NullableUtcDateTimeConverter().fromJson(
        json['createdAt'] as String?,
      ),
    );

Map<String, dynamic> _$WalletResponseToJson(
  _WalletResponse instance,
) => <String, dynamic>{
  'walletId': const NullableIdConverter().toJson(instance.walletId),
  'ownerId': const NullableIdConverter().toJson(instance.ownerId),
  'balance': const NullableMoneyConverter().toJson(instance.balance),
  'frozenBalance': const NullableMoneyConverter().toJson(
    instance.frozenBalance,
  ),
  'currency': instance.currency,
  'walletType': instance.walletType,
  'createdAt': const NullableUtcDateTimeConverter().toJson(instance.createdAt),
};
