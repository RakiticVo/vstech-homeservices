import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_notification_settings_request.freezed.dart';
part 'update_notification_settings_request.g.dart';

/// Body of `PUT /api/v1/notifications/settings` — all three flags are required (`HS-400-0001`).
@freezed
abstract class UpdateNotificationSettingsRequest
    with _$UpdateNotificationSettingsRequest {
  const factory UpdateNotificationSettingsRequest({
    required bool systemEnabled,
    required bool bookingEnabled,
    required bool promoEnabled,
  }) = _UpdateNotificationSettingsRequest;

  factory UpdateNotificationSettingsRequest.fromJson(
    Map<String, dynamic> json,
  ) => _$UpdateNotificationSettingsRequestFromJson(json);
}
