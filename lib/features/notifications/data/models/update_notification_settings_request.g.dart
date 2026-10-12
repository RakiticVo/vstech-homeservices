// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_notification_settings_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UpdateNotificationSettingsRequest _$UpdateNotificationSettingsRequestFromJson(
  Map<String, dynamic> json,
) => _UpdateNotificationSettingsRequest(
  systemEnabled: json['systemEnabled'] as bool,
  bookingEnabled: json['bookingEnabled'] as bool,
  promoEnabled: json['promoEnabled'] as bool,
);

Map<String, dynamic> _$UpdateNotificationSettingsRequestToJson(
  _UpdateNotificationSettingsRequest instance,
) => <String, dynamic>{
  'systemEnabled': instance.systemEnabled,
  'bookingEnabled': instance.bookingEnabled,
  'promoEnabled': instance.promoEnabled,
};
