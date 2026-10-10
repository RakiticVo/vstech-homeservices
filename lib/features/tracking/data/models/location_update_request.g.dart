// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_update_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LocationUpdateRequest _$LocationUpdateRequestFromJson(
  Map<String, dynamic> json,
) => _LocationUpdateRequest(
  latitude: (json['latitude'] as num).toDouble(),
  longitude: (json['longitude'] as num).toDouble(),
);

Map<String, dynamic> _$LocationUpdateRequestToJson(
  _LocationUpdateRequest instance,
) => <String, dynamic>{
  'latitude': instance.latitude,
  'longitude': instance.longitude,
};
