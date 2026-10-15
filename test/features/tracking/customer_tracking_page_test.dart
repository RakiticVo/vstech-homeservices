import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vstech_home_services/core/router/app_routes.dart';
import 'package:vstech_home_services/core/theme/app_theme.dart';
import 'package:vstech_home_services/features/booking/domain/entities/booking_status.dart';
import 'package:vstech_home_services/features/tracking/domain/entities/worker_position.dart';
import 'package:vstech_home_services/features/tracking/presentation/bloc/customer_tracking_cubit.dart';
import 'package:vstech_home_services/features/tracking/presentation/pages/customer_tracking_page.dart';
import 'package:vstech_home_services/features/tracking/presentation/widgets/tracking_map_widget.dart';
import 'package:vstech_home_services/l10n/generated/app_localizations.dart';

import '../../fixtures/booking/booking_fixtures.dart';
import '../../helpers/mocks.dart';

final _position = WorkerPosition(
  latitude: 10.7798,
  longitude: 106.6990,
  updatedAt: DateTime.utc(2026, 10, 15, 3, 4, 5),
);

Widget _app(MockCustomerTrackingCubit cubit) {
  final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => BlocProvider<CustomerTrackingCubit>.value(
          value: cubit,
          child: const CustomerTrackingPage(bookingId: '502'),
        ),
      ),
      GoRoute(
        path: AppRoutes.chat,
        builder: (context, state) =>
            Scaffold(body: Text('Chat:${state.uri.queryParameters['id']}')),
      ),
      GoRoute(
        path: AppRoutes.inspectionSignoff,
        builder: (context, state) => Scaffold(
          body: Text('Signoff:${state.uri.queryParameters['code']}'),
        ),
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

MockCustomerTrackingCubit _cubit(CustomerTrackingState state) {
  final cubit = MockCustomerTrackingCubit();
  when(() => cubit.load(any())).thenAnswer((_) async {});
  when(cubit.reconnect).thenAnswer((_) async {});
  whenListen(
    cubit,
    const Stream<CustomerTrackingState>.empty(),
    initialState: state,
  );
  return cubit;
}

Future<void> _pump(WidgetTester tester, MockCustomerTrackingCubit cubit) async {
  await tester.binding.setSurfaceSize(const Size(420, 1400));
  addTearDown(() => tester.binding.setSurfaceSize(null));
  await tester.pumpWidget(_app(cubit));
  await tester.pumpAndSettle();
}

void main() {
  testWidgets(
    'en route: live status, map, distance to the profile address and the update time',
    (tester) async {
      await _pump(
        tester,
        _cubit(
          CustomerTrackingLoadedState(
            booking: acceptedBooking,
            home: (10.7725, 106.6980),
            position: _position,
            connection: TrackingConnectionStatus.live,
          ),
        ),
      );

      expect(find.text('Mã đơn: #502'), findsOneWidget);
      expect(find.byKey(const Key('tracking_stage_enRoute')), findsOneWidget);
      expect(find.byKey(const Key('tracking_connection_live')), findsOneWidget);
      expect(find.byType(TrackingMapWidget), findsOneWidget);
      expect(find.text('Cách địa chỉ của bạn khoảng 820 m'), findsOneWidget);
      expect(find.byKey(const Key('tracking_updated_at')), findsOneWidget);
      expect(find.text('Thợ phụ trách'), findsOneWidget);
      // No mock worker name / rating / stage chips any more.
      expect(find.text('Nguyễn Văn Hùng'), findsNothing);
      expect(find.text('Thợ đã đến'), findsNothing);
    },
  );

  testWidgets('waiting for GPS before the first position', (tester) async {
    await _pump(
      tester,
      _cubit(CustomerTrackingLoadedState(booking: acceptedBooking)),
    );

    expect(find.text('Đang chờ vị trí của thợ…'), findsOneWidget);
    expect(
      find.byKey(const Key('tracking_connection_connecting')),
      findsOneWidget,
    );
  });

  testWidgets(
    'offline / rejected shows the reason and a reconnect action; chat opens for the booking',
    (tester) async {
      final cubit = _cubit(
        CustomerTrackingLoadedState(
          booking: acceptedBooking,
          connection: TrackingConnectionStatus.offline,
          errorCode: 'HS-403-0001',
        ),
      );
      await _pump(tester, cubit);

      expect(find.byKey(const Key('tracking_rejected')), findsOneWidget);
      await tester.tap(find.byKey(const Key('tracking_reconnect')));
      verify(cubit.reconnect).called(1);

      await tester.tap(find.byKey(const Key('tracking_chat_button')));
      await tester.pumpAndSettle();
      expect(find.text('Chat:502'), findsOneWidget);
    },
  );

  testWidgets('in progress shows the working notice', (tester) async {
    await _pump(
      tester,
      _cubit(
        CustomerTrackingLoadedState(
          booking: acceptedBooking.copyWith(status: BookingStatus.inProgress),
          connection: TrackingConnectionStatus.live,
        ),
      ),
    );

    expect(find.byKey(const Key('tracking_stage_working')), findsOneWidget);
    expect(
      find.text('Thợ đang thực hiện công việc tại nhà bạn'),
      findsOneWidget,
    );
    expect(find.byType(TrackingMapWidget), findsNothing);
  });

  testWidgets('completed: sign-off CTA, no live tracking UI', (tester) async {
    await _pump(
      tester,
      _cubit(
        CustomerTrackingLoadedState(
          booking: acceptedBooking.copyWith(status: BookingStatus.completed),
          connection: TrackingConnectionStatus.offline,
        ),
      ),
    );

    expect(find.byKey(const Key('tracking_reconnect')), findsNothing);
    await tester.tap(find.byKey(const Key('tracking_signoff_button')));
    await tester.pumpAndSettle();
    expect(find.text('Signoff:502'), findsOneWidget);
  });

  testWidgets('pending booking: nothing to track', (tester) async {
    await _pump(
      tester,
      _cubit(CustomerTrackingLoadedState(booking: pendingBooking)),
    );

    expect(
      find.text('Đơn này hiện không ở giai đoạn theo dõi thợ.'),
      findsOneWidget,
    );
    expect(find.byKey(const Key('tracking_call_button')), findsNothing);
  });
}
