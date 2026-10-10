import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vstech_home_services/core/error/failure.dart';
import 'package:vstech_home_services/core/location/location_service.dart';
import 'package:vstech_home_services/core/network/network_exception.dart';
import 'package:vstech_home_services/core/router/app_routes.dart';
import 'package:vstech_home_services/core/theme/app_theme.dart';
import 'package:vstech_home_services/features/booking/presentation/bloc/booking_flow_bloc.dart';
import 'package:vstech_home_services/features/booking/presentation/pages/booking_step1_service_option_page.dart';
import 'package:vstech_home_services/features/booking/presentation/pages/booking_step2_schedule_address_page.dart';
import 'package:vstech_home_services/features/booking/presentation/pages/booking_step3_confirm_page.dart';
import 'package:vstech_home_services/features/booking/presentation/pages/booking_success_page.dart';
import 'package:vstech_home_services/features/booking/presentation/pages/dispatch_radar_matching_page.dart';
import 'package:vstech_home_services/features/booking/presentation/widgets/booking_step_indicator.dart';
import 'package:vstech_home_services/features/booking/presentation/widgets/radar_pulse_animation.dart';
import 'package:vstech_home_services/l10n/generated/app_localizations.dart';

import '../../fixtures/booking/booking_fixtures.dart';
import '../../helpers/mocks.dart';

