import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vstech_home_services/core/error/failure.dart';
import 'package:vstech_home_services/core/error/result.dart';
import 'package:vstech_home_services/core/network/network_exception.dart';
import 'package:vstech_home_services/features/notifications/domain/entities/app_notification.dart';
import 'package:vstech_home_services/features/notifications/presentation/bloc/notification_settings_cubit.dart';

import '../../../helpers/mocks.dart';

const _offline = Failure(kind: NetworkErrorKind.noConnection);
const _server = NotificationSettings(promoEnabled: false);
const _promoOn = NotificationSettings();

void main() {
  late MockGetNotificationSettingsUseCase getSettings;
  late MockUpdateNotificationSettingsUseCase updateSettings;

  setUpAll(() => registerFallbackValue(const NotificationSettings()));

  setUp(() {
    getSettings = MockGetNotificationSettingsUseCase();
    updateSettings = MockUpdateNotificationSettingsUseCase();
  });

  NotificationSettingsCubit build() =>
      NotificationSettingsCubit(getSettings, updateSettings);

  blocTest<NotificationSettingsCubit, NotificationSettingsState>(
    'load emits the server settings as both saved and draft',
    setUp: () =>
        when(() => getSettings()).thenAnswer((_) async => const Ok(_server)),
    build: build,
    act: (cubit) => cubit.load(),
    expect: () => [
      const NotificationSettingsLoadingState(),
      const NotificationSettingsLoadedState(saved: _server, draft: _server),
    ],
  );

  blocTest<NotificationSettingsCubit, NotificationSettingsState>(
    'load failure emits an error state',
    setUp: () =>
        when(() => getSettings()).thenAnswer((_) async => const Err(_offline)),
    build: build,
    act: (cubit) => cubit.load(),
    expect: () => [
      const NotificationSettingsLoadingState(),
      const NotificationSettingsErrorState(_offline),
    ],
  );

  blocTest<NotificationSettingsCubit, NotificationSettingsState>(
    'toggle edits the draft only; toggling back makes it clean again',
    build: build,
    seed: () =>
        const NotificationSettingsLoadedState(saved: _server, draft: _server),
    act: (cubit) => cubit
      ..toggle(NotificationType.promo, enabled: true)
      ..toggle(NotificationType.promo, enabled: false),
    expect: () => [
      const NotificationSettingsLoadedState(saved: _server, draft: _promoOn),
      const NotificationSettingsLoadedState(saved: _server, draft: _server),
    ],
  );

  blocTest<NotificationSettingsCubit, NotificationSettingsState>(
    'save sends the draft and marks it saved',
    setUp: () =>
        when(() => updateSettings(_promoOn))
            .thenAnswer((_) async => const Ok(_promoOn)),
    build: build,
    seed: () =>
        const NotificationSettingsLoadedState(saved: _server, draft: _promoOn),
    act: (cubit) => cubit.save(),
    expect: () => [
      const NotificationSettingsLoadedState(
        saved: _server,
        draft: _promoOn,
        status: SettingsSaveStatus.saving,
      ),
      const NotificationSettingsLoadedState(
        saved: _promoOn,
        draft: _promoOn,
        status: SettingsSaveStatus.saved,
      ),
    ],
  );

  blocTest<NotificationSettingsCubit, NotificationSettingsState>(
    'save failure keeps the draft and reports the failure',
    setUp: () =>
        when(() => updateSettings(any()))
            .thenAnswer((_) async => const Err(_offline)),
    build: build,
    seed: () =>
        const NotificationSettingsLoadedState(saved: _server, draft: _promoOn),
    act: (cubit) => cubit.save(),
    expect: () => [
      const NotificationSettingsLoadedState(
        saved: _server,
        draft: _promoOn,
        status: SettingsSaveStatus.saving,
      ),
      const NotificationSettingsLoadedState(
        saved: _server,
        draft: _promoOn,
        status: SettingsSaveStatus.failed,
        failure: _offline,
      ),
    ],
  );

  blocTest<NotificationSettingsCubit, NotificationSettingsState>(
    'save does nothing without changes',
    build: build,
    seed: () =>
        const NotificationSettingsLoadedState(saved: _server, draft: _server),
    act: (cubit) => cubit.save(),
    expect: () => <NotificationSettingsState>[],
    verify: (_) => verifyNever(() => updateSettings(any())),
  );
}
