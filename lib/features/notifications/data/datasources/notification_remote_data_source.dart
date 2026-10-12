import 'package:injectable/injectable.dart';
import 'package:vstech_home_services/core/network/api_client.dart';
import 'package:vstech_home_services/core/network/api_endpoints.dart';
import 'package:vstech_home_services/features/notifications/data/models/notification_response.dart';
import 'package:vstech_home_services/features/notifications/data/models/notification_settings_response.dart';
import 'package:vstech_home_services/features/notifications/data/models/update_notification_settings_request.dart';

/// `/api/v1/notifications/*` — the signed-in user's in-app notifications and their settings.
@injectable
class NotificationRemoteDataSource {
  const NotificationRemoteDataSource(this._client);

  final ApiClient _client;

  Future<NotificationPageResponse> getNotifications({
    required int page,
    required int size,
    String? type,
  }) async {
    final response = await _client.get(
      ApiEndpoints.notifications,
      query: {'page': page, 'size': size, 'type': ?type},
      decode: (json) =>
          NotificationPageResponse.fromJson(json! as Map<String, dynamic>),
    );
    return response.requireData;
  }

  Future<void> markRead(String id) =>
      _client.post<void>(ApiEndpoints.notificationRead(id), decode: (_) {});

  Future<void> markAllRead() =>
      _client.post<void>(ApiEndpoints.notificationsReadAll, decode: (_) {});

  Future<NotificationSettingsResponse> getSettings() async {
    final response = await _client.get(
      ApiEndpoints.notificationSettings,
      decode: (json) =>
          NotificationSettingsResponse.fromJson(json! as Map<String, dynamic>),
    );
    return response.requireData;
  }

  Future<NotificationSettingsResponse> updateSettings(
    UpdateNotificationSettingsRequest body,
  ) async {
    final response = await _client.put(
      ApiEndpoints.notificationSettings,
      body: body.toJson(),
      decode: (json) =>
          NotificationSettingsResponse.fromJson(json! as Map<String, dynamic>),
    );
    return response.requireData;
  }
}
