import 'package:injectable/injectable.dart';
import 'package:vstech_home_services/core/error/result.dart';
import 'package:vstech_home_services/features/notifications/data/datasources/notification_remote_data_source.dart';
import 'package:vstech_home_services/features/notifications/data/models/notification_response.dart';
import 'package:vstech_home_services/features/notifications/data/models/notification_settings_response.dart';
import 'package:vstech_home_services/features/notifications/data/models/update_notification_settings_request.dart';
import 'package:vstech_home_services/features/notifications/domain/entities/app_notification.dart';
import 'package:vstech_home_services/features/notifications/domain/repositories/notification_repository.dart';

@LazySingleton(as: NotificationRepository)
class NotificationRepositoryImpl implements NotificationRepository {
  NotificationRepositoryImpl(this._remote);

  final NotificationRemoteDataSource _remote;

  static const int pageSize = 20;

  @override
  Future<Result<NotificationPage>> getNotifications({
    required int page,
    NotificationType? type,
  }) => Result.guard(() async {
    final response = await _remote.getNotifications(
      page: page,
      size: pageSize,
      type: type?.apiValue,
    );
    return NotificationPage(
      items: [for (final item in response.notifications) _toNotification(item)],
      page: page,
      hasMore: response.notifications.length >= pageSize,
    );
  });

  @override
  Future<Result<void>> markRead(String id) =>
      Result.guard(() => _remote.markRead(id));

  @override
  Future<Result<void>> markAllRead() => Result.guard(_remote.markAllRead);

  @override
  Future<Result<NotificationSettings>> getSettings() =>
      Result.guard(() async => _toSettings(await _remote.getSettings()));

  @override
  Future<Result<NotificationSettings>> updateSettings(
    NotificationSettings settings,
  ) => Result.guard(() async {
    final response = await _remote.updateSettings(
      UpdateNotificationSettingsRequest(
        systemEnabled: settings.systemEnabled,
        bookingEnabled: settings.bookingEnabled,
        promoEnabled: settings.promoEnabled,
      ),
    );
    return _toSettings(response);
  });

  static AppNotification _toNotification(NotificationResponse r) =>
      AppNotification(
        id: r.id,
        type: NotificationType.fromApi(r.type),
        title: r.title ?? '',
        body: r.body ?? '',
        isRead: r.isRead ?? false,
        createdAt: r.createdAt,
      );

  static NotificationSettings _toSettings(NotificationSettingsResponse r) =>
      NotificationSettings(
        systemEnabled: r.systemEnabled ?? true,
        bookingEnabled: r.bookingEnabled ?? true,
        promoEnabled: r.promoEnabled ?? true,
      );
}
