// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile_update_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserProfileUpdateRequest _$UserProfileUpdateRequestFromJson(
  Map<String, dynamic> json,
) => _UserProfileUpdateRequest(
  fullName: json['fullName'] as String?,
  avatarUrl: json['avatarUrl'] as String?,
  bio: json['bio'] as String?,
  locale: json['locale'] as String?,
  phoneNumber: json['phoneNumber'] as String?,
  email: json['email'] as String?,
  defaultAddress: json['defaultAddress'] as String?,
  lat: (json['lat'] as num?)?.toDouble(),
  lng: (json['lng'] as num?)?.toDouble(),
  idCardFrontUrl: json['idCardFrontUrl'] as String?,
  idCardBackUrl: json['idCardBackUrl'] as String?,
);

Map<String, dynamic> _$UserProfileUpdateRequestToJson(
  _UserProfileUpdateRequest instance,
) => <String, dynamic>{
  'fullName': ?instance.fullName,
  'avatarUrl': ?instance.avatarUrl,
  'bio': ?instance.bio,
  'locale': ?instance.locale,
  'phoneNumber': ?instance.phoneNumber,
  'email': ?instance.email,
  'defaultAddress': ?instance.defaultAddress,
  'lat': ?instance.lat,
  'lng': ?instance.lng,
  'idCardFrontUrl': ?instance.idCardFrontUrl,
  'idCardBackUrl': ?instance.idCardBackUrl,
};
