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
import 'package:vstech_home_services/features/booking/domain/entities/booking_status.dart';
import 'package:vstech_home_services/features/orders/presentation/bloc/booking_list_cubit.dart';
import 'package:vstech_home_services/features/orders/presentation/bloc/order_detail_cubit.dart';
import 'package:vstech_home_services/features/orders/presentation/pages/customer_order_detail_page.dart';
import 'package:vstech_home_services/features/orders/presentation/pages/customer_orders_page.dart';
import 'package:vstech_home_services/features/orders/presentation/pages/worker_jobs_hub_page.dart';
import 'package:vstech_home_services/l10n/generated/app_localizations.dart';

import '../../fixtures/booking/booking_fixtures.dart';
import '../../helpers/mocks.dart';

Widget _createTestOrdersWidget(
  Widget child, {
  MockBookingListCubit? orders,
  MockOrderDetailCubit? detail,
}) {
  final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(path: '/', builder: (context, state) => child),
      GoRoute(
        path: AppRoutes.customerOrderDetail,
        builder: (context, state) =>
            Scaffold(body: Text('Detail:${state.uri.queryParameters['id']}')),
      ),
      GoRoute(
        path: AppRoutes.customerCancel,
        builder: (context, state) =>
            Scaffold(body: Text('Cancel:${state.uri.queryParameters['id']}')),
      ),
      GoRoute(
        path: AppRoutes.disputeReport,
        builder: (context, state) =>
            Scaffold(body: Text('Dispute:${state.uri.queryParameters['id']}')),
      ),
      GoRoute(
        path: AppRoutes.categories,
        builder: (context, state) =>
            const Scaffold(body: Text('CategoriesTarget')),
      ),
      GoRoute(
        path: AppRoutes.workerJobDetail,
        builder: (context, state) => Scaffold(
          body: Text('JobDetail:${state.uri.queryParameters['id']}'),
        ),
      ),
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
      BlocProvider<BookingListCubit>.value(
        value: orders ?? MockBookingListCubit(),
      ),
      BlocProvider<OrderDetailCubit>.value(
        value: detail ?? MockOrderDetailCubit(),
      ),
    ],
    child: app,
  );
}

