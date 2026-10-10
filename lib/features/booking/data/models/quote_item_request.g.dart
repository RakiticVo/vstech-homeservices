// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quote_item_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_QuoteItemRequest _$QuoteItemRequestFromJson(Map<String, dynamic> json) =>
    _QuoteItemRequest(
      itemName: json['itemName'] as String,
      amount: const MoneyConverter().fromJson(json['amount'] as Object),
      receiptUrl: json['receiptUrl'] as String?,
    );

Map<String, dynamic> _$QuoteItemRequestToJson(_QuoteItemRequest instance) =>
    <String, dynamic>{
      'itemName': instance.itemName,
      'amount': const MoneyConverter().toJson(instance.amount),
      'receiptUrl': ?instance.receiptUrl,
    };
