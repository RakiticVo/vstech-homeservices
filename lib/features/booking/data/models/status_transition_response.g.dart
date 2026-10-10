// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'status_transition_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_StatusTransitionResponse _$StatusTransitionResponseFromJson(
  Map<String, dynamic> json,
) => _StatusTransitionResponse(
  requestId: const NullableIdConverter().fromJson(json['requestId']),
  previousStatus: json['previousStatus'] as String?,
  newStatus: json['newStatus'] as String?,
  timestamp: const NullableUtcDateTimeConverter().fromJson(
    json['timestamp'] as String?,
  ),
);

Map<String, dynamic> _$StatusTransitionResponseToJson(
  _StatusTransitionResponse instance,
) => <String, dynamic>{
  'requestId': const NullableIdConverter().toJson(instance.requestId),
  'previousStatus': instance.previousStatus,
  'newStatus': instance.newStatus,
  'timestamp': const NullableUtcDateTimeConverter().toJson(instance.timestamp),
};