Widget _createTestBookingWidget(Widget child, {MockBookingFlowBloc? bloc}) {
  final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(path: '/', builder: (context, state) => child),
      GoRoute(
        path: AppRoutes.bookingStep2,
        builder: (context, state) => const Scaffold(body: Text('Step2Target')),
      ),
      GoRoute(
        path: AppRoutes.bookingStep3,
        builder: (context, state) => const Scaffold(body: Text('Step3Target')),
      ),
      GoRoute(
        path: AppRoutes.bookingSuccess,
        builder: (context, state) => const Scaffold(body: Text('SuccessTarget')),
      ),
      GoRoute(path: AppRoutes.bookingMatching, builder: (context, state) => const DispatchRadarMatchingPage()),
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
  return bloc == null ? app : BlocProvider<BookingFlowBloc>.value(value: bloc, child: app);
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockBookingFlowBloc bloc;
  StreamController<BookingFlowState>? controller;

  /// Starts the mock bloc in [initial]; push later states through [states].
  void stubBloc(BookingFlowState initial) {
    controller = StreamController<BookingFlowState>.broadcast();
    whenListen(bloc, controller!.stream, initialState: initial);
  }

  setUpAll(() => registerFallbackValue(const BookingConfirmedEvent()));

  setUp(() => bloc = MockBookingFlowBloc());

  tearDown(() async {
    await controller?.close();
    controller = null;
  });

  group('Booking wizard — gọn theo API (estimate → schedule/address → confirm)', () {
    testWidgets('BookingStepIndicator renders active step and progress bars', (tester) async {
      stubBloc(const BookingFlowInitialState());
      await tester.binding.setSurfaceSize(const Size(390, 844));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(
        _createTestBookingWidget(
          const Scaffold(appBar: BookingStepIndicator(currentStep: 1, stepTitle: 'Mô tả vấn đề')),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Đặt lịch dịch vụ'), findsOneWidget);
      expect(find.text('Bước 1/3: Mô tả vấn đề'), findsOneWidget);
    });

    testWidgets('Step 1 starts the flow, requires a description and asks for an estimate', (tester) async {
      stubBloc(const BookingFlowEditingState(BookingDraft(categoryId: '1', category: acCategory)));
      await tester.binding.setSurfaceSize(const Size(390, 844));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(
        _createTestBookingWidget(const BookingStep1ServiceOptionPage(categoryId: '1'), bloc: bloc),
      );
      await tester.pumpAndSettle();

      expect(find.text('Sửa máy lạnh'), findsOneWidget);
      expect(find.text('Từ 200.000đ'), findsOneWidget);
      expect(find.text('Mô tả vấn đề cần xử lý'), findsOneWidget);
      // Add-ons / fixed tier prices are gone — the price comes from the server.
      expect(find.textContaining('30.000đ'), findsNothing);

      await tester.tap(find.byKey(const Key('booking_estimate_button')));
      await tester.pumpAndSettle();
      expect(find.text('Vui lòng nhập trường này'), findsOneWidget);
      verifyNever(() => bloc.add(any(that: isA<BookingEstimateRequestedEvent>())));

      await tester.enterText(find.byKey(const Key('booking_description_field')), 'Máy lạnh không mát');
      await tester.tap(find.byKey(const Key('booking_estimate_button')));
      await tester.pumpAndSettle();
      final event =
          verify(() => bloc.add(captureAny(that: isA<BookingEstimateRequestedEvent>()))).captured.single
              as BookingEstimateRequestedEvent;
      expect(event.description, 'Máy lạnh không mát');

      controller!.add(BookingFlowEstimatedState(readyDraft));
      await tester.pumpAndSettle();
      expect(find.text('Step2Target'), findsOneWidget);
    });

    testWidgets('Step 1 dispatches start for a new category and retries a failed load', (tester) async {
      stubBloc(
        const BookingFlowErrorState(BookingDraft(categoryId: '1'), Failure(kind: NetworkErrorKind.noConnection)),
      );

      await tester.pumpWidget(
        _createTestBookingWidget(const BookingStep1ServiceOptionPage(categoryId: '7'), bloc: bloc),
      );
      await tester.pumpAndSettle();

      final started =
          verify(() => bloc.add(captureAny(that: isA<BookingFlowStartedEvent>()))).captured.single
              as BookingFlowStartedEvent;
      expect(started.categoryId, '7');
      expect(find.textContaining('Không có kết nối mạng'), findsOneWidget);

      await tester.tap(find.byKey(const Key('error_retry_button')));
      verify(() => bloc.add(any(that: isA<BookingFlowStartedEvent>()))).called(1);
    });

    testWidgets('Step 2 disables past slots, prefills the address and submits the schedule', (tester) async {
      stubBloc(BookingFlowEditingState(readyDraft.copyWith(scheduledTime: null)));
      await tester.binding.setSurfaceSize(const Size(390, 1200));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(
        _createTestBookingWidget(BookingStep2ScheduleAddressPage(now: () => DateTime(2030, 1, 2, 11)), bloc: bloc),
      );
      await tester.pumpAndSettle();

      expect(find.text('123 Đường ABC, Quận 1'), findsOneWidget);
      expect(find.text('Đã xác định vị trí làm việc'), findsOneWidget);
      expect(find.text('02/01'), findsOneWidget);
      expect(tester.widget<ChoiceChip>(find.byKey(const Key('booking_slot_8'))).onSelected, isNull);
      expect(tester.widget<ChoiceChip>(find.byKey(const Key('booking_slot_14'))).selected, isTrue);
      expect(find.text('550.000đ'), findsOneWidget);

      await tester.tap(find.byKey(const Key('booking_slot_16')));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key('booking_schedule_continue_button')));
      await tester.pumpAndSettle();

      final event =
          verify(() => bloc.add(captureAny(that: isA<BookingScheduleSubmittedEvent>()))).captured.single
              as BookingScheduleSubmittedEvent;
      expect(event.scheduledTime, DateTime(2030, 1, 2, 16));
      expect(event.address, '123 Đường ABC, Quận 1');

      controller!.add(BookingFlowScheduledState(readyDraft));
      await tester.pumpAndSettle();
      expect(find.text('Step3Target'), findsOneWidget);
    });

    testWidgets('Step 2 without coordinates blocks continue and asks for the GPS position', (tester) async {
      stubBloc(BookingFlowEditingState(readyDraft.copyWith(location: null, scheduledTime: null)));
      await tester.binding.setSurfaceSize(const Size(390, 1200));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(
        _createTestBookingWidget(BookingStep2ScheduleAddressPage(now: () => DateTime(2030, 1, 2, 7)), bloc: bloc),
      );
      await tester.pumpAndSettle();

      expect(find.text('Chưa có vị trí — cần để thợ tìm đường'), findsOneWidget);
      await tester.tap(find.byKey(const Key('booking_schedule_continue_button')));
      verifyNever(() => bloc.add(any(that: isA<BookingScheduleSubmittedEvent>())));

      await tester.tap(find.byKey(const Key('booking_use_location_button')));
      verify(() => bloc.add(any(that: isA<BookingLocationRequestedEvent>()))).called(1);

      controller!.add(
        BookingFlowLocationFailedState(readyDraft.copyWith(location: null), LocationFailure.permissionDenied),
      );
      await tester.pumpAndSettle();
      expect(find.textContaining('chưa được cấp quyền vị trí'), findsOneWidget);
    });

    testWidgets('Step 3 shows the server estimate breakdown and confirms the booking', (tester) async {
      stubBloc(BookingFlowScheduledState(readyDraft));
      await tester.binding.setSurfaceSize(const Size(390, 1200));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(_createTestBookingWidget(const BookingStep3ConfirmPage(), bloc: bloc));
      await tester.pumpAndSettle();

      expect(find.text('Sửa máy lạnh'), findsOneWidget);
      expect(find.text('500.000đ'), findsOneWidget);
      expect(find.text('50.000đ'), findsOneWidget);
      expect(find.byKey(const Key('booking_total_estimated')), findsOneWidget);
      expect(find.text('Xác nhận đặt lịch · 550.000đ'), findsOneWidget);
      // No voucher or payment-method picker — the API has neither.
      expect(find.text('VNPay'), findsNothing);

      await tester.tap(find.byKey(const Key('booking_confirm_button')));
      verify(() => bloc.add(any(that: isA<BookingConfirmedEvent>()))).called(1);

      controller!.add(BookingFlowSubmittedState(readyDraft.copyWith(booking: pendingBooking)));
      await tester.pumpAndSettle();
      expect(find.text('SuccessTarget'), findsOneWidget);
    });

    testWidgets('BookingSuccessPage shows the created booking code and summary (Cell 46)', (tester) async {
      stubBloc(BookingFlowSubmittedState(readyDraft.copyWith(booking: pendingBooking)));
      await tester.binding.setSurfaceSize(const Size(390, 844));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(_createTestBookingWidget(const BookingSuccessPage(), bloc: bloc));
      await tester.pumpAndSettle();

      expect(find.text('Đặt lịch thành công'), findsOneWidget);
      expect(find.text('#501'), findsOneWidget);
      expect(find.text('Sửa máy lạnh'), findsOneWidget);
      expect(find.text('500.000đ'), findsOneWidget);
      expect(find.text('Sau khi nghiệm thu'), findsOneWidget);
      expect(find.text('Theo dõi đơn'), findsOneWidget);
    });

    testWidgets('DispatchRadarMatchingPage renders radar pulse animation and stages', (tester) async {
      await tester.binding.setSurfaceSize(const Size(390, 844));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      // Test Stage 0: Scanning
      await tester.pumpWidget(_createTestBookingWidget(const DispatchRadarMatchingPage()));
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.byType(RadarPulseAnimation), findsOneWidget);
      expect(find.text('2.5 km'), findsOneWidget);
      expect(find.text('Đang quét các Thợ đối tác trong bán kính 2.5 km...'), findsOneWidget);
      expect(find.text('Hủy tìm kiếm'), findsOneWidget);

      // Cancel button triggers confirm dialog
      await tester.tap(find.text('Hủy tìm kiếm'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));
      expect(find.text('Bạn có chắc chắn muốn hủy tìm kiếm không?'), findsOneWidget);
      await tester.tap(find.text('Không'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));
    });

    testWidgets('DispatchRadarMatchingPage renders matched partner worker at stage 2', (tester) async {
      await tester.binding.setSurfaceSize(const Size(390, 844));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      // Test Stage 2: Found worker
      await tester.pumpWidget(_createTestBookingWidget(const DispatchRadarMatchingPage(initialStage: 2)));
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.text('Nguyễn Văn Hùng'), findsOneWidget);
      expect(find.text('4.9 ★ • 120+ đơn hoàn tất'), findsOneWidget);
      expect(find.text('Anh Nguyễn Văn Hùng đã nhận việc và đang chuẩn bị di chuyển'), findsOneWidget);
      expect(find.text('Xem vị trí thợ đang di chuyển'), findsOneWidget);
    });

    testWidgets('DispatchRadarMatchingPage renders no-worker state with change time and free cancel (Cell 49)', (
      tester,
    ) async {
      await tester.binding.setSurfaceSize(const Size(390, 844));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(
        _createTestBookingWidget(
          const DispatchRadarMatchingPage(initialStage: DispatchRadarMatchingPage.stageNoWorker),
        ),
      );
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.byType(RadarPulseAnimation), findsNothing);
      expect(find.text('Chưa tìm được thợ'), findsOneWidget);
      expect(find.byKey(const Key('matching_change_time')), findsOneWidget);
      expect(find.byKey(const Key('matching_cancel_free')), findsOneWidget);
    });

    testWidgets('DispatchRadarMatchingPage shows worker-cancelled note while re-searching (Cell 118)', (tester) async {
      await tester.binding.setSurfaceSize(const Size(390, 844));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(_createTestBookingWidget(const DispatchRadarMatchingPage(isWorkerCancelled: true)));
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.byKey(const Key('worker_cancelled_note')), findsOneWidget);
      expect(find.textContaining('bạn không mất phí'), findsOneWidget);
    });
  });
}
