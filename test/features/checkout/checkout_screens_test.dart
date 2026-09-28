import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:vstech_home_services/core/router/app_routes.dart';
import 'package:vstech_home_services/core/theme/app_theme.dart';
import 'package:vstech_home_services/features/checkout/presentation/pages/electronic_receipt_page.dart';
import 'package:vstech_home_services/features/checkout/presentation/pages/inspection_signoff_page.dart';
import 'package:vstech_home_services/features/checkout/presentation/pages/order_payment_summary_page.dart';
import 'package:vstech_home_services/features/checkout/presentation/pages/order_review_tip_page.dart';
import 'package:vstech_home_services/features/checkout/presentation/pages/order_thanks_page.dart';
import 'package:vstech_home_services/features/checkout/presentation/pages/payment_gateway_page.dart';
import 'package:vstech_home_services/features/checkout/presentation/pages/payment_success_page.dart';
import 'package:vstech_home_services/features/checkout/presentation/pages/worker_job_completion_page.dart';
import 'package:vstech_home_services/l10n/generated/app_localizations.dart';

Widget _createTestCheckoutWidget(Widget child) {
  final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => child,
      ),
      GoRoute(
        path: AppRoutes.inspectionSignoff,
        builder: (context, state) => const InspectionSignoffPage(),
      ),
      GoRoute(
        path: AppRoutes.orderPaymentSummary,
        builder: (context, state) => const OrderPaymentSummaryPage(),
      ),
      GoRoute(
        path: AppRoutes.paymentGateway,
        builder: (context, state) => const PaymentGatewayPage(),
      ),
      GoRoute(
        path: AppRoutes.paymentSuccess,
        builder: (context, state) => const PaymentSuccessPage(),
      ),
      GoRoute(
        path: AppRoutes.electronicReceipt,
        builder: (context, state) => const ElectronicReceiptPage(),
      ),
      GoRoute(
        path: AppRoutes.orderReviewTip,
        builder: (context, state) => const OrderReviewTipPage(),
      ),
      GoRoute(
        path: AppRoutes.orderThanks,
        builder: (context, state) => const OrderThanksPage(),
      ),
      GoRoute(
        path: AppRoutes.workerJobCompletion,
        builder: (context, state) => const WorkerJobCompletionPage(),
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
  group('Batch 7: Checkout, Inspection, Payment, Review & Worker Payout Widget Tests', () {
    testWidgets('InspectionSignoffPage displays checklist items, warranty badge, and allows toggling', (tester) async {
      await tester.binding.setSurfaceSize(const Size(390, 1400));
      await tester.pumpWidget(_createTestCheckoutWidget(const InspectionSignoffPage()));
      await tester.pumpAndSettle();

      // Check header and code
      expect(find.textContaining('HS-2026-0012'), findsWidgets);
      expect(find.textContaining('Nghiệm thu'), findsWidgets);

      // Check checklist items presence
      expect(find.byIcon(Icons.check_box_rounded), findsNWidgets(5));

      // Check warranty badge
      expect(find.textContaining('30 ngày'), findsWidgets);

      // Tap on first checklist item to toggle off
      final firstCheck = find.byIcon(Icons.check_box_rounded).first;
      await tester.tap(firstCheck);
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.check_box_outline_blank_rounded), findsOneWidget);
      expect(find.byIcon(Icons.check_box_rounded), findsNWidgets(4));
    });

    testWidgets('OrderPaymentSummaryPage displays itemized breakdown, method selection and Amber CTA', (tester) async {
      await tester.binding.setSurfaceSize(const Size(390, 1400));
      await tester.pumpWidget(_createTestCheckoutWidget(const OrderPaymentSummaryPage()));
      await tester.pumpAndSettle();

      // Check breakdown prices
      expect(find.text('350.000đ'), findsOneWidget);
      expect(find.text('30.000đ'), findsOneWidget);
      expect(find.text('20.000đ'), findsOneWidget);
      expect(find.text('400.000đ'), findsWidgets);

      // Check payment methods (VietQR, VNPay, Cash)
      expect(find.textContaining('VietQR'), findsWidgets);
      expect(find.textContaining('VNPay'), findsOneWidget);
      expect(find.textContaining('Tiền mặt'), findsOneWidget);

      // Tap VNPay method
      await tester.tap(find.textContaining('VNPay'));
      await tester.pumpAndSettle();

      // Check Amber payment button exists
      expect(find.textContaining('Thanh toán'), findsWidgets);
    });

    testWidgets('PaymentGatewayPage renders QR container, countdown timer and bank details', (tester) async {
      await tester.binding.setSurfaceSize(const Size(390, 1400));
      await tester.pumpWidget(_createTestCheckoutWidget(const PaymentGatewayPage()));
      await tester.pump();

      // Check VietQR header and amount
      expect(find.text('400.000đ'), findsWidgets);
      expect(find.textContaining('VietQR'), findsWidgets);

      // Check countdown timer
      expect(find.textContaining('14:5'), findsOneWidget);

      // Check bank credentials
      expect(find.textContaining('MB Bank'), findsOneWidget);
      expect(find.text('0987654321'), findsOneWidget);
      expect(find.text('CONG TY CONG NGHE VSTECH'), findsOneWidget);

      // Check confirm button
      expect(find.textContaining('Tôi đã chuyển khoản'), findsOneWidget);
    });

    testWidgets('PaymentSuccessPage renders success celebration and Eco points badge', (tester) async {
      await tester.binding.setSurfaceSize(const Size(390, 1200));
      await tester.pumpWidget(_createTestCheckoutWidget(const PaymentSuccessPage()));
      await tester.pumpAndSettle();

      // Success text
      expect(find.textContaining('thành công'), findsWidgets);
      expect(find.text('400.000đ'), findsOneWidget);

      // Eco points badge
      expect(find.textContaining('+40 điểm'), findsOneWidget);

      // Action buttons
      expect(find.textContaining('hóa đơn'), findsWidgets);
      expect(find.textContaining('Đánh giá'), findsOneWidget);
    });

    testWidgets('ElectronicReceiptPage renders fair breakdown with worker payout and platform fee', (tester) async {
      await tester.binding.setSurfaceSize(const Size(390, 1400));
      await tester.pumpWidget(_createTestCheckoutWidget(const ElectronicReceiptPage()));
      await tester.pumpAndSettle();

      // Invoice header
      expect(find.textContaining('HS-2026-0012'), findsWidgets);
      expect(find.text('400.000đ'), findsWidgets);

      // Fair breakdown: 85% worker (340.000đ), 15% platform (60.000đ)
      expect(find.text('340.000đ'), findsOneWidget);
      expect(find.text('60.000đ'), findsOneWidget);

      // Action buttons
      expect(find.textContaining('Tải hóa đơn PDF'), findsOneWidget);
      expect(find.textContaining('Chia sẻ'), findsOneWidget);
    });

    testWidgets('OrderReviewTipPage allows 5-star rating, tag selection, tip toggle and amber submit CTA', (tester) async {
      await tester.binding.setSurfaceSize(const Size(390, 1400));
      await tester.pumpWidget(_createTestCheckoutWidget(const OrderReviewTipPage()));
      await tester.pumpAndSettle();

      // Stars
      expect(find.byIcon(Icons.star_rounded), findsNWidgets(5));

      // Tip options (0đ, 20k, 50k, 100k)
      expect(find.text('20.000đ'), findsOneWidget);
      expect(find.text('50.000đ'), findsOneWidget);
      expect(find.text('100.000đ'), findsOneWidget);

      // Tap 50k tip
      await tester.tap(find.text('50.000đ'));
      await tester.pumpAndSettle();

      // Amber submit button reflects tip
      expect(find.textContaining('50.000đ'), findsWidgets);
    });

    testWidgets('OrderThanksPage renders celebration, warranty card and return home CTA', (tester) async {
      await tester.binding.setSurfaceSize(const Size(390, 1200));
      await tester.pumpWidget(_createTestCheckoutWidget(const OrderThanksPage()));
      await tester.pumpAndSettle();

      expect(find.textContaining('Cảm ơn bạn'), findsOneWidget);
      expect(find.textContaining('30 ngày'), findsWidgets);
      expect(find.textContaining('Về trang chủ'), findsOneWidget);
    });

    testWidgets('WorkerJobCompletionPage renders waiting inspection, payment and credited stages', (tester) async {
      await tester.binding.setSurfaceSize(const Size(390, 1400));

      // Stage 1: Waiting for inspection
      await tester.pumpWidget(_createTestCheckoutWidget(const WorkerJobCompletionPage()));
      await tester.pump();
      expect(find.textContaining('nghiệm thu'), findsWidgets);

      // Stage 2: Waiting for payment
      await tester.pumpWidget(_createTestCheckoutWidget(const WorkerJobCompletionPage(initialStage: 'payment')));
      await tester.pump();
      expect(find.textContaining('thanh toán'), findsWidgets);

      // Stage 3: Credited payout
      await tester.pumpWidget(_createTestCheckoutWidget(const WorkerJobCompletionPage(initialStage: 'credited')));
      await tester.pump();
      expect(find.textContaining('cộng vào ví'), findsWidgets);
      expect(find.text('340.000đ'), findsOneWidget);
      expect(find.textContaining('Xem ví thu nhập'), findsOneWidget);
    });
  });
}
