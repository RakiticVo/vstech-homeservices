import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:vstech_home_services/core/router/app_routes.dart';
import 'package:vstech_home_services/core/theme/app_theme.dart';
import 'package:vstech_home_services/features/booking/presentation/pages/booking_step1_service_option_page.dart';
import 'package:vstech_home_services/features/booking/presentation/pages/booking_step2_schedule_address_page.dart';
import 'package:vstech_home_services/features/booking/presentation/pages/booking_step3_confirm_page.dart';
import 'package:vstech_home_services/features/booking/presentation/pages/dispatch_radar_matching_page.dart';
import 'package:vstech_home_services/features/booking/presentation/widgets/addon_option_tile.dart';
import 'package:vstech_home_services/features/booking/presentation/widgets/booking_step_indicator.dart';
import 'package:vstech_home_services/features/booking/presentation/widgets/premises_surcharge_card.dart';
import 'package:vstech_home_services/features/booking/presentation/widgets/radar_pulse_animation.dart';
import 'package:vstech_home_services/features/booking/presentation/widgets/service_option_selector.dart';
import 'package:vstech_home_services/l10n/generated/app_localizations.dart';

Widget _createTestBookingWidget(Widget child) {
  final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => child,
      ),
      GoRoute(
        path: AppRoutes.bookingStep1,
        builder: (context, state) => const BookingStep1ServiceOptionPage(),
      ),
      GoRoute(
        path: AppRoutes.bookingStep2,
        builder: (context, state) {
          final basePrice = int.tryParse(state.uri.queryParameters['basePrice'] ?? '350000') ?? 350000;
          final addonsPrice = int.tryParse(state.uri.queryParameters['addonsPrice'] ?? '30000') ?? 30000;
          return BookingStep2ScheduleAddressPage(basePrice: basePrice, addonsPrice: addonsPrice);
        },
      ),
      GoRoute(
        path: AppRoutes.bookingStep3,
        builder: (context, state) {
          final basePrice = int.tryParse(state.uri.queryParameters['basePrice'] ?? '350000') ?? 350000;
          final addonsPrice = int.tryParse(state.uri.queryParameters['addonsPrice'] ?? '30000') ?? 30000;
          final premisesPrice = int.tryParse(state.uri.queryParameters['premisesPrice'] ?? '20000') ?? 20000;
          return BookingStep3ConfirmPage(
            basePrice: basePrice,
            addonsPrice: addonsPrice,
            premisesPrice: premisesPrice,
          );
        },
      ),
      GoRoute(
        path: AppRoutes.bookingMatching,
        builder: (context, state) => const DispatchRadarMatchingPage(),
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
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Batch 5: Customer Booking & Dispatch Flow Tests', () {
    testWidgets('BookingStepIndicator renders active step and progress bars', (tester) async {
      await tester.binding.setSurfaceSize(const Size(390, 844));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(
        _createTestBookingWidget(
          const Scaffold(
            appBar: BookingStepIndicator(
              currentStep: 1,
              stepTitle: 'Chọn gói & Dịch vụ kèm',
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Đặt lịch dịch vụ'), findsOneWidget);
      expect(find.text('Bước 1/3: Chọn gói & Dịch vụ kèm'), findsOneWidget);
      expect(find.byType(BookingStepIndicator), findsOneWidget);
    });

    testWidgets('BookingStep1ServiceOptionPage renders scopes, add-ons and updates pricing', (tester) async {
      await tester.binding.setSurfaceSize(const Size(390, 1600));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(
        _createTestBookingWidget(const BookingStep1ServiceOptionPage()),
      );
      await tester.pumpAndSettle();

      // Verify scope selector
      expect(find.byType(ServiceOptionSelector), findsOneWidget);
      expect(find.text('Căn hộ dưới 70m²'), findsOneWidget);
      expect(find.text('Căn hộ 70 - 100m²'), findsOneWidget);

      // Verify add-on tiles
      expect(find.byType(AddonOptionTile, skipOffstage: false), findsNWidgets(3));
      expect(find.text('Thu gom rác thải mang xuống', skipOffstage: false), findsOneWidget);
      expect(find.text('Khử khuẩn bề mặt Nano Bạc', skipOffstage: false), findsOneWidget);

      // Default price: small (350k) + trash (30k) = 380.000đ
      expect(find.text('380.000đ'), findsOneWidget);
      expect(find.text('Tiếp tục: Chọn ngày giờ'), findsOneWidget);

      // Tap on medium scope (450k)
      await tester.tap(find.text('Căn hộ 70 - 100m²'));
      await tester.pumpAndSettle();

      // New price: 450k + 30k = 480.000đ
      expect(find.text('480.000đ'), findsOneWidget);
    });

    testWidgets('BookingStep2ScheduleAddressPage renders schedule, address, surcharge cards', (tester) async {
      await tester.binding.setSurfaceSize(const Size(390, 844));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(
        _createTestBookingWidget(
          const BookingStep2ScheduleAddressPage(),
        ),
      );
      await tester.pumpAndSettle();

      // Verify date options
      expect(find.text('Hôm nay'), findsOneWidget);
      expect(find.text('Ngày mai'), findsOneWidget);

      // Verify address and premises surcharge card
      expect(find.text('Địa chỉ làm việc'), findsOneWidget);
      expect(find.byType(PremisesSurchargeCard), findsOneWidget);
      expect(find.text('Chung cư có thang máy'), findsOneWidget);

      // Surcharge default is elevator (+20k). Total = 350k + 30k + 20k = 400.000đ
      expect(find.text('400.000đ'), findsOneWidget);
      expect(find.text('Tiếp tục: Xác nhận đơn'), findsOneWidget);

      // Scroll and tap on stairs surcharge (+50k)
      await tester.drag(find.byType(ListView), const Offset(0, -300));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Chung cư thang bộ (tầng cao)'));
      await tester.pumpAndSettle();

      // Total becomes 350k + 30k + 50k = 430.000đ
      expect(find.text('430.000đ'), findsOneWidget);

      // Scroll and tap photo container to simulate photo attachment
      await tester.drag(find.byType(ListView), const Offset(0, -200));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Hình ảnh hiện trường (Tùy chọn, tối đa 5 ảnh)'));
      await tester.pumpAndSettle();
      expect(find.text('1/5 ảnh'), findsOneWidget);
    });

    testWidgets('BookingStep3ConfirmPage renders breakdown, voucher, payment methods, and Amber CTA', (tester) async {
      await tester.binding.setSurfaceSize(const Size(390, 1200));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(
        _createTestBookingWidget(
          const BookingStep3ConfirmPage(),
        ),
      );
      await tester.pumpAndSettle();

      // Verify itemized breakdown
      expect(find.text('Chi tiết bảng kê dự toán'), findsOneWidget);
      expect(find.text('Công thợ gói cơ bản'), findsOneWidget);
      expect(find.text('350.000đ'), findsNWidgets(2)); // Base price + Final total
      expect(find.text('+30.000đ'), findsOneWidget);
      expect(find.text('+20.000đ'), findsOneWidget);

      // Voucher default is applied (NHAMOICHI15: -50.000đ).
      // Subtotal = 350k + 30k + 20k = 400k. Total with discount = 350.000đ
      expect(find.text('-50.000đ'), findsOneWidget);
      expect(find.text('Xác nhận đặt lịch · 350.000đ'), findsOneWidget);

      // Verify payment methods
      expect(find.text('Chuyển khoản VietQR', skipOffstage: false), findsOneWidget);
      expect(find.text('Thẻ ATM / Ví điện tử (VNPay)', skipOffstage: false), findsOneWidget);
      expect(find.text('Tiền mặt sau khi hoàn tất', skipOffstage: false), findsOneWidget);

      // Verify Eco-Clean badges
      expect(find.text('Bảo hành tự động 0đ trong 30 ngày', skipOffstage: false), findsOneWidget);

      // Remove voucher
      await tester.tap(find.byIcon(Icons.close));
      await tester.pumpAndSettle();

      // Total becomes 400.000đ without voucher
      expect(find.text('Xác nhận đặt lịch · 400.000đ'), findsOneWidget);
    });

    testWidgets('DispatchRadarMatchingPage renders radar pulse animation and stages', (tester) async {
      await tester.binding.setSurfaceSize(const Size(390, 844));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      // Test Stage 0: Scanning
      await tester.pumpWidget(
        _createTestBookingWidget(
          const DispatchRadarMatchingPage(),
        ),
      );
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
      await tester.pumpWidget(
        _createTestBookingWidget(
          const DispatchRadarMatchingPage(initialStage: 2),
        ),
      );
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.text('Nguyễn Văn Hùng'), findsOneWidget);
      expect(find.text('4.9 ★ • 120+ đơn hoàn tất'), findsOneWidget);
      expect(find.text('Anh Nguyễn Văn Hùng đã nhận việc và đang chuẩn bị di chuyển'), findsOneWidget);
      expect(find.text('Xem vị trí thợ đang di chuyển'), findsOneWidget);
    });
  });
}
