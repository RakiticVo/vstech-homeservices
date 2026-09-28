import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:go_router/go_router.dart';
import 'package:vstech_home_services/core/router/app_routes.dart';
import 'package:vstech_home_services/core/theme/app_theme.dart';
import 'package:vstech_home_services/features/orders/presentation/pages/customer_orders_page.dart';
import 'package:vstech_home_services/features/warranty/presentation/pages/warranty_certificate_page.dart';
import 'package:vstech_home_services/features/warranty/presentation/pages/warranty_request_page.dart';
import 'package:vstech_home_services/features/warranty/presentation/pages/warranty_status_page.dart';
import 'package:vstech_home_services/features/warranty/presentation/pages/worker_warranty_decline_page.dart';
import 'package:vstech_home_services/features/warranty/presentation/pages/worker_warranty_job_detail_page.dart';
import 'package:vstech_home_services/l10n/generated/app_localizations.dart';

Widget _createTestWarrantyWidget(Widget child) {
  final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => child,
      ),
      GoRoute(
        path: AppRoutes.warrantyCertificate,
        builder: (context, state) => const WarrantyCertificatePage(),
      ),
      GoRoute(
        path: AppRoutes.warrantyRequest,
        builder: (context, state) => const WarrantyRequestPage(),
      ),
      GoRoute(
        path: AppRoutes.warrantyStatus,
        builder: (context, state) => const WarrantyStatusPage(),
      ),
      GoRoute(
        path: AppRoutes.workerWarrantyJob,
        builder: (context, state) => const WorkerWarrantyJobDetailPage(),
      ),
      GoRoute(
        path: AppRoutes.workerWarrantyDecline,
        builder: (context, state) => const WorkerWarrantyDeclinePage(),
      ),
      GoRoute(
        path: AppRoutes.customerOrders,
        builder: (context, state) => const CustomerOrdersPage(),
      ),
      GoRoute(
        path: AppRoutes.workerJobsHub,
        builder: (context, state) => const Scaffold(body: Text('Worker Jobs Hub')),
      ),
      GoRoute(
        path: AppRoutes.workerEnRoute,
        builder: (context, state) => const Scaffold(body: Text('Worker En Route')),
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
  group('Batch 10: Auto-Warranty Journey Widget Tests', () {
    testWidgets('WarrantyCertificatePage renders active certificate with covered/not covered terms', (tester) async {
      await tester.binding.setSurfaceSize(const Size(390, 1400));
      await tester.pumpWidget(_createTestWarrantyWidget(const WarrantyCertificatePage()));
      await tester.pumpAndSettle();

      expect(find.text('Phiếu bảo hành'), findsOneWidget);
      expect(find.text('Phiếu BH-0087'), findsOneWidget);
      expect(find.text('CÒN HIỆU LỰC'), findsOneWidget);
      expect(find.text('Trần Văn Hùng'), findsOneWidget);
      expect(find.text('22 ngày'), findsOneWidget);
      expect(find.byIcon(Icons.qr_code_2_rounded), findsOneWidget);

      // Covered & Not covered
      expect(find.text('Được bảo hành'), findsOneWidget);
      expect(find.textContaining('Máy lạnh bị chảy nước'), findsOneWidget);
      expect(find.text('Không bảo hành'), findsOneWidget);
      expect(find.textContaining('Hư hỏng do nguồn điện'), findsOneWidget);

      // Request CTA
      expect(find.text('Yêu cầu bảo hành'), findsOneWidget);
    });

    testWidgets('WarrantyCertificatePage renders expired certificate state without CTA', (tester) async {
      await tester.binding.setSurfaceSize(const Size(390, 1400));
      await tester.pumpWidget(_createTestWarrantyWidget(const WarrantyCertificatePage(isExpired: true)));
      await tester.pumpAndSettle();

      expect(find.text('HẾT HẠN'), findsOneWidget);
      expect(find.text('Đã hết hạn'), findsOneWidget);
      expect(find.text('Yêu cầu bảo hành'), findsNothing);
    });

    testWidgets('WarrantyRequestPage handles description, slots selection and CTA activation', (tester) async {
      await tester.binding.setSurfaceSize(const Size(390, 1400));
      await tester.pumpWidget(_createTestWarrantyWidget(const WarrantyRequestPage()));
      await tester.pumpAndSettle();

      expect(find.text('Yêu cầu bảo hành'), findsOneWidget);
      expect(find.text('0đ'), findsOneWidget);
      expect(find.textContaining('Bảo hành cho HS-20250318-0087'), findsOneWidget);

      // Initially CTA is locked with prompt
      expect(find.text('Mô tả sự cố để gửi'), findsOneWidget);

      // Fill description via tap on suggestion
      await tester.tap(find.textContaining('Máy lạnh chảy nước sau khi vệ sinh'));
      await tester.pumpAndSettle();

      // Now prompt asks for slot
      expect(find.text('Chọn ít nhất một khung giờ'), findsOneWidget);

      // Select first slot
      await tester.tap(find.textContaining('08:00 - 10:00'));
      await tester.pumpAndSettle();

      // Now CTA is enabled
      expect(find.text('Gửi yêu cầu bảo hành'), findsOneWidget);

      // Add a mock photo
      expect(find.text('+ Thêm ảnh'), findsOneWidget);
      await tester.tap(find.text('+ Thêm ảnh'));
      await tester.pumpAndSettle();
      expect(find.text('IMG_0523'), findsOneWidget);
    });

    testWidgets('WarrantyStatusPage renders 4-stage timeline and contextual notice', (tester) async {
      await tester.binding.setSurfaceSize(const Size(390, 1400));
      await tester.pumpWidget(_createTestWarrantyWidget(const WarrantyStatusPage()));
      await tester.pumpAndSettle();

      expect(find.text('Tiến trình bảo hành'), findsOneWidget);
      expect(find.text('BẢO HÀNH'), findsOneWidget);
      expect(find.text('#BH20250425-0087'), findsOneWidget);

      // 4 steps
      expect(find.text('Đã gửi'), findsOneWidget);
      expect(find.text('Thợ đã nhận'), findsOneWidget);
      expect(find.text('Đang xử lý'), findsOneWidget);
      expect(find.text('Đã khắc phục'), findsOneWidget);

      // Notice for stage 1
      expect(find.textContaining('Anh Hùng sẽ đến trong khung giờ bạn chọn'), findsOneWidget);
      expect(find.text('Về Đơn của tôi'), findsOneWidget);
    });

    testWidgets('WorkerWarrantyJobDetailPage renders 0đ payout and original order info', (tester) async {
      await tester.binding.setSurfaceSize(const Size(390, 1400));
      await tester.pumpWidget(_createTestWarrantyWidget(const WorkerWarrantyJobDetailPage()));
      await tester.pumpAndSettle();

      expect(find.text('Việc bảo hành'), findsOneWidget);
      expect(find.text('BẢO HÀNH'), findsOneWidget);
      expect(find.text('Phản hồi trong 23:59:00'), findsOneWidget);
      expect(find.text('0đ'), findsOneWidget);
      expect(find.textContaining('Nguyễn Thị Mai'), findsOneWidget);
      expect(find.textContaining('Đơn gốc: #HS20250318-0087'), findsOneWidget);

      // Actions
      expect(find.text('Từ chối'), findsOneWidget);
      expect(find.text('Nhận việc bảo hành'), findsOneWidget);
    });

    testWidgets('WorkerWarrantyDeclinePage requires reason and acknowledgment before confirmation', (tester) async {
      await tester.binding.setSurfaceSize(const Size(390, 1400));
      await tester.pumpWidget(_createTestWarrantyWidget(const WorkerWarrantyDeclinePage()));
      await tester.pumpAndSettle();

      expect(find.text('Từ chối bảo hành'), findsOneWidget);
      expect(find.textContaining('Cảnh báo trừ 120.000đ'), findsOneWidget);
      expect(find.text('Không đúng lỗi do mình'), findsOneWidget);
      expect(find.text('Không sắp xếp được thời gian'), findsOneWidget);

      // Try tapping disabled confirm button
      final confirmBtn = find.text('Xác nhận từ chối');
      expect(confirmBtn, findsOneWidget);

      // Select reason
      await tester.tap(find.text('Không đúng lỗi do mình'));
      await tester.pumpAndSettle();

      // Tick acknowledgment
      await tester.tap(find.textContaining('Tôi hiểu 120.000đ sẽ bị trừ vào ví thu nhập'));
      await tester.pumpAndSettle();

      // Confirm button is now active
      await tester.tap(confirmBtn);
      await tester.pumpAndSettle();
    });

    testWidgets('CustomerOrdersPage displays warranty tag and active warranty job (Cell 91)', (tester) async {
      await tester.binding.setSurfaceSize(const Size(390, 1400));
      await tester.pumpWidget(_createTestWarrantyWidget(const CustomerOrdersPage()));
      await tester.pumpAndSettle();

      // Active tab shows warranty active order
      expect(find.text('BẢO HÀNH'), findsOneWidget);
      expect(find.text('#BH20250425-0087'), findsOneWidget);
      expect(find.text('Bảo hành: Vệ sinh máy lạnh'), findsOneWidget);

      // Tap Completed tab (tab index 2)
      await tester.tap(find.text('Hoàn thành'));
      await tester.pumpAndSettle();

      // Completed tab displays warranty active chip on completed card
      expect(find.textContaining('Còn bảo hành 22 ngày · đến 17/05'), findsOneWidget);
      expect(find.text('Xem phiếu bảo hành'), findsOneWidget);
    });
  });
}
