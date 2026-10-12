import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vstech_home_services/core/error/failure.dart';
import 'package:vstech_home_services/core/network/network_exception.dart';
import 'package:vstech_home_services/core/router/app_routes.dart';
import 'package:vstech_home_services/core/theme/app_theme.dart';
import 'package:vstech_home_services/features/notifications/domain/entities/app_notification.dart';
import 'package:vstech_home_services/features/notifications/presentation/bloc/notifications_cubit.dart';
import 'package:vstech_home_services/features/notifications/presentation/pages/notifications_page.dart';
import 'package:vstech_home_services/l10n/generated/app_localizations.dart';

import '../../fixtures/notifications/notification_fixtures.dart';
import '../../helpers/mocks.dart';

Widget _app(MockNotificationsCubit cubit, {bool isWorker = false}) {
  final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => BlocProvider<NotificationsCubit>.value(
          value: cubit,
          child: NotificationsPage(
            isWorker: isWorker,
            settingsRoute: isWorker
                ? null
                : AppRoutes.customerNotificationSettings,
          ),
        ),
      ),
      GoRoute(
        path: AppRoutes.customerOrders,
        builder: (context, state) => const Scaffold(body: Text('OrdersTarget')),
      ),
      GoRoute(
        path: AppRoutes.workerJobsHub,
        builder: (context, state) => const Scaffold(body: Text('JobsTarget')),
      ),
      GoRoute(
        path: AppRoutes.customerNotificationSettings,
        builder: (context, state) =>
            const Scaffold(body: Text('SettingsTarget')),
      ),
    ],
  );
  return MaterialApp.router(
    theme: AppTheme.light,
    routerConfig: router,
    localizationsDelegates: const [
      AppLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    supportedLocales: AppLocalizations.supportedLocales,
    locale: const Locale('vi'),
  );
}

MockNotificationsCubit _cubit(NotificationsState state) {
  final cubit = MockNotificationsCubit();
  when(() => cubit.load(filter: any(named: 'filter'))).thenAnswer((_) async {});
  when(cubit.refresh).thenAnswer((_) async {});
  when(cubit.loadMore).thenAnswer((_) async {});
  when(() => cubit.markRead(any())).thenAnswer((_) async {});
  when(cubit.markAllRead).thenAnswer((_) async {});
  whenListen(
    cubit,
    const Stream<NotificationsState>.empty(),
    initialState: state,
  );
  return cubit;
}

void main() {
  setUp(() async => TestWidgetsFlutterBinding.ensureInitialized());

  testWidgets(
    'groups API notifications into Today / Earlier with type label and unread badge',
    (tester) async {
      await tester.binding.setSurfaceSize(const Size(800, 1600));
      addTearDown(() => tester.binding.setSurfaceSize(null));
      final cubit = _cubit(
        NotificationsLoadedState(
          items: [bookingUnread, systemRead],
          page: 0,
          hasMore: true,
        ),
      );

      await tester.pumpWidget(_app(cubit));
      await tester.pumpAndSettle();

      expect(find.text('Hôm nay'), findsOneWidget);
      expect(find.text('Trước đó'), findsOneWidget);
      expect(find.text('Thợ đã nhận việc'), findsOneWidget);
      expect(find.text('Bảo trì hệ thống'), findsOneWidget);
      expect(
        find.byKey(const Key('notification_unread_badge')),
        findsOneWidget,
      );
      expect(find.text('Chưa đọc'), findsOneWidget);

      await tester.tap(find.byKey(const Key('notifications_load_more')));
      verify(cubit.loadMore).called(1);

      await tester.tap(find.byKey(const Key('notifications_mark_all_read')));
      verify(cubit.markAllRead).called(1);

      await tester.tap(find.byKey(const Key('notifications_filter_promo')));
      verify(() => cubit.load(filter: NotificationType.promo)).called(1);
    },
  );

  testWidgets(
    'tapping a booking notification marks it read and opens the orders list',
    (tester) async {
      await tester.binding.setSurfaceSize(const Size(800, 1600));
      addTearDown(() => tester.binding.setSurfaceSize(null));
      final cubit = _cubit(
        NotificationsLoadedState(
          items: [bookingUnread],
          page: 0,
          hasMore: false,
        ),
      );

      await tester.pumpWidget(_app(cubit));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Thợ đã nhận việc'));
      await tester.pumpAndSettle();

      verify(() => cubit.markRead('101')).called(1);
      expect(find.text('OrdersTarget'), findsOneWidget);
    },
  );

  testWidgets(
    'worker: booking notification opens the jobs hub; no settings action',
    (tester) async {
      await tester.binding.setSurfaceSize(const Size(800, 1600));
      addTearDown(() => tester.binding.setSurfaceSize(null));
      final cubit = _cubit(
        NotificationsLoadedState(
          items: [bookingUnread],
          page: 0,
          hasMore: false,
        ),
      );

      await tester.pumpWidget(_app(cubit, isWorker: true));
      await tester.pumpAndSettle();

      expect(
        find.byKey(const Key('notifications_settings_button')),
        findsNothing,
      );
      await tester.tap(find.text('Thợ đã nhận việc'));
      await tester.pumpAndSettle();
      expect(find.text('JobsTarget'), findsOneWidget);
    },
  );

  testWidgets('empty list shows the empty state; no mark-all action', (
    tester,
  ) async {
    final cubit = _cubit(
      const NotificationsLoadedState(items: [], page: 0, hasMore: false),
    );

    await tester.pumpWidget(_app(cubit));
    await tester.pumpAndSettle();

    expect(find.text('Không có thông báo mới'), findsOneWidget);
    expect(find.byKey(const Key('notifications_mark_all_read')), findsNothing);
  });

  testWidgets('load error shows a retry block', (tester) async {
    final cubit = _cubit(
      const NotificationsErrorState(
        Failure(kind: NetworkErrorKind.noConnection),
      ),
    );

    await tester.pumpWidget(_app(cubit));
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.cloud_off_outlined), findsOneWidget);
  });
}
