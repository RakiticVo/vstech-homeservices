// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_category_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ServiceCategoryResponse _$ServiceCategoryResponseFromJson(
  Map<String, dynamic> json,
) => _ServiceCategoryResponse(
  id: const IdConverter().fromJson(json['id'] as Object),
  name: json['name'] as String,
  description: json['description'] as String?,
  basePrice: const NullableMoneyConverter().fromJson(json['basePrice']),
  commissionRate: const NullableMoneyConverter().fromJson(
    json['commissionRate'],
  ),
  isActive: json['isActive'] as bool?,
  imageUrl: json['imageUrl'] as String?,
);

Map<String, dynamic> _$ServiceCategoryResponseToJson(
  _ServiceCategoryResponse instance,
) => <String, dynamic>{
  'id': const IdConverter().toJson(instance.id),
  'name': instance.name,
  'description': instance.description,
  'basePrice': const NullableMoneyConverter().toJson(instance.basePrice),
  'commissionRate': const NullableMoneyConverter().toJson(
    instance.commissionRate,
  ),
  'isActive': instance.isActive,
  'imageUrl': instance.imageUrl,
};
