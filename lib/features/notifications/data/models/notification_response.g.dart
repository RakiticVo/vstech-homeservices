// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_NotificationResponse _$NotificationResponseFromJson(
  Map<String, dynamic> json,
) => _NotificationResponse(
  id: const IdConverter().fromJson(json['id'] as Object),
  userId: const NullableIdConverter().fromJson(json['userId']),
  title: json['title'] as String?,
  body: json['body'] as String?,
  type: json['type'] as String?,
  isRead: json['isRead'] as bool?,
  createdAt: const NullableUtcDateTimeConverter().fromJson(
    json['createdAt'] as String?,
  ),
);

Map<String, dynamic> _$NotificationResponseToJson(
  _NotificationResponse instance,
) => <String, dynamic>{
  'id': const IdConverter().toJson(instance.id),
  'userId': const NullableIdConverter().toJson(instance.userId),
  'title': instance.title,
  'body': instance.body,
  'type': instance.type,
  'isRead': instance.isRead,
  'createdAt': const NullableUtcDateTimeConverter().toJson(instance.createdAt),
};

_NotificationPageResponse _$NotificationPageResponseFromJson(
  Map<String, dynamic> json,
) => _NotificationPageResponse(
  notifications:
      (json['notifications'] as List<dynamic>?)
          ?.map((e) => NotificationResponse.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$NotificationPageResponseToJson(
  _NotificationPageResponse instance,
) => <String, dynamic>{'notifications': instance.notifications};
