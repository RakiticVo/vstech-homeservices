// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'estimate_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EstimateRequest _$EstimateRequestFromJson(Map<String, dynamic> json) =>
    _EstimateRequest(
      categoryId: const IdConverter().fromJson(json['categoryId'] as Object),
      description: json['description'] as String,
    );

Map<String, dynamic> _$EstimateRequestToJson(_EstimateRequest instance) =>
    <String, dynamic>{
      'categoryId': const IdConverter().toJson(instance.categoryId),
      'description': instance.description,
    };
