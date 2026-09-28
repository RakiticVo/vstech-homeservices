import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:vstech_home_services/core/router/app_routes.dart';
import 'package:vstech_home_services/core/theme/app_theme.dart';
import 'package:vstech_home_services/features/worker_dashboard/presentation/pages/worker_availability_page.dart';
import 'package:vstech_home_services/features/worker_dashboard/presentation/pages/worker_performance_page.dart';
import 'package:vstech_home_services/features/worker_dashboard/presentation/pages/worker_profile_page.dart';
import 'package:vstech_home_services/features/worker_dashboard/presentation/pages/worker_schedule_week_page.dart';
import 'package:vstech_home_services/features/worker_dashboard/presentation/pages/worker_skills_page.dart';
import 'package:vstech_home_services/features/worker_dashboard/presentation/pages/worker_upload_cert_page.dart';
import 'package:vstech_home_services/features/worker_dashboard/presentation/pages/worker_work_zone_page.dart';
import 'package:vstech_home_services/l10n/generated/app_localizations.dart';

Widget _createTestOperationsWidget(Widget child) {
  final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => child,
      ),
      GoRoute(
        path: AppRoutes.workerSchedule,
        builder: (context, state) => const WorkerScheduleWeekPage(),
      ),
      GoRoute(
        path: AppRoutes.workerAvailability,
        builder: (context, state) => const WorkerAvailabilityPage(),
      ),
      GoRoute(
        path: AppRoutes.workerWorkZone,
        builder: (context, state) => const WorkerWorkZonePage(),
      ),
      GoRoute(
        path: AppRoutes.workerSkills,
        builder: (context, state) => const WorkerSkillsPage(),
      ),
      GoRoute(
        path: AppRoutes.workerUploadCert,
        builder: (context, state) => const WorkerUploadCertPage(),
      ),
      GoRoute(
        path: AppRoutes.workerPerformance,
        builder: (context, state) => const WorkerPerformancePage(),
      ),
      GoRoute(
        path: AppRoutes.workerProfile,
        builder: (context, state) => const WorkerProfilePage(),
      ),
      GoRoute(
        path: AppRoutes.roleGateway,
        builder: (context, state) => const Scaffold(body: Text('RoleGateway')),
      ),
      GoRoute(
        path: AppRoutes.workerJobDetail,
        builder: (context, state) => const Scaffold(body: Text('JobDetail')),
      ),
      GoRoute(
        path: AppRoutes.workerWarrantyJob,
        builder: (context, state) => const Scaffold(body: Text('WarrantyJobDetail')),
      ),
      GoRoute(
        path: AppRoutes.workerWithdraw,
        builder: (context, state) => const Scaffold(body: Text('WithdrawPage')),
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
    supportedLocales: const [
      Locale('vi'),
      Locale('en'),
    ],
    locale: const Locale('vi'),
  );
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Batch 13: Worker Operations & Schedule Tests', () {
    testWidgets('WorkerScheduleWeekPage switches days and displays warranty job tag', (tester) async {
      await tester.pumpWidget(_createTestOperationsWidget(const WorkerScheduleWeekPage()));
      await tester.pumpAndSettle();

      expect(find.text('Lịch làm việc'), findsOneWidget);
      expect(find.text('21/04 – 27/04'), findsOneWidget);

      // Verify today is selected initially (T6 25)
      expect(find.text('Hôm nay'), findsOneWidget);
      expect(find.text('Vệ sinh máy lạnh treo tường (2 máy)'), findsOneWidget);

      // Switch to Saturday 26 (has warranty job)
      final satDay = find.byKey(const Key('week_day_5'));
      expect(satDay, findsOneWidget);
      await tester.tap(satDay);
      await tester.pumpAndSettle();

      expect(find.text('BẢO HÀNH 0đ'), findsOneWidget);
      expect(find.textContaining('Bảo hành kiểm tra lại'), findsOneWidget);
    });

    testWidgets('WorkerAvailabilityPage cycles shifts and warns on warranty time-off', (tester) async {
      await tester.pumpWidget(_createTestOperationsWidget(const WorkerAvailabilityPage()));
      await tester.pumpAndSettle();

      expect(find.text('Giờ nhận việc & Nghỉ'), findsOneWidget);
      expect(find.text('Giờ nhận việc hàng tuần'), findsOneWidget);
      expect(find.text('Nghỉ đột xuất'), findsOneWidget);

      // Cycle shift time for T2
      final rangeChip0 = find.byKey(const Key('avail_range_0'));
      expect(rangeChip0, findsOneWidget);
      await tester.tap(rangeChip0);
      await tester.pumpAndSettle();

      // Tap time-off chip for 26/04 (warranty day)
      final timeoff26 = find.byKey(const Key('timeoff_chip_26/04'));
      expect(timeoff26, findsOneWidget);
      await tester.ensureVisible(timeoff26);
      await tester.tap(timeoff26);
      await tester.pumpAndSettle();

      // Warning banner must appear
      expect(find.textContaining('Ngày 26/04 có việc bảo hành lúc 08:00 đã nhận'), findsOneWidget);

      // Tap save
      final saveBtn = find.byKey(const Key('save_availability_button'));
      await tester.ensureVisible(saveBtn);
      await tester.tap(saveBtn);
      await tester.pumpAndSettle();

      expect(find.text('Đã lưu cài đặt lịch làm việc thành công'), findsOneWidget);
    });

    testWidgets('WorkerWorkZonePage selects radius and district chips', (tester) async {
      await tester.pumpWidget(_createTestOperationsWidget(const WorkerWorkZonePage()));
      await tester.pumpAndSettle();

      expect(find.text('Khu vực nhận việc'), findsOneWidget);
      expect(find.text('Bán kính từ vị trí hiện tại'), findsOneWidget);
      expect(find.text('Quận / Huyện nhận việc'), findsOneWidget);

      // Tap 8km radius stop
      final radius8 = find.byKey(const Key('radius_chip_8'));
      expect(radius8, findsOneWidget);
      await tester.tap(radius8);
      await tester.pumpAndSettle();

      // Tap a district chip
      final q7Chip = find.byKey(const Key('district_chip_Quận 7'));
      expect(q7Chip, findsOneWidget);
      await tester.ensureVisible(q7Chip);
      await tester.tap(q7Chip);
      await tester.pumpAndSettle();

      // Tap save
      final saveBtn = find.byKey(const Key('save_zone_button'));
      await tester.ensureVisible(saveBtn);
      await tester.tap(saveBtn);
      await tester.pumpAndSettle();

      expect(find.text('Đã lưu khu vực nhận việc thành công'), findsOneWidget);
    });

    testWidgets('WorkerSkillsPage shows expired cert banner and services list', (tester) async {
      await tester.pumpWidget(_createTestOperationsWidget(const WorkerSkillsPage()));
      await tester.pumpAndSettle();

      expect(find.text('Kỹ năng & Chứng chỉ'), findsOneWidget);
      expect(find.text('Chứng chỉ làm việc trên cao đã hết hạn'), findsOneWidget);
      expect(find.text('Dịch vụ nhận làm'), findsOneWidget);
      expect(find.text('Chứng chỉ hành nghề'), findsOneWidget);

      // Verify hidden tags exist on outdoor services
      expect(find.text('ẨN'), findsWidgets);

      // Tap upload cert button
      final uploadBtn = find.byKey(const Key('upload_cert_button'));
      expect(uploadBtn, findsOneWidget);
      await tester.ensureVisible(uploadBtn);
      await tester.tap(uploadBtn);
      await tester.pumpAndSettle();

      expect(find.text('Tải chứng chỉ mới'), findsOneWidget);
    });

    testWidgets('WorkerUploadCertPage interacts with type selection and photo toggle', (tester) async {
      await tester.pumpWidget(_createTestOperationsWidget(const WorkerUploadCertPage()));
      await tester.pumpAndSettle();

      expect(find.text('Tải chứng chỉ mới'), findsOneWidget);
      expect(find.text('Loại chứng chỉ'), findsOneWidget);
      expect(find.text('Ảnh chụp chứng chỉ'), findsOneWidget);

      // Select cert type 1 (AC)
      final typeAc = find.byKey(const Key('cert_type_1'));
      expect(typeAc, findsOneWidget);
      await tester.tap(typeAc);
      await tester.pumpAndSettle();

      // Tap photo upload container
      final photoBox = find.byKey(const Key('cert_photo_upload_box'));
      expect(photoBox, findsOneWidget);
      await tester.tap(photoBox);
      await tester.pumpAndSettle();

      expect(find.text('Đã đính kèm ảnh · Chạm để đổi'), findsOneWidget);

      // Submit
      final submitBtn = find.byKey(const Key('submit_cert_button'));
      await tester.ensureVisible(submitBtn);
      await tester.tap(submitBtn);
      await tester.pumpAndSettle();

      expect(find.text('Đã gửi chứng chỉ xét duyệt. Kết quả sẽ có trong vòng 48 giờ.'), findsOneWidget);
    });

    testWidgets('WorkerPerformancePage renders 4 metrics and badges', (tester) async {
      await tester.pumpWidget(_createTestOperationsWidget(const WorkerPerformancePage()));
      await tester.pumpAndSettle();

      expect(find.text('Hiệu suất hoạt động'), findsOneWidget);
      expect(find.text('4.9'), findsOneWidget);
      expect(find.text('128 đánh giá · 30 ngày gần nhất'), findsOneWidget);
      expect(find.text('Kỹ thuật viên Xuất sắc · Hạng Vàng'), findsOneWidget);

      // 4 metrics
      expect(find.text('Tỉ lệ nhận việc'), findsOneWidget);
      expect(find.text('Tỉ lệ hoàn thành'), findsOneWidget);
      expect(find.text('Check-in đúng giờ'), findsOneWidget);
      expect(find.text('Tỉ lệ bảo hành'), findsOneWidget);

      // Badges
      expect(find.text('Huy hiệu đạt được'), findsOneWidget);
      expect(find.text('Đúng giờ'), findsOneWidget);
      expect(find.text('100 việc'), findsOneWidget);
      expect(find.text('Khách yêu thích'), findsOneWidget);
      expect(find.text('Không khiếu nại'), findsOneWidget);
    });

    testWidgets('WorkerProfilePage renders header, navigation menu, and logout dialog', (tester) async {
      await tester.pumpWidget(_createTestOperationsWidget(const WorkerProfilePage()));
      await tester.pumpAndSettle();

      expect(find.text('Hồ sơ đối tác'), findsOneWidget);
      expect(find.text('Trần Văn Hùng'), findsOneWidget);
      expect(find.text('0909 123 456'), findsOneWidget);
      expect(find.text('Mã đối tác: TH-8821'), findsOneWidget);

      // Menu items
      expect(find.byKey(const Key('menu_worker_skills')), findsOneWidget);
      expect(find.byKey(const Key('menu_worker_zone')), findsOneWidget);
      expect(find.byKey(const Key('menu_worker_schedule')), findsOneWidget);
      expect(find.byKey(const Key('menu_worker_perf')), findsOneWidget);
      expect(find.byKey(const Key('menu_worker_payout')), findsOneWidget);

      // Logout button and dialog
      final logoutBtn = find.byKey(const Key('worker_logout_button'));
      expect(logoutBtn, findsOneWidget);
      await tester.ensureVisible(logoutBtn);
      await tester.tap(logoutBtn);
      await tester.pumpAndSettle();

      expect(find.text('Đăng xuất khỏi tài khoản Thợ?'), findsOneWidget);
      expect(find.text('Bạn sẽ không nhận được thông báo cuốc việc mới cho đến khi đăng nhập lại.'), findsOneWidget);

      // Confirm logout
      final confirmBtn = find.byKey(const Key('confirm_worker_logout_button'));
      expect(confirmBtn, findsOneWidget);
      await tester.tap(confirmBtn);
      await tester.pumpAndSettle();

      expect(find.text('RoleGateway'), findsOneWidget);
    });
  });
}