void main() {
  group('Batch 8: Orders Hub & Notifications Widget Tests', () {
    testWidgets(
      'CustomerOrdersPage groups API bookings into Active / Waiting / Done tabs',
      (tester) async {
        await tester.binding.setSurfaceSize(const Size(800, 1600));
        addTearDown(() => tester.binding.setSurfaceSize(null));
        final orders = MockBookingListCubit();
        when(orders.load).thenAnswer((_) async {});
        when(orders.loadMore).thenAnswer((_) async {});
        whenListen(
          orders,
          const Stream<BookingListState>.empty(),
          initialState: BookingListLoadedState(
            bookings: [pendingBooking, acceptedBooking, completedBooking],
            categoryNames: const {'1': 'Sửa máy lạnh', '2': 'Vệ sinh nhà'},
            page: 0,
            hasMore: true,
          ),
        );

        await tester.pumpWidget(
          _createTestOrdersWidget(const CustomerOrdersPage(), orders: orders),
        );
        await tester.pumpAndSettle();

        // Active: accepted booking with Track CTA, status as Icon + Label + Color.
        expect(find.text('#502'), findsOneWidget);
        expect(
          find.byKey(const Key('booking_status_accepted')),
          findsOneWidget,
        );
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
      },
    );

    testWidgets(
      'CustomerOrdersPage shows the empty state with a CTA to book (Cell 74)',
      (tester) async {
        await tester.binding.setSurfaceSize(const Size(800, 1600));
        addTearDown(() => tester.binding.setSurfaceSize(null));
        final orders = MockBookingListCubit();
        whenListen(
          orders,
          const Stream<BookingListState>.empty(),
          initialState: const BookingListLoadedState(
            bookings: [],
            categoryNames: {},
            page: 0,
            hasMore: false,
          ),
        );

        await tester.pumpWidget(
          _createTestOrdersWidget(const CustomerOrdersPage(), orders: orders),
        );
        await tester.pumpAndSettle();

        expect(find.byKey(const Key('orders_empty_state')), findsOneWidget);
        expect(find.text('Chưa có đơn đặt lịch nào'), findsOneWidget);
      },
    );

    testWidgets(
      'CustomerOrderDetailPage shows booking fields and the actions its status allows',
      (tester) async {
        await tester.binding.setSurfaceSize(const Size(800, 1600));
        addTearDown(() => tester.binding.setSurfaceSize(null));
        final detail = MockOrderDetailCubit();
        when(() => detail.load(any(), refresh: any(named: 'refresh')))
            .thenAnswer((_) async {});
        final states = StreamController<OrderDetailState>.broadcast();
        addTearDown(states.close);
        whenListen(
          detail,
          states.stream,
          initialState: OrderDetailLoadedState(
            pendingBooking,
            serviceName: 'Sửa máy lạnh',
          ),
        );

        await tester.pumpWidget(
          _createTestOrdersWidget(
            const CustomerOrderDetailPage(bookingId: '501'),
            detail: detail,
          ),
        );
        await tester.pumpAndSettle();

        verify(() => detail.load('501')).called(1);
        expect(find.text('Mã đơn hàng: #501'), findsOneWidget);
        expect(find.text('Đang tìm thợ'), findsOneWidget);
        expect(find.text('Sửa máy lạnh'), findsOneWidget);
        expect(find.text('123 Đường ABC, Quận 1'), findsOneWidget);
        expect(find.text('Máy lạnh không mát'), findsOneWidget);
        expect(find.text('500.000đ'), findsOneWidget);
        // PENDING: cancel only.
        expect(
          find.byKey(const Key('order_detail_cancel_button')),
          findsOneWidget,
        );
        expect(
          find.byKey(const Key('order_detail_dispute_button')),
          findsNothing,
        );
        expect(
          find.byKey(const Key('order_detail_track_button')),
          findsNothing,
        );

        await tester.tap(find.byKey(const Key('order_detail_cancel_button')));
        await tester.pumpAndSettle();
        expect(find.text('Cancel:501'), findsOneWidget);

        // COMPLETED: report an issue only.
        tester.state<NavigatorState>(find.byType(Navigator).last).pop();
        await tester.pumpAndSettle();
        states.add(
          OrderDetailLoadedState(completedBooking, serviceName: 'Vệ sinh nhà'),
        );
        await tester.pumpAndSettle();
        expect(
          find.byKey(const Key('order_detail_dispute_button')),
          findsOneWidget,
        );
        expect(
          find.byKey(const Key('order_detail_cancel_button')),
          findsNothing,
        );
        expect(find.text('320.000đ'), findsOneWidget);
      },
    );

    testWidgets(
      'WorkerJobsHubPage lists the worker jobs by status with the next-step action',
      (tester) async {
        await tester.binding.setSurfaceSize(const Size(800, 1600));
        addTearDown(() => tester.binding.setSurfaceSize(null));
        final jobs = MockBookingListCubit();
        whenListen(
          jobs,
          const Stream<BookingListState>.empty(),
          initialState: BookingListLoadedState(
            bookings: [
              pendingBooking,
              acceptedBooking,
              completedBooking,
              pendingBooking.copyWith(
                id: '504',
                status: BookingStatus.inProgress,
              ),
            ],
            categoryNames: const {'1': 'Sửa máy lạnh', '2': 'Vệ sinh nhà'},
            page: 0,
            hasMore: false,
          ),
        );

        await tester.pumpWidget(
          _createTestOrdersWidget(const WorkerJobsHubPage(), orders: jobs),
        );
        await tester.pumpAndSettle();

        expect(find.textContaining('Quản lý công việc'), findsOneWidget);
        // Assigned: the offer (accept) and the accepted job (start travelling).
        expect(find.text('#501'), findsOneWidget);
        expect(find.text('#502'), findsOneWidget);
        expect(find.text('Xem & Nhận việc'), findsOneWidget);
        expect(find.text('Bắt đầu di chuyển'), findsOneWidget);

        await tester.tap(find.byKey(const Key('worker_job_action_501')));
        await tester.pumpAndSettle();
        expect(find.text('JobDetail:501'), findsOneWidget);
        tester.state<NavigatorState>(find.byType(Navigator).last).pop();
        await tester.pumpAndSettle();

        await tester.tap(find.text('Đang làm'));
        await tester.pumpAndSettle();
        expect(find.text('#504'), findsOneWidget);
        expect(find.text('Tiếp tục công việc'), findsOneWidget);

        await tester.tap(find.text('Đã hoàn tất'));
        await tester.pumpAndSettle();
        expect(find.text('#503'), findsOneWidget);
        expect(find.text('320.000đ'), findsOneWidget);
        expect(find.byKey(const Key('worker_job_action_503')), findsNothing);
      },
    );
  });
}
