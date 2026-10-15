// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tracking_subscribe_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TrackingSubscribeRequest _$TrackingSubscribeRequestFromJson(
  Map<String, dynamic> json,
) => _TrackingSubscribeRequest(
  bookingId: const IdConverter().fromJson(json['bookingId'] as Object),
  action: json['action'] as String? ?? 'SUBSCRIBE',
);

Map<String, dynamic> _$TrackingSubscribeRequestToJson(
  _TrackingSubscribeRequest instance,
) => <String, dynamic>{
  'bookingId': const IdConverter().toJson(instance.bookingId),
  'action': instance.action,
};
