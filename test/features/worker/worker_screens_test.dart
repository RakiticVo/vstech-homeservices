import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:vstech_home_services/core/router/app_routes.dart';
import 'package:vstech_home_services/core/theme/app_theme.dart';
import 'package:vstech_home_services/features/worker_dashboard/presentation/pages/worker_dashboard_page.dart';
import 'package:vstech_home_services/features/worker_dashboard/presentation/widgets/worker_earnings_card.dart';
import 'package:vstech_home_services/features/worker_dashboard/presentation/widgets/worker_floating_dock.dart';
import 'package:vstech_home_services/features/worker_dashboard/presentation/widgets/worker_job_request_card.dart';
import 'package:vstech_home_services/features/worker_dispatch/presentation/pages/worker_job_detail_page.dart';
import 'package:vstech_home_services/features/worker_kyc/presentation/pages/worker_kyc_status_page.dart';
import 'package:vstech_home_services/features/worker_kyc/presentation/pages/worker_kyc_wizard_page.dart';
import 'package:vstech_home_services/l10n/generated/app_localizations.dart';

Widget _createTestWorkerWidget(Widget child) {
  final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => child,
      ),
      GoRoute(
        path: AppRoutes.workerDashboard,
        builder: (context, state) => const WorkerDashboardPage(),
      ),
      GoRoute(
        path: AppRoutes.workerJobDetail,
        builder: (context, state) => const WorkerJobDetailPage(),
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
  group('Batch 4 Worker Dashboard & KYC Widget Tests', () {
    testWidgets('WorkerDashboardPage renders header, earnings card, job request, and dock', (tester) async {
      await tester.pumpWidget(_createTestWorkerWidget(const WorkerDashboardPage()));
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

      // Verify Incoming Job Request Card
      expect(find.byType(WorkerJobRequestCard), findsOneWidget);
      expect(find.text('Yêu cầu việc mới'), findsOneWidget);
      expect(find.text('Đến sau 20 phút'), findsOneWidget);
      expect(find.text('Xem & Nhận việc'), findsOneWidget);

      // Verify Floating Bottom Dock
      expect(find.byType(WorkerFloatingDock), findsOneWidget);
      expect(find.text('Việc'), findsOneWidget);

      // Toggle Online status to Offline
      await tester.tap(find.text('Đang online'));
      await tester.pumpAndSettle();
      expect(find.text('Nghỉ ngơi'), findsOneWidget);
    });

    testWidgets('WorkerJobDetailPage displays transparent price breakdown and accept CTA', (tester) async {
      await tester.pumpWidget(_createTestWorkerWidget(const WorkerJobDetailPage()));
      await tester.pumpAndSettle();

      // Verify Title & Customer
      expect(find.text('Chi tiết yêu cầu việc'), findsOneWidget);
      expect(find.text('Dọn dẹp căn hộ 70m²'), findsOneWidget);
      expect(find.text('Nguyễn Thị Thu Thảo'), findsOneWidget);

      // Verify Transparent Financial Breakdown
      expect(find.text('Bảng kê thu nhập minh bạch'), findsOneWidget);
      expect(find.text('Công thợ trọn gói'), findsOneWidget);
      expect(find.text('+ 350.000đ'), findsOneWidget);
      expect(find.text('Phụ phí mặt bằng'), findsOneWidget);
      expect(find.text('+ 50.000đ'), findsOneWidget);
      expect(find.text('Phí nền tảng (15%)'), findsOneWidget);
      expect(find.text('- 60.000đ'), findsOneWidget);
      expect(find.text('340.000đ'), findsOneWidget);

      // Verify Accept CTA
      expect(find.text('Nhận việc ngay'), findsOneWidget);
      await tester.tap(find.text('Nhận việc ngay'));
      await tester.pump();
      expect(find.text('Đã nhận việc thành công! Vui lòng chuẩn bị di chuyển'), findsOneWidget);
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
