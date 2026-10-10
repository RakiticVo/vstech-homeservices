import 'dart:async';

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
import 'package:vstech_home_services/features/booking/domain/entities/booking_status.dart';
import 'package:vstech_home_services/features/exceptions/presentation/bloc/booking_action_cubit.dart';
import 'package:vstech_home_services/features/exceptions/presentation/pages/customer_cancellation_page.dart';
import 'package:vstech_home_services/features/exceptions/presentation/pages/customer_dispute_list_page.dart';
import 'package:vstech_home_services/features/exceptions/presentation/pages/customer_no_show_page.dart';
import 'package:vstech_home_services/features/exceptions/presentation/pages/dispute_detail_page.dart';
import 'package:vstech_home_services/features/exceptions/presentation/pages/dispute_report_page.dart';
import 'package:vstech_home_services/features/exceptions/presentation/pages/order_disputed_page.dart';
import 'package:vstech_home_services/features/exceptions/presentation/pages/worker_cancellation_page.dart';
import 'package:vstech_home_services/features/exceptions/presentation/pages/worker_dispute_notification_page.dart';
import 'package:vstech_home_services/l10n/generated/app_localizations.dart';

import '../../helpers/mocks.dart';

Widget _createTestExceptionsWidget(Widget child, {MockBookingActionCubit? action}) {
  final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(path: '/', builder: (context, state) => child),
      GoRoute(
        path: AppRoutes.customerCancel,
        builder: (context, state) => BlocProvider<BookingActionCubit>.value(
          value: action ?? MockBookingActionCubit(),
          child: CustomerCancellationPage(bookingId: state.uri.queryParameters['id'] ?? ''),
        ),
      ),
      GoRoute(path: AppRoutes.workerCancel, builder: (context, state) => const WorkerCancellationPage()),
      GoRoute(path: AppRoutes.customerNoShow, builder: (context, state) => const CustomerNoShowPage()),
      GoRoute(
        path: AppRoutes.disputeReport,
        builder: (context, state) => BlocProvider<BookingActionCubit>.value(
          value: action ?? MockBookingActionCubit(),
          child: DisputeReportPage(bookingId: state.uri.queryParameters['id'] ?? ''),
        ),
      ),
      GoRoute(path: AppRoutes.orderDisputed, builder: (context, state) => const OrderDisputedPage()),
      GoRoute(path: AppRoutes.customerDisputeList, builder: (context, state) => const CustomerDisputeListPage()),
      GoRoute(path: AppRoutes.disputeDetail, builder: (context, state) => const DisputeDetailPage()),
      GoRoute(
        path: AppRoutes.workerDisputeNotification,
        builder: (context, state) => const WorkerDisputeNotificationPage(),
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
  group('Batch 9: Exceptions, Cancellation & Escrow Dispute Widget Tests', () {
    testWidgets('CustomerCancellationPage confirms and cancels the booking by id', (tester) async {
      final action = MockBookingActionCubit();
      final states = StreamController<BookingActionState>.broadcast();
      addTearDown(states.close);
      whenListen(action, states.stream, initialState: const BookingActionIdleState());
      when(() => action.cancel(any()))
          .thenAnswer((_) async => states.add(const BookingActionDoneState(BookingStatus.cancelled)));

      await tester.pumpWidget(
        _createTestExceptionsWidget(const _Launcher(location: '/customer/booking/cancel?id=501'), action: action),
      );
      await tester.tap(find.text('open'));
      await tester.pumpAndSettle();

      expect(find.text('Huỷ đặt lịch'), findsOneWidget);
      expect(find.text('Mã đơn hàng: #501'), findsOneWidget);
      // The API takes no reason, so none is asked for.
      expect(find.text('Lý do huỷ'), findsNothing);

      await tester.tap(find.byKey(const Key('booking_action_confirm_button')));
      await tester.pumpAndSettle();

      verify(() => action.cancel('501')).called(1);
      expect(find.text('Đã huỷ đơn đặt lịch'), findsOneWidget);
      expect(find.text('open'), findsOneWidget, reason: 'returns to the previous screen');
    });

    testWidgets('CustomerCancellationPage shows API errors without leaving', (tester) async {
      final action = MockBookingActionCubit();
      final states = StreamController<BookingActionState>.broadcast();
      addTearDown(states.close);
      whenListen(action, states.stream, initialState: const BookingActionIdleState());
      when(() => action.cancel(any())).thenAnswer(
        (_) async => states.add(
          const BookingActionFailedState(Failure(kind: NetworkErrorKind.server, errorCode: 'HS-400-0010')),
        ),
      );

      await tester.pumpWidget(
        _createTestExceptionsWidget(const _Launcher(location: '/customer/booking/cancel?id=501'), action: action),
      );
      await tester.tap(find.text('open'));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key('booking_action_confirm_button')));
      await tester.pumpAndSettle();

      expect(find.text('Không thể thực hiện thao tác này ở trạng thái hiện tại.'), findsOneWidget);
      expect(find.byType(CustomerCancellationPage), findsOneWidget);
    });

    testWidgets('DisputeReportPage disputes the booking and opens the disputed screen', (tester) async {
      final action = MockBookingActionCubit();
      final states = StreamController<BookingActionState>.broadcast();
      addTearDown(states.close);
      whenListen(action, states.stream, initialState: const BookingActionIdleState());
      when(() => action.dispute(any()))
          .thenAnswer((_) async => states.add(const BookingActionDoneState(BookingStatus.dispute)));

      await tester.pumpWidget(
        _createTestExceptionsWidget(const _Launcher(location: '/customer/order/dispute?id=503'), action: action),
      );
      await tester.tap(find.text('open'));
      await tester.pumpAndSettle();

      expect(find.text('Mã đơn hàng: #503'), findsOneWidget);
      await tester.tap(find.byKey(const Key('booking_action_confirm_button')));
      await tester.pumpAndSettle();

      verify(() => action.dispute('503')).called(1);
      expect(find.byType(OrderDisputedPage), findsOneWidget);
    });

    testWidgets('WorkerCancellationPage renders penalty warning and options', (tester) async {
      await tester.binding.setSurfaceSize(const Size(390, 1400));
      await tester.pumpWidget(_createTestExceptionsWidget(const WorkerCancellationPage()));
      await tester.pumpAndSettle();

      // Header and warning
      expect(find.textContaining('Huỷ nhận việc'), findsOneWidget);
      expect(find.textContaining('96% xuống 95%'), findsOneWidget);

      // Reason chips
      expect(find.textContaining('Hỏng xe hoặc sự cố giao thông'), findsOneWidget);
      expect(find.textContaining('Việc gia đình khẩn cấp'), findsOneWidget);

      // Buttons
      expect(find.textContaining('Tiếp tục công việc'), findsOneWidget);
      expect(find.textContaining('Xác nhận huỷ việc'), findsOneWidget);
    });

    testWidgets('CustomerNoShowPage navigates from waiting timer to reporting and completion with compensation', (
      tester,
    ) async {
      await tester.binding.setSurfaceSize(const Size(390, 1400));
      await tester.pumpWidget(_createTestExceptionsWidget(const CustomerNoShowPage()));
      await tester.pump();

      // Waiting view
      expect(find.textContaining('Chờ khách hàng'), findsOneWidget);
      expect(find.textContaining('15 phút'), findsOneWidget);
      expect(find.textContaining('Gọi điện nhắc khách'), findsOneWidget);
      expect(find.textContaining('Nhắn tin nhắc khách'), findsOneWidget);
      expect(find.textContaining('Báo khách vắng mặt'), findsOneWidget);

      // Tap report button
      await tester.tap(find.textContaining('Báo khách vắng mặt'));
      await tester.pump();

      // Reporting view
      expect(find.textContaining('Chụp ảnh cửa nhà / hiện trường'), findsOneWidget);
      expect(find.textContaining('Gửi biên bản vắng mặt'), findsOneWidget);

      // Tap submit report
      await tester.tap(find.textContaining('Gửi biên bản vắng mặt'));
      await tester.pump();

      // Completed view with compensation
      expect(find.textContaining('Đã ghi nhận vắng mặt'), findsWidgets);
      expect(find.text('+50.000đ'), findsOneWidget);
      expect(find.textContaining('Về danh sách việc'), findsOneWidget);
    });

    testWidgets('OrderDisputedPage renders complaint code and 3-step resolution timeline', (tester) async {
      await tester.binding.setSurfaceSize(const Size(390, 1400));
      await tester.pumpWidget(_createTestExceptionsWidget(const OrderDisputedPage()));
      await tester.pumpAndSettle();

      expect(find.textContaining('Đơn đang được xem xét'), findsWidgets);
      expect(find.textContaining('#KN-0425-031'), findsOneWidget);
      expect(find.textContaining('Được bảo vệ bởi VSTech Escrow'), findsOneWidget);
      expect(find.textContaining('Quy trình giải quyết khiếu nại'), findsOneWidget);
      expect(find.textContaining('Xem danh sách khiếu nại'), findsOneWidget);
      expect(find.textContaining('Về chi tiết đơn hàng'), findsOneWidget);
    });

    testWidgets('CustomerDisputeListPage switches across 4 tabs and renders cards', (tester) async {
      await tester.binding.setSurfaceSize(const Size(600, 1400));
      await tester.pumpWidget(_createTestExceptionsWidget(const CustomerDisputeListPage()));
      await tester.pumpAndSettle();

      expect(find.textContaining('Khiếu nại của tôi'), findsOneWidget);

      // Reviewing tab
      expect(find.text('#KN-0425-031'), findsOneWidget);
      expect(find.textContaining('Vệ sinh máy lạnh'), findsOneWidget);

      // Tap Needs Info tab
      await tester.tap(find.text('Cần bổ sung'));
      await tester.pumpAndSettle();
      expect(find.text('#KN-0420-028'), findsOneWidget);

      // Tap Resolved tab
      await tester.tap(find.text('Đã giải quyết'));
      await tester.pumpAndSettle();
      expect(find.text('#KN-0228-014'), findsOneWidget);
      expect(find.textContaining('ZaloPay'), findsOneWidget);

      // Tap Closed tab
      await tester.tap(find.text('Đã đóng'));
      await tester.pumpAndSettle();
      expect(find.text('#KN-0115-002'), findsOneWidget);
    });

    testWidgets('DisputeDetailPage renders resolved complaint with refund summary', (tester) async {
      await tester.binding.setSurfaceSize(const Size(390, 1400));
      await tester.pumpWidget(_createTestExceptionsWidget(const DisputeDetailPage()));
      await tester.pumpAndSettle();

      expect(find.text('#KN-0228-014'), findsOneWidget);
      expect(find.textContaining('HS-2026-0054'), findsOneWidget);
      expect(find.textContaining('Kết quả xử lý'), findsOneWidget);
      expect(find.textContaining('Hoàn tiền 100.000đ'), findsOneWidget);
      expect(find.textContaining('Đóng chi tiết khiếu nại'), findsOneWidget);
    });

    testWidgets('WorkerDisputeNotificationPage renders escrow hold notice and reply form', (tester) async {
      await tester.binding.setSurfaceSize(const Size(390, 1400));
      await tester.pumpWidget(_createTestExceptionsWidget(const WorkerDisputeNotificationPage()));
      await tester.pumpAndSettle();

      expect(find.textContaining('Khách hàng khiếu nại'), findsOneWidget);
      expect(find.textContaining('Tiền công đang tạm giữ'), findsOneWidget);
      expect(find.textContaining('340.000đ'), findsOneWidget);
      expect(find.textContaining('Nội dung khiếu nại'), findsOneWidget);
      expect(find.textContaining('Gửi giải trình'), findsOneWidget);
    });
  });
}

/// Root screen that pushes [location], so pages that pop on success have somewhere to return to.
class _Launcher extends StatelessWidget {
  const _Launcher({required this.location});

  final String location;

  @override
  Widget build(BuildContext context) => Scaffold(
    body: TextButton(onPressed: () => context.push(location), child: const Text('open')),
  );
}
