import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_notification.freezed.dart';

/// Notification category (`docs/reference/api/08-notifications.md` §2).
enum NotificationType {
  system,
  booking,
  promo,
  unknown;

  static NotificationType fromApi(String? value) => switch (value) {
    'SYSTEM' => NotificationType.system,
    'BOOKING' => NotificationType.booking,
    'PROMO' => NotificationType.promo,
    _ => NotificationType.unknown,
  };

  String get apiValue => switch (this) {
    NotificationType.system => 'SYSTEM',
    NotificationType.booking => 'BOOKING',
    NotificationType.promo => 'PROMO',
    NotificationType.unknown => throw UnsupportedError(
      'No API value for $this',
    ),
  };
}

/// An in-app notification. [createdAt] is UTC.
@freezed
abstract class AppNotification with _$AppNotification {
  const factory AppNotification({
    required String id,
    required NotificationType type,
    @Default('') String title,
    @Default('') String body,
    @Default(false) bool isRead,
    DateTime? createdAt,
  }) = _AppNotification;
}

/// A page of notifications. The API sends no paging metadata, so [hasMore] is inferred from a full
/// page.
@freezed
abstract class NotificationPage with _$NotificationPage {
  const factory NotificationPage({
    required List<AppNotification> items,
    required int page,
    required bool hasMore,
  }) = _NotificationPage;
}

/// Per-category on/off switches.
@freezed
abstract class NotificationSettings with _$NotificationSettings {
  const factory NotificationSettings({
    @Default(true) bool systemEnabled,
    @Default(true) bool bookingEnabled,
    @Default(true) bool promoEnabled,
  }) = _NotificationSettings;
}
