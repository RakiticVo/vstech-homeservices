import 'package:vstech_home_services/core/error/result.dart';
import 'package:vstech_home_services/features/notifications/domain/entities/app_notification.dart';

abstract interface class NotificationRepository {
  Future<Result<NotificationPage>> getNotifications({
    required int page,
    NotificationType? type,
  });

  Future<Result<void>> markRead(String id);

  Future<Result<void>> markAllRead();

  Future<Result<NotificationSettings>> getSettings();

  Future<Result<NotificationSettings>> updateSettings(
    NotificationSettings settings,
  );
}
