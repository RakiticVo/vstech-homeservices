// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_settings_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_NotificationSettingsResponse _$NotificationSettingsResponseFromJson(
  Map<String, dynamic> json,
) => _NotificationSettingsResponse(
  systemEnabled: json['systemEnabled'] as bool?,
  bookingEnabled: json['bookingEnabled'] as bool?,
  promoEnabled: json['promoEnabled'] as bool?,
);

Map<String, dynamic> _$NotificationSettingsResponseToJson(
  _NotificationSettingsResponse instance,
) => <String, dynamic>{
  'systemEnabled': instance.systemEnabled,
  'bookingEnabled': instance.bookingEnabled,
  'promoEnabled': instance.promoEnabled,
};
