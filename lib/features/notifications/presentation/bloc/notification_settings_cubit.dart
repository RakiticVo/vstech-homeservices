import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:vstech_home_services/core/error/failure.dart';
import 'package:vstech_home_services/core/error/result.dart';
import 'package:vstech_home_services/features/notifications/domain/entities/app_notification.dart';
import 'package:vstech_home_services/features/notifications/domain/usecases/notification_use_cases.dart';

part 'notification_settings_state.dart';

/// Per-category notification switches (`GET/PUT /notifications/settings`). Toggles edit a local
/// draft; [save] sends all three flags.
@injectable
class NotificationSettingsCubit extends Cubit<NotificationSettingsState> {
  NotificationSettingsCubit(this._getSettings, this._updateSettings)
    : super(const NotificationSettingsLoadingState());

  final GetNotificationSettingsUseCase _getSettings;
  final UpdateNotificationSettingsUseCase _updateSettings;

  Future<void> load() async {
    emit(const NotificationSettingsLoadingState());
    switch (await _getSettings()) {
      case Ok(:final value):
        emit(NotificationSettingsLoadedState(saved: value, draft: value));
      case Err(:final failure):
        emit(NotificationSettingsErrorState(failure));
    }
  }

  void toggle(NotificationType type, {required bool enabled}) {
    final current = state;
    if (current is! NotificationSettingsLoadedState ||
        current.status == SettingsSaveStatus.saving) {
      return;
    }
    final draft = switch (type) {
      NotificationType.system => current.draft.copyWith(systemEnabled: enabled),
      NotificationType.booking => current.draft.copyWith(
        bookingEnabled: enabled,
      ),
      NotificationType.promo => current.draft.copyWith(promoEnabled: enabled),
      NotificationType.unknown => current.draft,
    };
    emit(current.copyWith(draft: draft, status: SettingsSaveStatus.idle));
  }

  Future<void> save() async {
    final current = state;
    if (current is! NotificationSettingsLoadedState ||
        !current.isDirty ||
        current.status == SettingsSaveStatus.saving) {
      return;
    }
    emit(current.copyWith(status: SettingsSaveStatus.saving));
    switch (await _updateSettings(current.draft)) {
      case Ok(:final value):
        emit(
          NotificationSettingsLoadedState(
            saved: value,
            draft: value,
            status: SettingsSaveStatus.saved,
          ),
        );
      case Err(:final failure):
        emit(
          current.copyWith(status: SettingsSaveStatus.failed, failure: failure),
        );
    }
  }
}
