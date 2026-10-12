import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_settings_response.freezed.dart';
part 'notification_settings_response.g.dart';

/// `data` of `GET/PUT /api/v1/notifications/settings`.
@freezed
abstract class NotificationSettingsResponse
    with _$NotificationSettingsResponse {
  const factory NotificationSettingsResponse({
    bool? systemEnabled,
    bool? bookingEnabled,
    bool? promoEnabled,
  }) = _NotificationSettingsResponse;

  factory NotificationSettingsResponse.fromJson(Map<String, dynamic> json) =>
      _$NotificationSettingsResponseFromJson(json);
}
