import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:vstech_home_services/core/router/app_routes.dart';
import 'package:vstech_home_services/core/theme/app_theme.dart';
import 'package:vstech_home_services/features/tracking/presentation/pages/customer_tracking_page.dart';
import 'package:vstech_home_services/features/tracking/presentation/pages/worker_arrived_page.dart';
import 'package:vstech_home_services/features/tracking/presentation/pages/worker_en_route_page.dart';
import 'package:vstech_home_services/features/tracking/presentation/pages/worker_executing_page.dart';
import 'package:vstech_home_services/features/tracking/presentation/widgets/service_checklist_widget.dart';
import 'package:vstech_home_services/features/tracking/presentation/widgets/tracking_map_widget.dart';
import 'package:vstech_home_services/features/tracking/presentation/widgets/working_timer_widget.dart';
import 'package:vstech_home_services/l10n/generated/app_localizations.dart';

Widget _createTestTrackingWidget(Widget child) {
  final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => child,
      ),
      GoRoute(
        path: AppRoutes.customerTracking,
        builder: (context, state) => const CustomerTrackingPage(),
      ),
      GoRoute(
        path: AppRoutes.workerEnRoute,
        builder: (context, state) => const WorkerEnRoutePage(),
      ),
      GoRoute(
        path: AppRoutes.workerArrived,
        builder: (context, state) => const WorkerArrivedPage(),
      ),
      GoRoute(
        path: AppRoutes.workerExecuting,
        builder: (context, state) => const WorkerExecutingPage(),
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
    testWidgets('CustomerTrackingPage renders Stage 1 (En Route) with map, ETA, and worker card', (tester) async {
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
    });

    testWidgets('CustomerTrackingPage stage selector switches across all 4 stages', (tester) async {
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
    });

    testWidgets('WorkerEnRoutePage renders map, address, customer note, and arrival CTA', (tester) async {
      await tester.binding.setSurfaceSize(const Size(390, 1600));

      await tester.pumpWidget(
        _createTestTrackingWidget(const WorkerEnRoutePage()),
      );
      await tester.pump();

      expect(find.text('Đang di chuyển đến khách'), findsOneWidget);
      expect(find.byType(TrackingMapWidget), findsOneWidget);
      expect(find.text('Mở Google Maps dẫn đường'), findsOneWidget);
      expect(find.text('Căn hộ 802, Tháp B, Chung cư Flora Novia'), findsOneWidget);
      expect(find.text('Ghi chú: Gọi trước khi đến, gửi xe hầm B2'), findsOneWidget);
      expect(find.text('Tôi đã đến nơi'), findsOneWidget);
      expect(find.text('Huỷ việc'), findsOneWidget);
    });

    testWidgets('WorkerArrivedPage renders arrival confirmation, customer summary, and start job CTA', (tester) async {
      await tester.binding.setSurfaceSize(const Size(390, 1600));

      await tester.pumpWidget(
        _createTestTrackingWidget(const WorkerArrivedPage()),
      );
      await tester.pump();

      expect(find.text('Xác nhận có mặt'), findsOneWidget);
      expect(find.text('Thợ đã có mặt lúc 13:58'), findsOneWidget);
      expect(find.text('Chị Mai · Căn hộ 802, Tháp B'), findsOneWidget);
      expect(find.text('Bắt đầu làm việc'), findsOneWidget);
      expect(find.text('Khách không có mặt?'), findsOneWidget);
    });

    testWidgets('WorkerExecutingPage renders timer, checklist, extra cost dialog, and completion CTA', (tester) async {
      await tester.binding.setSurfaceSize(const Size(390, 1600));

      await tester.pumpWidget(
        _createTestTrackingWidget(const WorkerExecutingPage()),
      );
      await tester.pump();

      expect(find.text('Đang thực hiện công việc'), findsOneWidget);
      expect(find.byType(WorkingTimerWidget), findsOneWidget);
      expect(find.byType(ServiceChecklistWidget), findsOneWidget);
      expect(find.text('+ Đề xuất chi phí phát sinh'), findsOneWidget);
      expect(find.text('Hoàn tất công việc -> Chờ nghiệm thu'), findsOneWidget);

      // Open extra cost dialog
      await tester.tap(find.text('+ Đề xuất chi phí phát sinh'));
      await tester.pump();
      expect(find.text('Đề xuất chi phí phát sinh'), findsOneWidget);
      expect(find.text('Gửi đề xuất đến khách'), findsOneWidget);

      // Submit extra cost proposal
      await tester.tap(find.text('Gửi đề xuất đến khách'));
      await tester.pump();
      expect(find.text('Đã gửi đề xuất thành công!'), findsOneWidget);
    });
  });
}
