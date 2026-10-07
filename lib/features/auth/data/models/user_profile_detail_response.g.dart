// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile_detail_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserProfileDetailResponse _$UserProfileDetailResponseFromJson(
  Map<String, dynamic> json,
) => _UserProfileDetailResponse(
  defaultAddress: json['defaultAddress'] as String?,
  lat: (json['lat'] as num?)?.toDouble(),
  lng: (json['lng'] as num?)?.toDouble(),
);

Map<String, dynamic> _$UserProfileDetailResponseToJson(
  _UserProfileDetailResponse instance,
) => <String, dynamic>{
  'defaultAddress': instance.defaultAddress,
  'lat': instance.lat,
  'lng': instance.lng,
};
