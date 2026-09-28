import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:vstech_home_services/core/router/app_routes.dart';
import 'package:vstech_home_services/core/theme/app_theme.dart';
import 'package:vstech_home_services/features/orders/presentation/pages/customer_notification_settings_page.dart';
import 'package:vstech_home_services/features/orders/presentation/pages/customer_notifications_page.dart';
import 'package:vstech_home_services/features/orders/presentation/pages/customer_order_detail_page.dart';
import 'package:vstech_home_services/features/orders/presentation/pages/customer_orders_page.dart';
import 'package:vstech_home_services/features/orders/presentation/pages/worker_jobs_hub_page.dart';
import 'package:vstech_home_services/features/orders/presentation/pages/worker_notifications_page.dart';
import 'package:vstech_home_services/l10n/generated/app_localizations.dart';

Widget _createTestOrdersWidget(Widget child) {
  final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => child,
      ),
      GoRoute(
        path: AppRoutes.customerOrders,
        builder: (context, state) => const CustomerOrdersPage(),
      ),
      GoRoute(
        path: AppRoutes.customerOrderDetail,
        builder: (context, state) => const CustomerOrderDetailPage(),
      ),
      GoRoute(
        path: AppRoutes.workerJobsHub,
        builder: (context, state) => const WorkerJobsHubPage(),
      ),
      GoRoute(
        path: AppRoutes.customerNotifications,
        builder: (context, state) => const CustomerNotificationsPage(),
      ),
      GoRoute(
        path: AppRoutes.customerNotificationSettings,
        builder: (context, state) => const CustomerNotificationSettingsPage(),
      ),
      GoRoute(
        path: AppRoutes.workerNotifications,
        builder: (context, state) => const WorkerNotificationsPage(),
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
  group('Batch 8: Orders Hub & Notifications Widget Tests', () {
    testWidgets('CustomerOrdersPage renders 3 tabs and switches between Active, Scheduled, Completed', (tester) async {
      await tester.binding.setSurfaceSize(const Size(390, 1400));
      await tester.pumpWidget(_createTestOrdersWidget(const CustomerOrdersPage()));
      await tester.pumpAndSettle();

      // Check header
      expect(find.textContaining('Đơn hàng của tôi'), findsOneWidget);

      // Check active tab order card
      expect(find.text('HS-2026-0012'), findsOneWidget);
      expect(find.textContaining('Dọn dẹp căn hộ'), findsOneWidget);
      expect(find.textContaining('Nguyễn Văn Hùng'), findsOneWidget);
      expect(find.textContaining('Theo dõi thợ'), findsOneWidget);

      // Tap on Scheduled Tab (Index 1)
      await tester.tap(find.textContaining('Đang chờ'));
      await tester.pumpAndSettle();

      expect(find.text('HS-2026-0014'), findsOneWidget);
      expect(find.textContaining('Máy lạnh'), findsOneWidget);

      // Tap on Completed Tab (Index 2)
      await tester.tap(find.textContaining('Hoàn thành'));
      await tester.pumpAndSettle();

      expect(find.text('HS-2026-0008'), findsOneWidget);
      expect(find.textContaining('Đặt lại'), findsWidgets);
    });

    testWidgets('CustomerOrderDetailPage renders worker, schedule, itemized invoice and warranty badge', (tester) async {
      await tester.binding.setSurfaceSize(const Size(390, 1400));
      await tester.pumpWidget(_createTestOrdersWidget(const CustomerOrderDetailPage()));
      await tester.pumpAndSettle();

      // Header and order code
      expect(find.textContaining('Chi tiết đơn hàng'), findsOneWidget);
      expect(find.text('HS-2026-0012'), findsOneWidget);

      // Worker card
      expect(find.text('Nguyễn Văn Hùng'), findsOneWidget);
      expect(find.byIcon(Icons.chat_bubble_outline_rounded), findsOneWidget);
      expect(find.byIcon(Icons.phone_outlined), findsOneWidget);

      // Address and schedule
      expect(find.textContaining('Flora Novia'), findsWidgets);

      // Price breakdown
      expect(find.text('350.000đ'), findsOneWidget);
      expect(find.text('30.000đ'), findsOneWidget);
      expect(find.text('20.000đ'), findsOneWidget);
      expect(find.text('400.000đ'), findsWidgets);

      // Warranty badge
      expect(find.textContaining('30 ngày'), findsOneWidget);

      // Action button
      expect(find.textContaining('Theo dõi thợ'), findsOneWidget);
    });

    testWidgets('WorkerJobsHubPage renders Assigned, Active and Completed tabs with net payout and actions', (tester) async {
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

    testWidgets('CustomerNotificationsPage renders timeline sections, filter chips and notification tiles', (tester) async {
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

    testWidgets('WorkerNotificationsPage renders dispatch assignments, wallet credits and safety alerts', (tester) async {
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
