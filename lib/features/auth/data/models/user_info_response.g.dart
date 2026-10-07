// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserInfoResponse _$UserInfoResponseFromJson(Map<String, dynamic> json) =>
    _UserInfoResponse(
      id: (json['id'] as num).toInt(),
      identityId: json['identityId'] as String?,
      email: json['email'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      fullName: json['fullName'] as String?,
      role: json['role'] as String?,
      avatarUrl: json['avatarUrl'] as String?,
    );

Map<String, dynamic> _$UserInfoResponseToJson(_UserInfoResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'identityId': instance.identityId,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'fullName': instance.fullName,
      'role': instance.role,
      'avatarUrl': instance.avatarUrl,
    };
