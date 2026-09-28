import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:vstech_home_services/core/router/app_routes.dart';
import 'package:vstech_home_services/core/theme/app_theme.dart';
import 'package:vstech_home_services/features/exceptions/presentation/pages/customer_cancellation_page.dart';
import 'package:vstech_home_services/features/exceptions/presentation/pages/customer_dispute_list_page.dart';
import 'package:vstech_home_services/features/exceptions/presentation/pages/customer_no_show_page.dart';
import 'package:vstech_home_services/features/exceptions/presentation/pages/dispute_detail_page.dart';
import 'package:vstech_home_services/features/exceptions/presentation/pages/dispute_report_page.dart';
import 'package:vstech_home_services/features/exceptions/presentation/pages/order_disputed_page.dart';
import 'package:vstech_home_services/features/exceptions/presentation/pages/worker_cancellation_page.dart';
import 'package:vstech_home_services/features/exceptions/presentation/pages/worker_dispute_notification_page.dart';
import 'package:vstech_home_services/l10n/generated/app_localizations.dart';

Widget _createTestExceptionsWidget(Widget child) {
  final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => child,
      ),
      GoRoute(
        path: AppRoutes.customerCancel,
        builder: (context, state) => const CustomerCancellationPage(),
      ),
      GoRoute(
        path: AppRoutes.workerCancel,
        builder: (context, state) => const WorkerCancellationPage(),
      ),
      GoRoute(
        path: AppRoutes.customerNoShow,
        builder: (context, state) => const CustomerNoShowPage(),
      ),
      GoRoute(
        path: AppRoutes.disputeReport,
        builder: (context, state) => const DisputeReportPage(),
      ),
      GoRoute(
        path: AppRoutes.orderDisputed,
        builder: (context, state) => const OrderDisputedPage(),
      ),
      GoRoute(
        path: AppRoutes.customerDisputeList,
        builder: (context, state) => const CustomerDisputeListPage(),
      ),
      GoRoute(
        path: AppRoutes.disputeDetail,
        builder: (context, state) => const DisputeDetailPage(),
      ),
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
    testWidgets('CustomerCancellationPage renders free cancellation mode and handles reason selection', (tester) async {
      await tester.binding.setSurfaceSize(const Size(390, 1400));
      await tester.pumpWidget(_createTestExceptionsWidget(const CustomerCancellationPage()));
      await tester.pumpAndSettle();

      // Header and order code
      expect(find.textContaining('Huỷ đặt lịch'), findsOneWidget);
      expect(find.text('HS-2026-0012'), findsOneWidget);
      expect(find.textContaining('miễn phí'), findsWidgets);

      // Reason chips
      expect(find.textContaining('Thay đổi lịch bận đột xuất'), findsOneWidget);
      expect(find.textContaining('Tìm được giải pháp khác'), findsOneWidget);

      // Policy note
      expect(find.textContaining('không phát sinh bất kỳ khoản phí nào'), findsOneWidget);

      // Confirm button (Free mode)
      expect(find.textContaining('Xác nhận huỷ miễn phí'), findsOneWidget);

      // Select 'Lý do khác'
      await tester.tap(find.textContaining('Lý do khác'));
      await tester.pumpAndSettle();
      expect(find.byType(TextField), findsOneWidget);
    });

    testWidgets('CustomerCancellationPage renders fee cancellation mode with 50.000đ penalty', (tester) async {
      await tester.binding.setSurfaceSize(const Size(390, 1400));
      await tester.pumpWidget(_createTestExceptionsWidget(const CustomerCancellationPage(hasFee: true)));
      await tester.pumpAndSettle();

      // Fee subtitle
      expect(find.textContaining('50.000đ'), findsWidgets);
      expect(find.textContaining('Phí huỷ 50.000đ sẽ được trừ vào tài khoản'), findsOneWidget);

      // Confirm button with Amber CTA
      expect(find.textContaining('Xác nhận huỷ & Trả 50.000đ'), findsOneWidget);
      expect(find.textContaining('Giữ lại đơn hàng'), findsOneWidget);
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

    testWidgets('CustomerNoShowPage navigates from waiting timer to reporting and completion with compensation', (tester) async {
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

    testWidgets('DisputeReportPage validates issue selection and triggers escrow freeze', (tester) async {
      await tester.binding.setSurfaceSize(const Size(390, 1400));
      await tester.pumpWidget(_createTestExceptionsWidget(const DisputeReportPage()));
      await tester.pumpAndSettle();

      // Header
      expect(find.textContaining('Báo vấn đề & Khiếu nại'), findsOneWidget);
      expect(find.textContaining('HS-2026-0012'), findsOneWidget);

      // Categories
      expect(find.textContaining('Chất lượng dịch vụ không đạt'), findsOneWidget);
      expect(find.textContaining('Gây hư hỏng'), findsOneWidget);
      expect(find.textContaining('Thái độ thợ'), findsOneWidget);

      // Escrow notice
      expect(find.textContaining('Bảo vệ Escrow: Số tiền 400.000đ'), findsOneWidget);

      // Pick an issue type
      await tester.tap(find.textContaining('Chất lượng dịch vụ không đạt'));
      await tester.pumpAndSettle();

      // Submit CTA
      expect(find.textContaining('Gửi khiếu nại & Đóng băng tiền'), findsOneWidget);
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
