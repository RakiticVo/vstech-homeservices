// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_message_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ChatMessageResponse _$ChatMessageResponseFromJson(Map<String, dynamic> json) =>
    _ChatMessageResponse(
      id: const IdConverter().fromJson(json['id'] as Object),
      roomId: const NullableIdConverter().fromJson(json['roomId']),
      senderId: const NullableIdConverter().fromJson(json['senderId']),
      messageText: json['messageText'] as String?,
      mediaUrls:
          (json['mediaUrls'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      isRead: json['isRead'] as bool?,
      sentAt: const NullableUtcDateTimeConverter().fromJson(
        json['sentAt'] as String?,
      ),
    );

Map<String, dynamic> _$ChatMessageResponseToJson(
  _ChatMessageResponse instance,
) => <String, dynamic>{
  'id': const IdConverter().toJson(instance.id),
  'roomId': const NullableIdConverter().toJson(instance.roomId),
  'senderId': const NullableIdConverter().toJson(instance.senderId),
  'messageText': instance.messageText,
  'mediaUrls': instance.mediaUrls,
  'isRead': instance.isRead,
  'sentAt': const NullableUtcDateTimeConverter().toJson(instance.sentAt),
};

_ChatMessagePageResponse _$ChatMessagePageResponseFromJson(
  Map<String, dynamic> json,
) => _ChatMessagePageResponse(
  messages:
      (json['messages'] as List<dynamic>?)
          ?.map((e) => ChatMessageResponse.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$ChatMessagePageResponseToJson(
  _ChatMessagePageResponse instance,
) => <String, dynamic>{'messages': instance.messages};
