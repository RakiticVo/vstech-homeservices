// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_message_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ChatMessageRequest _$ChatMessageRequestFromJson(Map<String, dynamic> json) =>
    _ChatMessageRequest(
      messageText: json['messageText'] as String,
      mediaUrls: (json['mediaUrls'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$ChatMessageRequestToJson(_ChatMessageRequest instance) =>
    <String, dynamic>{
      'messageText': instance.messageText,
      'mediaUrls': ?instance.mediaUrls,
    };
