// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_booking_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CreateBookingRequest _$CreateBookingRequestFromJson(
  Map<String, dynamic> json,
) => _CreateBookingRequest(
  categoryId: const IdConverter().fromJson(json['categoryId'] as Object),
  description: json['description'] as String,
  addressDetail: json['addressDetail'] as String,
  locationLat: (json['locationLat'] as num).toDouble(),
  locationLng: (json['locationLng'] as num).toDouble(),
  scheduledTime: const UtcDateTimeConverter().fromJson(
    json['scheduledTime'] as String,
  ),
  applianceId: const NullableIdConverter().fromJson(json['applianceId']),
  deviceIp: json['deviceIp'] as String?,
);

Map<String, dynamic> _$CreateBookingRequestToJson(
  _CreateBookingRequest instance,
) => <String, dynamic>{
  'categoryId': const IdConverter().toJson(instance.categoryId),
  'description': instance.description,
  'addressDetail': instance.addressDetail,
  'locationLat': instance.locationLat,
  'locationLng': instance.locationLng,
  'scheduledTime': const UtcDateTimeConverter().toJson(instance.scheduledTime),
  'applianceId': ?const NullableIdConverter().toJson(instance.applianceId),
  'deviceIp': ?instance.deviceIp,
};
