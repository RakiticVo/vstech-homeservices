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
import 'package:vstech_home_services/features/booking/domain/entities/quote_line.dart';
import 'package:vstech_home_services/features/tracking/presentation/pages/customer_tracking_page.dart';
import 'package:vstech_home_services/features/tracking/presentation/pages/worker_arrived_page.dart';
import 'package:vstech_home_services/features/tracking/presentation/pages/worker_en_route_page.dart';
import 'package:vstech_home_services/features/tracking/presentation/pages/worker_executing_page.dart';
import 'package:vstech_home_services/features/tracking/presentation/widgets/service_checklist_widget.dart';
import 'package:vstech_home_services/features/tracking/presentation/widgets/tracking_map_widget.dart';
import 'package:vstech_home_services/features/tracking/presentation/widgets/working_timer_widget.dart';
import 'package:vstech_home_services/features/worker_task/presentation/bloc/worker_task_cubit.dart';
import 'package:vstech_home_services/l10n/generated/app_localizations.dart';

import '../../fixtures/booking/booking_fixtures.dart';
import '../../helpers/mocks.dart';

Widget _createTestTrackingWidget(Widget child) {
  final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(path: '/', builder: (context, state) => child),
      GoRoute(
        path: AppRoutes.customerTracking,
        builder: (context, state) => const CustomerTrackingPage(),
      ),
      GoRoute(
        path: AppRoutes.workerEnRoute,
        builder: (context, state) =>
            Scaffold(body: Text('EnRoute:${state.uri.queryParameters['id']}')),
      ),
      GoRoute(
        path: AppRoutes.workerArrived,
        builder: (context, state) =>
            Scaffold(body: Text('Arrived:${state.uri.queryParameters['id']}')),
      ),
      GoRoute(
        path: AppRoutes.workerExecuting,
        builder: (context, state) => Scaffold(
          body: Text('Executing:${state.uri.queryParameters['id']}'),
        ),
      ),
      GoRoute(
        path: AppRoutes.workerJobCompletion,
        builder: (context, state) =>
            const Scaffold(body: Text('JobCompletionTarget')),
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

void main() {
  group('Batch 6: Job Tracking & Worker Progress Widget Tests', () {
    testWidgets(
      'CustomerTrackingPage renders Stage 1 (En Route) with map, ETA, and worker card',
      (tester) async {
        await tester.binding.setSurfaceSize(const Size(390, 1600));

        await tester.pumpWidget(
          _createTestTrackingWidget(const CustomerTrackingPage()),
        );
        await tester.pump();

        // Header and order code
        expect(find.text('Tiến độ công việc'), findsOneWidget);
        expect(find.text('Mã đơn: #HS-2026-0012'), findsOneWidget);

        // Stage 1 elements
        expect(find.byType(TrackingMapWidget), findsOneWidget);
        expect(find.text('Dự kiến đến sau 8 phút · 2.4 km'), findsOneWidget);

        // Worker Info card
        expect(find.text('Nguyễn Văn Hùng'), findsOneWidget);
        expect(find.text('4.9 ★ (128 việc)'), findsOneWidget);
        expect(find.text('Gọi ẩn danh'), findsOneWidget);
        expect(find.text('Nhắn tin'), findsOneWidget);
      },
    );

    testWidgets(
      'CustomerTrackingPage stage selector switches across all 4 stages',
      (tester) async {
        await tester.binding.setSurfaceSize(const Size(390, 1600));

        await tester.pumpWidget(
          _createTestTrackingWidget(const CustomerTrackingPage()),
        );
        await tester.pump();

        // Switch to Stage 2: Thợ đã đến
        await tester.ensureVisible(find.text('Thợ đã đến'));
        await tester.tap(find.text('Thợ đã đến'), warnIfMissed: false);
        await tester.pump();
        expect(find.text('Thợ đã có mặt lúc 13:58'), findsOneWidget);

        // Switch to Stage 3: Đang thực hiện
        await tester.ensureVisible(find.text('Đang thực hiện'));
        await tester.tap(find.text('Đang thực hiện'), warnIfMissed: false);
        await tester.pump();
        expect(find.byType(WorkingTimerWidget), findsOneWidget);
        expect(find.byType(ServiceChecklistWidget), findsOneWidget);

        // Switch to Stage 4: Chờ nghiệm thu
        await tester.ensureVisible(find.text('Chờ nghiệm thu'));
        await tester.tap(find.text('Chờ nghiệm thu'), warnIfMissed: false);
        await tester.pump();
        expect(find.text('Tiến hành nghiệm thu'), findsOneWidget);
      },
    );

    testWidgets(
      'WorkerEnRoutePage renders map, address, customer note, and arrival CTA',
      (tester) async {
        await tester.binding.setSurfaceSize(const Size(390, 1600));

        await tester.pumpWidget(
          _createTestTrackingWidget(const WorkerEnRoutePage(bookingId: '502')),
        );
        await tester.pump();

        expect(find.text('Đang di chuyển đến khách'), findsOneWidget);
        expect(find.byType(TrackingMapWidget), findsOneWidget);
        expect(find.text('Mở Google Maps dẫn đường'), findsOneWidget);
        expect(
          find.text('Căn hộ 802, Tháp B, Chung cư Flora Novia'),
          findsOneWidget,
        );
        expect(
          find.text('Ghi chú: Gọi trước khi đến, gửi xe hầm B2'),
          findsOneWidget,
        );
        expect(find.text('Tôi đã đến nơi'), findsOneWidget);
        expect(find.text('Huỷ việc'), findsOneWidget);

        await tester.tap(find.text('Tôi đã đến nơi'));
        await tester.pumpAndSettle();
        expect(find.text('Arrived:502'), findsOneWidget);
      },
    );

    testWidgets(
      'WorkerArrivedPage starts the job via the API and opens the executing screen',
      (tester) async {
        await tester.binding.setSurfaceSize(const Size(390, 1600));
        addTearDown(() => tester.binding.setSurfaceSize(null));
        final task = MockWorkerTaskCubit();
        final states = StreamController<WorkerTaskState>.broadcast();
        addTearDown(states.close);
        final data = WorkerTaskData(booking: acceptedBooking);
        whenListen(
          task,
          states.stream,
          initialState: WorkerTaskReadyState(data),
        );
        when(() => task.load(any())).thenAnswer((_) async {});
        when(task.start).thenAnswer((_) async {});

        await tester.pumpWidget(
          _createTestTrackingWidget(
            BlocProvider<WorkerTaskCubit>.value(
              value: task,
              child: const WorkerArrivedPage(bookingId: '502'),
            ),
          ),
        );
        await tester.pump();

        expect(find.text('Xác nhận có mặt'), findsOneWidget);
        await tester.tap(find.byKey(const Key('worker_start_job_button')));
        verify(task.start).called(1);

        states.add(
          WorkerTaskActionDoneState(
            WorkerTaskData(
              booking: acceptedBooking.copyWith(
                status: BookingStatus.inProgress,
              ),
            ),
            WorkerTaskAction.start,
          ),
        );
        await tester.pumpAndSettle();
        expect(find.text('Executing:502'), findsOneWidget);
      },
    );

    testWidgets(
      'WorkerExecutingPage sends an extra-cost quote and completes with the final price',
      (tester) async {
        await tester.binding.setSurfaceSize(const Size(390, 1600));
        addTearDown(() => tester.binding.setSurfaceSize(null));
        final task = MockWorkerTaskCubit();
        final states = StreamController<WorkerTaskState>.broadcast();
        addTearDown(states.close);
        final inProgress = acceptedBooking.copyWith(
          status: BookingStatus.inProgress,
        );
        whenListen(
          task,
          states.stream,
          initialState: WorkerTaskReadyState(
            WorkerTaskData(booking: inProgress),
          ),
        );
        when(() => task.load(any())).thenAnswer((_) async {});
        when(() => task.submitQuote(any())).thenAnswer((_) async {});
        when(() => task.complete(any())).thenAnswer((_) async {});

        await tester.pumpWidget(
          _createTestTrackingWidget(
            BlocProvider<WorkerTaskCubit>.value(
              value: task,
              child: const WorkerExecutingPage(bookingId: '502'),
            ),
          ),
        );
        await tester.pump();

        expect(find.text('Đang thực hiện công việc'), findsOneWidget);
        expect(find.byType(WorkingTimerWidget), findsOneWidget);
        expect(find.byType(ServiceChecklistWidget), findsOneWidget);

        // Extra-cost quote → POST /bookings/{id}/quote
        await tester.tap(find.text('+ Đề xuất chi phí phát sinh'));
        await tester.pumpAndSettle();
        await tester.enterText(
          find.byKey(const Key('worker_extra_cost_name')),
          'Gas R32',
        );
        await tester.enterText(
          find.byKey(const Key('worker_extra_cost_price')),
          '45.000',
        );
        await tester.tap(find.byKey(const Key('worker_extra_cost_send')));
        await tester.pumpAndSettle();
        final lines =
            verify(() => task.submitQuote(captureAny())).captured.single
                as List<QuoteLine>;
        expect(lines.single.itemName, 'Gas R32');
        expect(lines.single.amount, 45000);

        final quoted = WorkerTaskData(booking: inProgress, quotedExtra: 45000);
        states.add(WorkerTaskActionDoneState(quoted, WorkerTaskAction.quote));
        await tester.pumpAndSettle();
        expect(find.text('Đã gửi đề xuất thành công!'), findsOneWidget);

        // Complete → final price pre-filled with estimate + extras
        when(() => task.state).thenReturn(WorkerTaskReadyState(quoted));
        await tester.tap(find.byKey(const Key('worker_complete_job_button')));
        await tester.pumpAndSettle();
        expect(find.text('545000'), findsOneWidget);
        await tester.tap(find.byKey(const Key('worker_final_price_confirm')));
        await tester.pumpAndSettle();
        verify(() => task.complete(545000)).called(1);

        states.add(
          WorkerTaskActionDoneState(
            WorkerTaskData(
              booking: inProgress.copyWith(status: BookingStatus.completed),
            ),
            WorkerTaskAction.complete,
          ),
        );
        await tester.pumpAndSettle();
        expect(find.text('JobCompletionTarget'), findsOneWidget);
      },
    );
  });
}
