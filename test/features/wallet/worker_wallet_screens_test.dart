import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:vstech_home_services/core/router/app_routes.dart';
import 'package:vstech_home_services/core/theme/app_theme.dart';
import 'package:vstech_home_services/features/wallet/presentation/pages/worker_transaction_detail_page.dart';
import 'package:vstech_home_services/features/wallet/presentation/pages/worker_wallet_page.dart';
import 'package:vstech_home_services/features/wallet/presentation/pages/worker_withdraw_page.dart';
import 'package:vstech_home_services/features/wallet/presentation/pages/worker_withdraw_pin_page.dart';
import 'package:vstech_home_services/features/wallet/presentation/pages/worker_withdraw_status_page.dart';
import 'package:vstech_home_services/l10n/generated/app_localizations.dart';

Widget _createTestWalletWidget(Widget child) {
  final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => child,
      ),
      GoRoute(
        path: AppRoutes.workerWallet,
        builder: (context, state) => const WorkerWalletPage(),
      ),
      GoRoute(
        path: AppRoutes.workerWithdraw,
        builder: (context, state) => const WorkerWithdrawPage(),
      ),
      GoRoute(
        path: AppRoutes.workerWithdrawPin,
        builder: (context, state) => const WorkerWithdrawPinPage(),
      ),
      GoRoute(
        path: AppRoutes.workerWithdrawStatus,
        builder: (context, state) => const WorkerWithdrawStatusPage(),
      ),
      GoRoute(
        path: AppRoutes.workerJobsHub,
        builder: (context, state) => const Scaffold(body: Text('JobsHub')),
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

  group('Batch 13: Worker Wallet & Withdrawal Tests', () {
    testWidgets('WorkerWalletPage renders balance cards, tabs, and ledger transactions', (tester) async {
      await tester.pumpWidget(_createTestWalletWidget(const WorkerWalletPage()));
      await tester.pumpAndSettle();

      expect(find.text('Ví thu nhập'), findsWidgets);
      expect(find.text('Số dư có thể rút'), findsWidgets);
      expect(find.text('4.860.000đ'), findsWidgets);
      expect(find.text('Rút về tài khoản'), findsOneWidget);

      // Verify tabs exist
      expect(find.text('Tất cả'), findsOneWidget);
      expect(find.text('Thu nhập'), findsOneWidget);
      expect(find.text('Rút tiền'), findsOneWidget);
      expect(find.text('Tạm giữ'), findsOneWidget);

      // Tap on a tab
      await tester.tap(find.text('Thu nhập'));
      await tester.pumpAndSettle();

      expect(find.text('Tất cả'), findsOneWidget);
    });

    testWidgets('WorkerTransactionDetailPage renders breakdown and handles orders link', (tester) async {
      await tester.pumpWidget(
        _createTestWalletWidget(
          const WorkerTransactionDetailPage(txId: 'j12'),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Chi tiết giao dịch'), findsOneWidget);
      expect(find.text('Chi tiết số tiền'), findsOneWidget);
      expect(find.text('Khách trả'), findsOneWidget);
      expect(find.text('Phí nền tảng 15% trên giá dịch vụ'), findsOneWidget);
      expect(find.text('Thực nhận'), findsOneWidget);
      expect(find.text('Thông tin giao dịch'), findsOneWidget);
      expect(find.text('Mã giao dịch'), findsOneWidget);

      // Tap on related order link
      final orderLink = find.byKey(const Key('wtx_related_order_link'));
      expect(orderLink, findsOneWidget);
      await tester.tap(orderLink);
      await tester.pumpAndSettle();

      expect(find.text('JobsHub'), findsOneWidget);
    });

    testWidgets('WorkerWithdrawPage validates quick chips and enables continue button', (tester) async {
      await tester.pumpWidget(_createTestWalletWidget(const WorkerWithdrawPage()));
      await tester.pumpAndSettle();

      expect(find.text('Rút về tài khoản'), findsWidgets);
      expect(find.text('Số tiền rút'), findsOneWidget);
      expect(find.text('Số dư hiện tại'), findsOneWidget);
      expect(find.textContaining('Vietcombank'), findsWidgets);

      // Tap quick amount chip '1 triệu'
      final chip1M = find.byKey(const Key('quick_amt_chip_1000000'));
      expect(chip1M, findsOneWidget);
      await tester.tap(chip1M);
      await tester.pumpAndSettle();

      // Tap continue button to trigger navigation
      final continueBtn = find.byKey(const Key('withdraw_continue_button'));
      expect(continueBtn, findsOneWidget);
      await tester.tap(continueBtn);
      await tester.pumpAndSettle();

      // Should navigate to PIN screen
      expect(find.text('Nhập mã PIN ví'), findsOneWidget);
    });

    testWidgets('WorkerWithdrawPinPage keypad input and backspace work as expected', (tester) async {
      await tester.pumpWidget(
        _createTestWalletWidget(
          const WorkerWithdrawPinPage(withdrawalAmount: '1.000.000đ'),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Nhập mã PIN ví'), findsOneWidget);
      expect(find.textContaining('1.000.000đ'), findsOneWidget);

      // Press key '1'
      final key1 = find.byKey(const Key('pin_key_1'));
      expect(key1, findsOneWidget);
      await tester.tap(key1);
      await tester.pumpAndSettle();

      // Press backspace
      final backspace = find.byKey(const Key('pin_key_backspace'));
      expect(backspace, findsOneWidget);
      await tester.tap(backspace);
      await tester.pumpAndSettle();

      expect(find.text('Nhập mã PIN ví'), findsOneWidget);
    });

    testWidgets('WorkerWithdrawStatusPage displays 3-stage timeline and back CTA', (tester) async {
      await tester.pumpWidget(
        _createTestWalletWidget(
          const WorkerWithdrawStatusPage(withdrawalAmount: '2.000.000đ'),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Yêu cầu rút tiền'), findsOneWidget);
      expect(find.text('Đã gửi yêu cầu rút tiền thành công!'), findsOneWidget);
      expect(find.text('2.000.000đ'), findsOneWidget);
      expect(find.text('Vietcombank ••• 4821'), findsOneWidget);

      // Timeline steps
      expect(find.text('Đã gửi yêu cầu'), findsOneWidget);
      expect(find.text('Chờ kế toán duyệt (trong 24 giờ)'), findsOneWidget);
      expect(find.text('Đã chuyển khoản'), findsOneWidget);

      // Back to wallet CTA
      final backWalletBtn = find.text('Về ví thu nhập');
      expect(backWalletBtn, findsOneWidget);
      await tester.tap(backWalletBtn);
      await tester.pumpAndSettle();

      expect(find.text('Ví thu nhập'), findsWidgets);
    });
  });
}
