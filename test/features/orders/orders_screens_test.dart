import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vstech_home_services/core/router/app_routes.dart';
import 'package:vstech_home_services/core/theme/app_theme.dart';
import 'package:vstech_home_services/features/orders/presentation/bloc/customer_orders_cubit.dart';
import 'package:vstech_home_services/features/orders/presentation/bloc/order_detail_cubit.dart';
import 'package:vstech_home_services/features/orders/presentation/pages/customer_notification_settings_page.dart';
import 'package:vstech_home_services/features/orders/presentation/pages/customer_notifications_page.dart';
import 'package:vstech_home_services/features/orders/presentation/pages/customer_order_detail_page.dart';
import 'package:vstech_home_services/features/orders/presentation/pages/customer_orders_page.dart';
import 'package:vstech_home_services/features/orders/presentation/pages/worker_jobs_hub_page.dart';
import 'package:vstech_home_services/features/orders/presentation/pages/worker_notifications_page.dart';
import 'package:vstech_home_services/l10n/generated/app_localizations.dart';

import '../../fixtures/booking/booking_fixtures.dart';
import '../../helpers/mocks.dart';

Widget _createTestOrdersWidget(Widget child, {MockCustomerOrdersCubit? orders, MockOrderDetailCubit? detail}) {
  final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(path: '/', builder: (context, state) => child),
      GoRoute(
        path: AppRoutes.customerOrderDetail,
        builder: (context, state) => Scaffold(body: Text('Detail:${state.uri.queryParameters['id']}')),
      ),
      GoRoute(
        path: AppRoutes.customerCancel,
        builder: (context, state) => Scaffold(body: Text('Cancel:${state.uri.queryParameters['id']}')),
      ),
      GoRoute(
        path: AppRoutes.disputeReport,
        builder: (context, state) => Scaffold(body: Text('Dispute:${state.uri.queryParameters['id']}')),
      ),
      GoRoute(
        path: AppRoutes.categories,
        builder: (context, state) => const Scaffold(body: Text('CategoriesTarget')),
      ),
      GoRoute(path: AppRoutes.workerJobsHub, builder: (context, state) => const WorkerJobsHubPage()),
      GoRoute(path: AppRoutes.customerNotifications, builder: (context, state) => const CustomerNotificationsPage()),
      GoRoute(
        path: AppRoutes.customerNotificationSettings,
        builder: (context, state) => const CustomerNotificationSettingsPage(),
      ),
      GoRoute(path: AppRoutes.workerNotifications, builder: (context, state) => const WorkerNotificationsPage()),
    ],
  );

  final app = MaterialApp.router(
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
  return MultiBlocProvider(
    providers: [
      BlocProvider<CustomerOrdersCubit>.value(value: orders ?? MockCustomerOrdersCubit()),
      BlocProvider<OrderDetailCubit>.value(value: detail ?? MockOrderDetailCubit()),
    ],
    child: app,
  );
}

