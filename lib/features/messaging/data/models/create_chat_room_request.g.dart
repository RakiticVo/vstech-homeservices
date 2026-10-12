// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_chat_room_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CreateChatRoomRequest _$CreateChatRoomRequestFromJson(
  Map<String, dynamic> json,
) => _CreateChatRoomRequest(
  bookingId: const IdConverter().fromJson(json['bookingId'] as Object),
);

Map<String, dynamic> _$CreateChatRoomRequestToJson(
  _CreateChatRoomRequest instance,
) => <String, dynamic>{
  'bookingId': const IdConverter().toJson(instance.bookingId),
};
