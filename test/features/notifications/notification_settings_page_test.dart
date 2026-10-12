import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vstech_home_services/core/theme/app_theme.dart';
import 'package:vstech_home_services/features/notifications/domain/entities/app_notification.dart';
import 'package:vstech_home_services/features/notifications/presentation/bloc/notification_settings_cubit.dart';
import 'package:vstech_home_services/features/notifications/presentation/pages/notification_settings_page.dart';
import 'package:vstech_home_services/l10n/generated/app_localizations.dart';

import '../../helpers/mocks.dart';

const _server = NotificationSettings(promoEnabled: false);

Widget _app(MockNotificationSettingsCubit cubit) => MaterialApp(
  theme: AppTheme.light,
  localizationsDelegates: const [
    AppLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ],
  supportedLocales: AppLocalizations.supportedLocales,
  locale: const Locale('vi'),
  home: BlocProvider<NotificationSettingsCubit>.value(
    value: cubit,
    child: const NotificationSettingsPage(),
  ),
);

MockNotificationSettingsCubit _cubit(
  NotificationSettingsState state, {
  Stream<NotificationSettingsState> stream = const Stream.empty(),
}) {
  final cubit = MockNotificationSettingsCubit();
  when(cubit.load).thenAnswer((_) async {});
  when(cubit.save).thenAnswer((_) async {});
  whenListen(cubit, stream, initialState: state);
  return cubit;
}

void main() {
  testWidgets(
    'shows one switch per API category; save is disabled until something changes',
    (tester) async {
      final cubit = _cubit(
        const NotificationSettingsLoadedState(saved: _server, draft: _server),
      );

      await tester.pumpWidget(_app(cubit));
      await tester.pumpAndSettle();

      expect(find.text('Thông báo đặt lịch'), findsOneWidget);
      expect(find.text('Thông báo hệ thống'), findsOneWidget);
      expect(find.byType(Switch), findsNWidgets(3));
      expect(
        tester
            .widget<Switch>(
              find.descendant(
                of: find.byKey(const Key('notif_settings_promo')),
                matching: find.byType(Switch),
              ),
            )
            .value,
        isFalse,
      );

      await tester.tap(find.byKey(const Key('notif_settings_save')));
      verifyNever(cubit.save);

      await tester.tap(
        find.descendant(
          of: find.byKey(const Key('notif_settings_promo')),
          matching: find.byType(Switch),
        ),
      );
      verify(() => cubit.toggle(NotificationType.promo, enabled: true))
          .called(1);
    },
  );

  testWidgets('a dirty draft can be saved and a success SnackBar follows', (
    tester,
  ) async {
    const dirty = NotificationSettingsLoadedState(
      saved: _server,
      draft: NotificationSettings(),
    );
    final cubit = _cubit(
      dirty,
      stream: Stream.value(
        const NotificationSettingsLoadedState(
          saved: NotificationSettings(),
          draft: NotificationSettings(),
          status: SettingsSaveStatus.saved,
        ),
      ),
    );

    await tester.pumpWidget(_app(cubit));
    await tester.pumpAndSettle();

    expect(find.text('Đã lưu cài đặt thông báo'), findsOneWidget);
  });

  testWidgets('save button triggers save when dirty', (tester) async {
    final cubit = _cubit(
      const NotificationSettingsLoadedState(
        saved: _server,
        draft: NotificationSettings(),
      ),
    );

    await tester.pumpWidget(_app(cubit));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('notif_settings_save')));

    verify(cubit.save).called(1);
  });
}
