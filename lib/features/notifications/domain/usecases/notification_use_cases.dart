import 'package:injectable/injectable.dart';
import 'package:vstech_home_services/core/error/result.dart';
import 'package:vstech_home_services/features/notifications/domain/entities/app_notification.dart';
import 'package:vstech_home_services/features/notifications/domain/repositories/notification_repository.dart';

@injectable
class GetNotificationsUseCase {
  const GetNotificationsUseCase(this._repository);

  final NotificationRepository _repository;

  Future<Result<NotificationPage>> call({
    int page = 0,
    NotificationType? type,
  }) => _repository.getNotifications(page: page, type: type);
}

@injectable
class MarkNotificationReadUseCase {
  const MarkNotificationReadUseCase(this._repository);

  final NotificationRepository _repository;

  Future<Result<void>> call(String id) => _repository.markRead(id);
}

@injectable
class MarkAllNotificationsReadUseCase {
  const MarkAllNotificationsReadUseCase(this._repository);

  final NotificationRepository _repository;

  Future<Result<void>> call() => _repository.markAllRead();
}

@injectable
class GetNotificationSettingsUseCase {
  const GetNotificationSettingsUseCase(this._repository);

  final NotificationRepository _repository;

  Future<Result<NotificationSettings>> call() => _repository.getSettings();
}

@injectable
class UpdateNotificationSettingsUseCase {
  const UpdateNotificationSettingsUseCase(this._repository);

  final NotificationRepository _repository;

  Future<Result<NotificationSettings>> call(NotificationSettings settings) =>
      _repository.updateSettings(settings);
}
