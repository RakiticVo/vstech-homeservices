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
        path: AppRoutes.workerQuote,
        builder: (context, state) => Scaffold(
          body: TextButton(
            onPressed: () => context.pop(true),
            child: Text('Quote:${state.uri.queryParameters['id']}'),
          ),
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
      'WorkerExecutingPage opens the quote screen, shows its status and completes with the final price',
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
        when(task.refreshQuote).thenReturn(null);
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

        // Extra-cost quote → its own screen; back with `true` → refresh + SnackBar.
        await tester.tap(find.text('+ Báo giá phát sinh'));
        await tester.pumpAndSettle();
        await tester.tap(find.text('Quote:502'));
        await tester.pumpAndSettle();
        verify(task.refreshQuote).called(1);
        expect(find.text('Đã gửi báo giá cho khách'), findsOneWidget);

        // Pending quote → status card, no second quote button.
        final quoted = WorkerTaskData(
          booking: inProgress,
          quote: SubmittedQuote(
            bookingId: '502',
            status: QuoteStatus.pending,
            lines: const [QuoteLine(itemName: 'Gas R32', amount: 45000)],
            totalAmount: 45000,
            submittedAt: DateTime.utc(2026, 10, 12, 7, 30),
          ),
        );
        states.add(WorkerTaskReadyState(quoted));
        await tester.pumpAndSettle();
        expect(find.byKey(const Key('quote_status_pending')), findsOneWidget);
        expect(find.text('Đang chờ khách duyệt'), findsOneWidget);
        expect(find.byKey(const Key('worker_extra_cost_button')), findsNothing);

        // Complete → final price pre-filled with estimate + the pending quote.
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

    testWidgets(
      'WorkerExecutingPage: a declined quote offers Message / Continue and hides Complete until chosen',
      (tester) async {
        await tester.binding.setSurfaceSize(const Size(390, 1600));
        addTearDown(() => tester.binding.setSurfaceSize(null));
        final task = MockWorkerTaskCubit();
        final inProgress = acceptedBooking.copyWith(
          status: BookingStatus.inProgress,
        );
        whenListen(
          task,
          const Stream<WorkerTaskState>.empty(),
          initialState: WorkerTaskReadyState(
            WorkerTaskData(
              booking: inProgress,
              quote: const SubmittedQuote(
                bookingId: '502',
                status: QuoteStatus.rejected,
                lines: [QuoteLine(itemName: 'Gas R32', amount: 45000)],
                totalAmount: 45000,
              ),
            ),
          ),
        );
        when(() => task.load(any())).thenAnswer((_) async {});

        await tester.pumpWidget(
          _createTestTrackingWidget(
            BlocProvider<WorkerTaskCubit>.value(
              value: task,
              child: const WorkerExecutingPage(bookingId: '502'),
            ),
          ),
        );
        await tester.pump();

        expect(find.text('Khách đã từ chối'), findsOneWidget);
        expect(find.byKey(const Key('quote_message_button')), findsOneWidget);
        expect(
          find.byKey(const Key('worker_complete_job_button')),
          findsNothing,
        );

        await tester.tap(find.byKey(const Key('quote_continue_button')));
        await tester.pump();
        expect(find.byKey(const Key('quote_status_rejected')), findsNothing);
        expect(
          find.byKey(const Key('worker_complete_job_button')),
          findsOneWidget,
        );
        expect(
          find.byKey(const Key('worker_extra_cost_button')),
          findsOneWidget,
        );
      },
    );
  });
}
