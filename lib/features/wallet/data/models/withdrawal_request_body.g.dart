// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'withdrawal_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WithdrawalRequestBody _$WithdrawalRequestBodyFromJson(
  Map<String, dynamic> json,
) => _WithdrawalRequestBody(
  amount: const MoneyConverter().fromJson(json['amount'] as Object),
  bankCode: json['bankCode'] as String,
  bankAccountNumber: json['bankAccountNumber'] as String,
);

Map<String, dynamic> _$WithdrawalRequestBodyToJson(
  _WithdrawalRequestBody instance,
) => <String, dynamic>{
  'amount': const MoneyConverter().toJson(instance.amount),
  'bankCode': instance.bankCode,
  'bankAccountNumber': instance.bankAccountNumber,
};
