part of 'notification_settings_cubit.dart';

enum SettingsSaveStatus { idle, saving, saved, failed }

@immutable
sealed class NotificationSettingsState {
  const NotificationSettingsState();
}

final class NotificationSettingsLoadingState extends NotificationSettingsState {
  const NotificationSettingsLoadingState();
}

final class NotificationSettingsErrorState extends NotificationSettingsState {
  const NotificationSettingsErrorState(this.failure);

  final Failure failure;

  @override
  bool operator ==(Object other) =>
      other is NotificationSettingsErrorState && other.failure == failure;

  @override
  int get hashCode => failure.hashCode;
}

final class NotificationSettingsLoadedState extends NotificationSettingsState {
  const NotificationSettingsLoadedState({
    required this.saved,
    required this.draft,
    this.status = SettingsSaveStatus.idle,
    this.failure,
  });

  /// Last values confirmed by the server.
  final NotificationSettings saved;

  /// Values currently shown on the switches.
  final NotificationSettings draft;
  final SettingsSaveStatus status;

  /// Set when [status] is [SettingsSaveStatus.failed].
  final Failure? failure;

  bool get isDirty => draft != saved;

  NotificationSettingsLoadedState copyWith({
    NotificationSettings? draft,
    SettingsSaveStatus? status,
    Failure? failure,
  }) => NotificationSettingsLoadedState(
    saved: saved,
    draft: draft ?? this.draft,
    status: status ?? this.status,
    failure: failure,
  );

  @override
  bool operator ==(Object other) =>
      other is NotificationSettingsLoadedState &&
      other.saved == saved &&
      other.draft == draft &&
      other.status == status &&
      other.failure == failure;

  @override
  int get hashCode => Object.hash(saved, draft, status, failure);
}
