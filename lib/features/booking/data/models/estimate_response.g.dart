// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'estimate_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EstimateResponse _$EstimateResponseFromJson(Map<String, dynamic> json) =>
    _EstimateResponse(
      estimatedPrice: const MoneyConverter().fromJson(
        json['estimatedPrice'] as Object,
      ),
      categoryId: const NullableIdConverter().fromJson(json['categoryId']),
      categoryName: json['categoryName'] as String?,
      commissionFee: const NullableMoneyConverter().fromJson(
        json['commissionFee'],
      ),
      totalEstimated: const NullableMoneyConverter().fromJson(
        json['totalEstimated'],
      ),
    );

Map<String, dynamic> _$EstimateResponseToJson(_EstimateResponse instance) =>
    <String, dynamic>{
      'estimatedPrice': const MoneyConverter().toJson(instance.estimatedPrice),
      'categoryId': const NullableIdConverter().toJson(instance.categoryId),
      'categoryName': instance.categoryName,
      'commissionFee': const NullableMoneyConverter().toJson(
        instance.commissionFee,
      ),
      'totalEstimated': const NullableMoneyConverter().toJson(
        instance.totalEstimated,
      ),
    };
