// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'start_call_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_StartCallRequest _$StartCallRequestFromJson(Map<String, dynamic> json) =>
    _StartCallRequest(
      bookingId: const IdConverter().fromJson(json['bookingId'] as Object),
      callerId: const IdConverter().fromJson(json['callerId'] as Object),
      receiverId: const IdConverter().fromJson(json['receiverId'] as Object),
    );

Map<String, dynamic> _$StartCallRequestToJson(_StartCallRequest instance) =>
    <String, dynamic>{
      'bookingId': const IdConverter().toJson(instance.bookingId),
      'callerId': const IdConverter().toJson(instance.callerId),
      'receiverId': const IdConverter().toJson(instance.receiverId),
    };
