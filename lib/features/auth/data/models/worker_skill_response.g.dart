// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'worker_skill_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WorkerSkillResponse _$WorkerSkillResponseFromJson(Map<String, dynamic> json) =>
    _WorkerSkillResponse(
      categoryId: (json['categoryId'] as num?)?.toInt(),
      experienceYears: (json['experienceYears'] as num?)?.toInt(),
      certificateUrl: json['certificateUrl'] as String?,
      isVerified: json['isVerified'] as bool?,
    );

Map<String, dynamic> _$WorkerSkillResponseToJson(
  _WorkerSkillResponse instance,
) => <String, dynamic>{
  'categoryId': instance.categoryId,
  'experienceYears': instance.experienceYears,
  'certificateUrl': instance.certificateUrl,
  'isVerified': instance.isVerified,
};
