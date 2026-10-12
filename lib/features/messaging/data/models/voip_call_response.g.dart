// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'voip_call_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_VoipCallResponse _$VoipCallResponseFromJson(Map<String, dynamic> json) =>
    _VoipCallResponse(
      id: const IdConverter().fromJson(json['id'] as Object),
      bookingId: const NullableIdConverter().fromJson(json['bookingId']),
      callerId: const NullableIdConverter().fromJson(json['callerId']),
      receiverId: const NullableIdConverter().fromJson(json['receiverId']),
      status: json['status'] as String?,
      durationSeconds: (json['durationSeconds'] as num?)?.toInt(),
      recordingUrl: json['recordingUrl'] as String?,
      startedAt: const NullableUtcDateTimeConverter().fromJson(
        json['startedAt'] as String?,
      ),
      endedAt: const NullableUtcDateTimeConverter().fromJson(
        json['endedAt'] as String?,
      ),
    );

Map<String, dynamic> _$VoipCallResponseToJson(
  _VoipCallResponse instance,
) => <String, dynamic>{
  'id': const IdConverter().toJson(instance.id),
  'bookingId': const NullableIdConverter().toJson(instance.bookingId),
  'callerId': const NullableIdConverter().toJson(instance.callerId),
  'receiverId': const NullableIdConverter().toJson(instance.receiverId),
  'status': instance.status,
  'durationSeconds': instance.durationSeconds,
  'recordingUrl': instance.recordingUrl,
  'startedAt': const NullableUtcDateTimeConverter().toJson(instance.startedAt),
  'endedAt': const NullableUtcDateTimeConverter().toJson(instance.endedAt),
};
