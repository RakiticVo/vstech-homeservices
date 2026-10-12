// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'end_call_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EndCallRequest _$EndCallRequestFromJson(Map<String, dynamic> json) =>
    _EndCallRequest(
      callId: const IdConverter().fromJson(json['callId'] as Object),
      durationSeconds: (json['durationSeconds'] as num).toInt(),
      recordingUrl: json['recordingUrl'] as String?,
    );

Map<String, dynamic> _$EndCallRequestToJson(_EndCallRequest instance) =>
    <String, dynamic>{
      'callId': const IdConverter().toJson(instance.callId),
      'durationSeconds': instance.durationSeconds,
      'recordingUrl': ?instance.recordingUrl,
    };
