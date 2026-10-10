import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vstech_home_services/core/location/location_service.dart';
import 'package:vstech_home_services/core/router/app_routes.dart';
import 'package:vstech_home_services/core/theme/app_theme.dart';
import 'package:vstech_home_services/features/booking/domain/entities/booking.dart';
import 'package:vstech_home_services/features/booking/domain/entities/booking_status.dart';
import 'package:vstech_home_services/features/orders/presentation/bloc/booking_list_cubit.dart';
import 'package:vstech_home_services/features/worker_dashboard/presentation/bloc/worker_presence_cubit.dart';
import 'package:vstech_home_services/features/worker_dashboard/presentation/pages/worker_dashboard_page.dart';
import 'package:vstech_home_services/features/worker_dashboard/presentation/widgets/worker_earnings_card.dart';
import 'package:vstech_home_services/features/worker_dashboard/presentation/widgets/worker_floating_dock.dart';
import 'package:vstech_home_services/features/worker_dashboard/presentation/widgets/worker_job_request_card.dart';
import 'package:vstech_home_services/features/worker_dispatch/presentation/pages/worker_job_detail_page.dart';
import 'package:vstech_home_services/features/worker_kyc/presentation/pages/worker_kyc_status_page.dart';
import 'package:vstech_home_services/features/worker_kyc/presentation/pages/worker_kyc_wizard_page.dart';
import 'package:vstech_home_services/features/worker_task/presentation/bloc/worker_task_cubit.dart';
import 'package:vstech_home_services/l10n/generated/app_localizations.dart';

import '../../fixtures/booking/booking_fixtures.dart';
import '../../helpers/mocks.dart';

Widget _createTestWorkerWidget(Widget child, {MockWorkerPresenceCubit? presence, MockBookingListCubit? jobs}) {
  final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(path: '/', builder: (context, state) => child),
      GoRoute(path: AppRoutes.workerDashboard, builder: (context, state) => const WorkerDashboardPage()),
      GoRoute(
        path: AppRoutes.workerEnRoute,
        builder: (context, state) => Scaffold(body: Text('EnRoute:${state.uri.queryParameters['id']}')),
      ),
      GoRoute(
        path: AppRoutes.workerKyc,
        builder: (context, state) {
          final step = int.tryParse(state.uri.queryParameters['step'] ?? '2') ?? 2;
          return WorkerKycWizardPage(initialStep: step);
        },
      ),
      GoRoute(
        path: AppRoutes.workerKycStatus,
        builder: (context, state) {
          final status = state.uri.queryParameters['status'] ?? 'pending';
          return WorkerKycStatusPage(initialStatus: status);
        },
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
      BlocProvider<WorkerPresenceCubit>.value(value: presence ?? _onlinePresence()),
      BlocProvider<BookingListCubit>.value(value: jobs ?? _jobs([])),
    ],
    child: app,
  );
}

MockBookingListCubit _jobs(List<Booking> bookings) {
  final cubit = MockBookingListCubit();
  whenListen(
    cubit,
    const Stream<BookingListState>.empty(),
    initialState: BookingListLoadedState(
      bookings: bookings,
      categoryNames: const {'1': 'Sửa máy lạnh'},
      page: 0,
      hasMore: false,
    ),
  );
  return cubit;
}

MockWorkerPresenceCubit _onlinePresence() {
  final cubit = MockWorkerPresenceCubit();
  whenListen(cubit, const Stream<WorkerPresenceState>.empty(), initialState: const WorkerOnlineState());
  return cubit;
}