void main() {
  group('Batch 8: Orders Hub & Notifications Widget Tests', () {
    testWidgets('CustomerOrdersPage groups API bookings into Active / Waiting / Done tabs', (tester) async {
      await tester.binding.setSurfaceSize(const Size(800, 1600));
      addTearDown(() => tester.binding.setSurfaceSize(null));
      final orders = MockCustomerOrdersCubit();
      when(orders.load).thenAnswer((_) async {});
      when(orders.loadMore).thenAnswer((_) async {});
      whenListen(
        orders,
        const Stream<CustomerOrdersState>.empty(),
        initialState: CustomerOrdersLoadedState(
          bookings: [pendingBooking, acceptedBooking, completedBooking],
          categoryNames: const {'1': 'Sửa máy lạnh', '2': 'Vệ sinh nhà'},
          page: 0,
          hasMore: true,
        ),
      );

      await tester.pumpWidget(_createTestOrdersWidget(const CustomerOrdersPage(), orders: orders));
      await tester.pumpAndSettle();

      // Active: accepted booking with Track CTA, status as Icon + Label + Color.
      expect(find.text('#502'), findsOneWidget);
      expect(find.byKey(const Key('booking_status_accepted')), findsOneWidget);
      expect(find.text('Thợ đã nhận việc'), findsOneWidget);
      expect(find.text('Theo dõi thợ'), findsOneWidget);
      expect(find.text('#501'), findsNothing);

      // Waiting: pending booking.
      await tester.tap(find.text('Đang chờ'));
      await tester.pumpAndSettle();
      expect(find.text('#501'), findsOneWidget);
      expect(find.text('Đang tìm thợ'), findsOneWidget);
      expect(find.text('Sửa máy lạnh'), findsOneWidget);
      expect(find.text('500.000đ'), findsOneWidget);

      // Done: completed booking shows its final price.
      await tester.tap(find.text('Hoàn thành').first);
      await tester.pumpAndSettle();
      expect(find.text('#503'), findsOneWidget);
      expect(find.text('Giá chốt'), findsOneWidget);
      expect(find.text('320.000đ'), findsOneWidget);

      // Manual paging + detail navigation by booking id.
      await tester.tap(find.byKey(const Key('orders_load_more_button')));
      verify(orders.loadMore).called(1);
      await tester.tap(find.byKey(const Key('order_detail_button_503')));
      await tester.pumpAndSettle();
      expect(find.text('Detail:503'), findsOneWidget);
    });

    testWidgets('CustomerOrdersPage shows the empty state with a CTA to book (Cell 74)', (tester) async {
      await tester.binding.setSurfaceSize(const Size(800, 1600));
      addTearDown(() => tester.binding.setSurfaceSize(null));
      final orders = MockCustomerOrdersCubit();
      whenListen(
        orders,
        const Stream<CustomerOrdersState>.empty(),
        initialState: const CustomerOrdersLoadedState(bookings: [], categoryNames: {}, page: 0, hasMore: false),
      );

      await tester.pumpWidget(_createTestOrdersWidget(const CustomerOrdersPage(), orders: orders));
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('orders_empty_state')), findsOneWidget);
      expect(find.text('Chưa có đơn đặt lịch nào'), findsOneWidget);
    });

    testWidgets('CustomerOrderDetailPage shows booking fields and the actions its status allows', (tester) async {
      await tester.binding.setSurfaceSize(const Size(800, 1600));
      addTearDown(() => tester.binding.setSurfaceSize(null));
      final detail = MockOrderDetailCubit();
      when(() => detail.load(any(), refresh: any(named: 'refresh'))).thenAnswer((_) async {});
      final states = StreamController<OrderDetailState>.broadcast();
      addTearDown(states.close);
      whenListen(
        detail,
        states.stream,
        initialState: OrderDetailLoadedState(pendingBooking, serviceName: 'Sửa máy lạnh'),
      );

      await tester.pumpWidget(_createTestOrdersWidget(const CustomerOrderDetailPage(bookingId: '501'), detail: detail));
      await tester.pumpAndSettle();

      verify(() => detail.load('501')).called(1);
      expect(find.text('Mã đơn hàng: #501'), findsOneWidget);
      expect(find.text('Đang tìm thợ'), findsOneWidget);
      expect(find.text('Sửa máy lạnh'), findsOneWidget);
      expect(find.text('123 Đường ABC, Quận 1'), findsOneWidget);
      expect(find.text('Máy lạnh không mát'), findsOneWidget);
      expect(find.text('500.000đ'), findsOneWidget);
      // PENDING: cancel only.
      expect(find.byKey(const Key('order_detail_cancel_button')), findsOneWidget);
      expect(find.byKey(const Key('order_detail_dispute_button')), findsNothing);
      expect(find.byKey(const Key('order_detail_track_button')), findsNothing);

      await tester.tap(find.byKey(const Key('order_detail_cancel_button')));
      await tester.pumpAndSettle();
      expect(find.text('Cancel:501'), findsOneWidget);

      // COMPLETED: report an issue only.
      tester.state<NavigatorState>(find.byType(Navigator).last).pop();
      await tester.pumpAndSettle();
      states.add(OrderDetailLoadedState(completedBooking, serviceName: 'Vệ sinh nhà'));
      await tester.pumpAndSettle();
      expect(find.byKey(const Key('order_detail_dispute_button')), findsOneWidget);
      expect(find.byKey(const Key('order_detail_cancel_button')), findsNothing);
      expect(find.text('320.000đ'), findsOneWidget);
    });

    testWidgets('WorkerJobsHubPage renders Assigned, Active and Completed tabs with net payout and actions', (
      tester,
    ) async {
      await tester.binding.setSurfaceSize(const Size(390, 1400));
      await tester.pumpWidget(_createTestOrdersWidget(const WorkerJobsHubPage()));
      await tester.pumpAndSettle();

      // Header
      expect(find.textContaining('Quản lý công việc'), findsOneWidget);

      // Assigned tab job card
      expect(find.text('HS-2026-0012'), findsOneWidget);
      expect(find.textContaining('2.4 km'), findsOneWidget);
      expect(find.textContaining('340.000đ'), findsWidgets);
      expect(find.textContaining('Nhận việc ngay'), findsOneWidget);

      // Tap on Active tab (Index 1)
      await tester.tap(find.textContaining('Đang làm'));
      await tester.pumpAndSettle();

      expect(find.textContaining('00:35:12'), findsOneWidget);
      expect(find.textContaining('Vào ca làm việc'), findsOneWidget);

      // Tap on Completed tab (Index 2)
      await tester.tap(find.textContaining('Đã hoàn tất'));
      await tester.pumpAndSettle();

      expect(find.text('HS-2026-0008'), findsOneWidget);
      expect(find.textContaining('5.0 ★'), findsOneWidget);
    });

    testWidgets('CustomerNotificationsPage renders timeline sections, filter chips and notification tiles', (
      tester,
    ) async {
      await tester.binding.setSurfaceSize(const Size(390, 1400));
      await tester.pumpWidget(_createTestOrdersWidget(const CustomerNotificationsPage()));
      await tester.pumpAndSettle();

      expect(find.textContaining('Thông báo'), findsWidgets);
      expect(find.textContaining('Hôm nay'), findsOneWidget);
      expect(find.textContaining('Trước đó'), findsOneWidget);

      // Filter chips
      expect(find.textContaining('Tất cả'), findsOneWidget);
      expect(find.textContaining('Đơn hàng'), findsOneWidget);
      expect(find.textContaining('Khuyến mãi'), findsOneWidget);

      // Notifications feed items
      expect(find.textContaining('Thợ đang di chuyển'), findsOneWidget);
      expect(find.textContaining('NHAMOICHI15'), findsOneWidget);
      expect(find.textContaining('Bảo hành điện tử'), findsOneWidget);
    });

    testWidgets('CustomerNotificationSettingsPage renders channel toggles and save button', (tester) async {
      await tester.binding.setSurfaceSize(const Size(390, 1400));
      await tester.pumpWidget(_createTestOrdersWidget(const CustomerNotificationSettingsPage()));
      await tester.pumpAndSettle();

      expect(find.textContaining('Cài đặt thông báo'), findsOneWidget);
      expect(find.textContaining('Thông báo đẩy'), findsOneWidget);
      expect(find.textContaining('SMS'), findsWidgets);
      expect(find.textContaining('Zalo'), findsWidgets);
      expect(find.textContaining('Lưu thay đổi'), findsOneWidget);

      // Tap on a switch
      final switches = find.byType(Switch);
      expect(switches, findsNWidgets(4));
      await tester.tap(switches.first);
      await tester.pumpAndSettle();

      // Tap save
      await tester.tap(find.textContaining('Lưu thay đổi'));
      await tester.pumpAndSettle();
    });

    testWidgets('WorkerNotificationsPage renders dispatch assignments, wallet credits and safety alerts', (
      tester,
    ) async {
      await tester.binding.setSurfaceSize(const Size(390, 1400));
      await tester.pumpWidget(_createTestOrdersWidget(const WorkerNotificationsPage()));
      await tester.pumpAndSettle();

      expect(find.textContaining('Thông báo'), findsWidgets);
      expect(find.textContaining('Đã đọc tất cả'), findsOneWidget);
      expect(find.textContaining('Yêu cầu công việc mới'), findsOneWidget);
      expect(find.textContaining('ví thu nhập'), findsOneWidget);
      expect(find.textContaining('an toàn lao động'), findsOneWidget);
    });
  });
}
