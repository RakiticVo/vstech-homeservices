// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserProfileResponse _$UserProfileResponseFromJson(
  Map<String, dynamic> json,
) => _UserProfileResponse(
  id: const IdConverter().fromJson(json['id'] as Object),
  identityId: json['identityId'] as String?,
  email: json['email'] as String?,
  phoneNumber: json['phoneNumber'] as String?,
  fullName: json['fullName'] as String?,
  avatarUrl: json['avatarUrl'] as String?,
  bio: json['bio'] as String?,
  role: json['role'] as String?,
  verificationStatus: json['verificationStatus'] as String?,
  rating: (json['rating'] as num?)?.toDouble(),
  totalJobs: (json['totalJobs'] as num?)?.toInt(),
  locale: json['locale'] as String?,
  isActive: json['isActive'] as bool?,
  createdAt: json['createdAt'] as String?,
  userProfile: json['userProfile'] == null
      ? null
      : UserProfileDetailResponse.fromJson(
          json['userProfile'] as Map<String, dynamic>,
        ),
  workerKyc: json['workerKyc'] == null
      ? null
      : WorkerKycResponse.fromJson(json['workerKyc'] as Map<String, dynamic>),
  workerMetrics: json['workerMetrics'] == null
      ? null
      : WorkerMetricsResponse.fromJson(
          json['workerMetrics'] as Map<String, dynamic>,
        ),
  workerSkills:
      (json['workerSkills'] as List<dynamic>?)
          ?.map((e) => WorkerSkillResponse.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <WorkerSkillResponse>[],
);

Map<String, dynamic> _$UserProfileResponseToJson(
  _UserProfileResponse instance,
) => <String, dynamic>{
  'id': const IdConverter().toJson(instance.id),
  'identityId': instance.identityId,
  'email': instance.email,
  'phoneNumber': instance.phoneNumber,
  'fullName': instance.fullName,
  'avatarUrl': instance.avatarUrl,
  'bio': instance.bio,
  'role': instance.role,
  'verificationStatus': instance.verificationStatus,
  'rating': instance.rating,
  'totalJobs': instance.totalJobs,
  'locale': instance.locale,
  'isActive': instance.isActive,
  'createdAt': instance.createdAt,
  'userProfile': instance.userProfile,
  'workerKyc': instance.workerKyc,
  'workerMetrics': instance.workerMetrics,
  'workerSkills': instance.workerSkills,
};