void main() {
  group('Batch 4 Worker Dashboard & KYC Widget Tests', () {
    testWidgets('WorkerDashboardPage renders header, earnings card, job request, and dock', (tester) async {
      await tester.pumpWidget(
        _createTestWorkerWidget(const WorkerDashboardPage(), jobs: _jobs([pendingBooking, acceptedBooking])),
      );
      await tester.pumpAndSettle();

      // Verify Greeting and Online Status
      expect(find.textContaining('Chào anh Hùng,'), findsOneWidget);
      expect(find.text('Đang online'), findsOneWidget);

      // Verify Deep Teal Earnings Card
      expect(find.byType(WorkerEarningsCard), findsOneWidget);
      expect(find.text('340.000đ'), findsWidgets);
      expect(find.text('1/3'), findsOneWidget);
      expect(find.text('4.9 ★'), findsOneWidget);
      expect(find.text('96%'), findsOneWidget);

      // New job card = the first PENDING booking from GET /bookings
      expect(find.byType(WorkerJobRequestCard), findsOneWidget);
      expect(find.byKey(const Key('worker_job_offer_501')), findsOneWidget);
      expect(find.text('Yêu cầu việc mới'), findsOneWidget);
      expect(find.text('Sửa máy lạnh'), findsOneWidget);
      expect(find.text('123 Đường ABC, Quận 1'), findsOneWidget);
      expect(find.text('Xem & Nhận việc'), findsOneWidget);

      // Verify Floating Bottom Dock
      expect(find.byType(WorkerFloatingDock), findsOneWidget);
      expect(find.text('Việc'), findsOneWidget);

      // Toggling Online/Offline is covered by the WorkerPresenceCubit test below.
    });

    testWidgets('WorkerJobDetailPage shows the booking and accepts it via the API', (tester) async {
      final task = MockWorkerTaskCubit();
      final states = StreamController<WorkerTaskState>.broadcast();
      addTearDown(states.close);
      final data = WorkerTaskData(booking: pendingBooking, serviceName: 'Sửa máy lạnh');
      whenListen(task, states.stream, initialState: WorkerTaskReadyState(data));
      when(() => task.load(any())).thenAnswer((_) async {});
      when(task.accept).thenAnswer((_) async {});

      await tester.pumpWidget(
        _createTestWorkerWidget(
          BlocProvider<WorkerTaskCubit>.value(
            value: task,
            child: const WorkerJobDetailPage(bookingId: '501'),
          ),
        ),
      );
      await tester.pumpAndSettle();

      verify(() => task.load('501')).called(1);
      expect(find.text('Mã đơn hàng: #501'), findsOneWidget);
      expect(find.text('Sửa máy lạnh'), findsOneWidget);
      expect(find.text('Máy lạnh không mát'), findsOneWidget);
      expect(find.text('500.000đ'), findsOneWidget);

      await tester.tap(find.text('Nhận việc ngay'));
      verify(task.accept).called(1);

      states.add(
        WorkerTaskActionDoneState(
          WorkerTaskData(
            booking: pendingBooking.copyWith(status: BookingStatus.accepted),
            serviceName: 'Sửa máy lạnh',
          ),
          WorkerTaskAction.accept,
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('Đã nhận việc thành công! Vui lòng chuẩn bị di chuyển'), findsOneWidget);
      expect(find.text('EnRoute:501'), findsOneWidget);
    });

    testWidgets('WorkerDashboardPage offer opens the job by id and decline hides it locally', (tester) async {
      await tester.pumpWidget(_createTestWorkerWidget(const WorkerDashboardPage(), jobs: _jobs([pendingBooking])));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('worker_job_request_decline')));
      await tester.pumpAndSettle();
      expect(find.byType(WorkerJobRequestCard), findsNothing);
    });

    testWidgets('WorkerDashboardPage online toggle drives WorkerPresenceCubit and reports GPS errors', (tester) async {
      final presence = MockWorkerPresenceCubit();
      final states = StreamController<WorkerPresenceState>.broadcast();
      addTearDown(states.close);
      whenListen(presence, states.stream, initialState: const WorkerOfflineState());
      when(presence.toggle).thenAnswer((_) async {});

      await tester.pumpWidget(_createTestWorkerWidget(const WorkerDashboardPage(), presence: presence));
      await tester.pumpAndSettle();

      expect(find.text('Nghỉ ngơi'), findsOneWidget);
      // Offline workers get no job offers.
      expect(find.byType(WorkerJobRequestCard), findsNothing);

      await tester.tap(find.byKey(const Key('worker_online_toggle')));
      verify(presence.toggle).called(1);

      states.add(const WorkerPresenceErrorState(LocationFailure.permissionDenied));
      await tester.pumpAndSettle();
      expect(find.textContaining('chưa được cấp quyền vị trí'), findsOneWidget);
    });

    testWidgets('WorkerKycWizardPage progresses through steps and validates input', (tester) async {
      await tester.pumpWidget(_createTestWorkerWidget(const WorkerKycWizardPage()));
      await tester.pumpAndSettle();

      // Step 2
      expect(find.text('Bước 2/6'), findsOneWidget);
      expect(find.text('Thông tin cá nhân & Khu vực'), findsOneWidget);

      // Tap Next to Step 3
      await tester.tap(find.text('Tiếp tục'));
      await tester.pumpAndSettle();

      // Step 3
      expect(find.text('Bước 3/6'), findsOneWidget);
      expect(find.text('Xác minh Căn cước công dân'), findsOneWidget);
      // Next is disabled initially because ID is not captured
      final nextButtonFinder = find.widgetWithText(ElevatedButton, 'Tiếp tục');
      final btn = tester.widget<ElevatedButton>(nextButtonFinder);
      expect(btn.onPressed, isNull);

      // Capture front and back ID
      await tester.tap(find.text('Mặt trước CCCD'));
      await tester.tap(find.text('Mặt sau CCCD'));
      await tester.pumpAndSettle();

      final updatedBtn = tester.widget<ElevatedButton>(nextButtonFinder);
      expect(updatedBtn.onPressed, isNotNull);

      // Tap Next to Step 4
      await tester.tap(find.text('Tiếp tục'));
      await tester.pumpAndSettle();

      // Step 4
      expect(find.text('Bước 4/6'), findsOneWidget);
      expect(find.text('Chụp ảnh selfie chân dung'), findsOneWidget);

      // Capture selfie
      await tester.tap(find.text('Chụp ảnh khuôn mặt'));
      await tester.pumpAndSettle();

      // Tap Next to Step 5
      await tester.tap(find.text('Tiếp tục'));
      await tester.pumpAndSettle();

      // Step 5
      expect(find.text('Bước 5/6'), findsOneWidget);
      expect(find.text('Chuyên môn & Chứng chỉ'), findsOneWidget);

      // Upload cert
      await tester.tap(find.text('Chứng chỉ an toàn lao động'));
      await tester.pumpAndSettle();

      // Tap Next to Step 6
      await tester.tap(find.text('Tiếp tục'));
      await tester.pumpAndSettle();

      // Step 6
      expect(find.text('Bước 6/6'), findsOneWidget);
      expect(find.text('Tài khoản ngân hàng nhận tiền'), findsOneWidget);
      expect(find.text('Gửi hồ sơ xét duyệt'), findsOneWidget);
    });

    testWidgets('WorkerKycStatusPage supports pending, needs, and approved states', (tester) async {
      await tester.pumpWidget(_createTestWorkerWidget(const WorkerKycStatusPage()));
      await tester.pumpAndSettle();

      // Pending state
      expect(find.text('Trạng thái hồ sơ'), findsOneWidget);
      expect(find.text('Hồ sơ đang được xét duyệt'), findsOneWidget);
      expect(find.text('Quay lại'), findsOneWidget);

      // Switch to 'Cần bổ sung' state
      await tester.tap(find.text('Cần bổ sung'));
      await tester.pumpAndSettle();
      expect(find.text('Cần bổ sung thông tin'), findsOneWidget);
      expect(find.text('Bổ sung ảnh CCCD'), findsOneWidget);

      // Switch to 'Đã duyệt' state
      await tester.tap(find.text('Đã duyệt'));
      await tester.pumpAndSettle();
      expect(find.text('Hồ sơ đã được phê duyệt! 🎉'), findsOneWidget);
      expect(find.text('Bắt đầu nhận việc'), findsOneWidget);
    });
  });
}
