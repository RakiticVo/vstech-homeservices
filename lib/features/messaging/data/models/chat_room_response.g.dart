// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_room_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ChatRoomResponse _$ChatRoomResponseFromJson(Map<String, dynamic> json) =>
    _ChatRoomResponse(
      id: const IdConverter().fromJson(json['id'] as Object),
      bookingId: const NullableIdConverter().fromJson(json['bookingId']),
      customerId: const NullableIdConverter().fromJson(json['customerId']),
      workerId: const NullableIdConverter().fromJson(json['workerId']),
      status: json['status'] as String?,
    );

Map<String, dynamic> _$ChatRoomResponseToJson(_ChatRoomResponse instance) =>
    <String, dynamic>{
      'id': const IdConverter().toJson(instance.id),
      'bookingId': const NullableIdConverter().toJson(instance.bookingId),
      'customerId': const NullableIdConverter().toJson(instance.customerId),
      'workerId': const NullableIdConverter().toJson(instance.workerId),
      'status': instance.status,
    };
