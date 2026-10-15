// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tracking_message_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TrackingMessageResponse _$TrackingMessageResponseFromJson(
  Map<String, dynamic> json,
) => _TrackingMessageResponse(
  type: json['type'] as String?,
  status: json['status'] as String?,
  technicianId: const NullableIdConverter().fromJson(json['technicianId']),
  bookingId: const NullableIdConverter().fromJson(json['bookingId']),
  latitude: (json['latitude'] as num?)?.toDouble(),
  longitude: (json['longitude'] as num?)?.toDouble(),
  heading: (json['heading'] as num?)?.toDouble(),
  lastUpdated: const NullableUtcDateTimeConverter().fromJson(
    json['lastUpdated'] as String?,
  ),
  reason: json['reason'] as String?,
  message: json['message'] as String?,
  errorCode: json['errorCode'] as String?,
);

Map<String, dynamic> _$TrackingMessageResponseToJson(
  _TrackingMessageResponse instance,
) => <String, dynamic>{
  'type': instance.type,
  'status': instance.status,
  'technicianId': const NullableIdConverter().toJson(instance.technicianId),
  'bookingId': const NullableIdConverter().toJson(instance.bookingId),
  'latitude': instance.latitude,
  'longitude': instance.longitude,
  'heading': instance.heading,
  'lastUpdated': const NullableUtcDateTimeConverter().toJson(
    instance.lastUpdated,
  ),
  'reason': instance.reason,
  'message': instance.message,
  'errorCode': instance.errorCode,
};
