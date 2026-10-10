import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vstech_home_services/core/router/app_routes.dart';
import 'package:vstech_home_services/core/theme/app_theme.dart';
import 'package:vstech_home_services/features/wallet/presentation/bloc/transaction_detail_cubit.dart';
import 'package:vstech_home_services/features/wallet/presentation/bloc/wallet_cubit.dart';
import 'package:vstech_home_services/features/wallet/presentation/pages/worker_transaction_detail_page.dart';
import 'package:vstech_home_services/features/wallet/presentation/pages/worker_wallet_page.dart';
import 'package:vstech_home_services/features/wallet/presentation/pages/worker_withdraw_page.dart';
import 'package:vstech_home_services/features/wallet/presentation/pages/worker_withdraw_pin_page.dart';
import 'package:vstech_home_services/features/wallet/presentation/pages/worker_withdraw_status_page.dart';
import 'package:vstech_home_services/l10n/generated/app_localizations.dart';

import '../../fixtures/wallet/wallet_fixtures.dart';
import '../../helpers/mocks.dart';

Widget _createTestWalletWidget(Widget child) {
  final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(path: '/', builder: (context, state) => child),
      GoRoute(
        path: AppRoutes.workerWallet,
        builder: (context, state) => const Scaffold(body: Text('WalletTarget')),
      ),
      GoRoute(
        path: AppRoutes.workerTransactionDetail,
        builder: (context, state) => Scaffold(body: Text('TxDetail:${state.uri.queryParameters['id']}')),
      ),
      GoRoute(
        path: AppRoutes.workerJobDetail,
        builder: (context, state) => Scaffold(body: Text('JobDetail:${state.uri.queryParameters['id']}')),
      ),
      GoRoute(path: AppRoutes.workerWithdraw, builder: (context, state) => const WorkerWithdrawPage()),
      GoRoute(path: AppRoutes.workerWithdrawPin, builder: (context, state) => const WorkerWithdrawPinPage()),
      GoRoute(path: AppRoutes.workerWithdrawStatus, builder: (context, state) => const WorkerWithdrawStatusPage()),
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
    supportedLocales: const [Locale('vi'), Locale('en')],
    locale: const Locale('vi'),
  );
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Batch 13: Worker Wallet & Withdrawal Tests', () {
    testWidgets('WorkerWalletPage shows API balance, on-hold amount and filters the ledger', (tester) async {
      await tester.binding.setSurfaceSize(const Size(800, 1600));
      addTearDown(() => tester.binding.setSurfaceSize(null));
      final walletCubit = MockWalletCubit();
      when(walletCubit.load).thenAnswer((_) async {});
      when(walletCubit.loadMore).thenAnswer((_) async {});
      whenListen(
        walletCubit,
        const Stream<WalletState>.empty(),
        initialState: WalletLoadedState(wallet: wallet, transactions: [earning, withdrawalTx], page: 0, hasMore: true),
      );

      await tester.pumpWidget(
        _createTestWalletWidget(BlocProvider<WalletCubit>.value(value: walletCubit, child: const WorkerWalletPage())),
      );
      await tester.pumpAndSettle();

      expect(find.text('Ví thu nhập'), findsWidgets);
      expect(find.byKey(const Key('wallet_available_balance_text')), findsOneWidget);
      expect(find.text('4.860.000đ'), findsWidgets);
      expect(find.text('340.000đ'), findsOneWidget);
      // Totals earned/withdrawn are not in the API any more.
      expect(find.text('Tổng thu nhập đã về'), findsNothing);

      expect(find.text('Thu nhập đơn #501'), findsOneWidget);
      expect(find.text('+297.500đ'), findsOneWidget);
      expect(find.text('−2.000.000đ'), findsOneWidget);

      await tester.tap(find.byKey(const Key('wallet_filter_chip_2')));
      await tester.pumpAndSettle();
      expect(find.text('+297.500đ'), findsNothing);
      expect(find.text('−2.000.000đ'), findsOneWidget);

      await tester.tap(find.byKey(const Key('wallet_load_more_button')));
      verify(walletCubit.loadMore).called(1);

      await tester.tap(find.byKey(const Key('tx_item_42')));
      await tester.pumpAndSettle();
      expect(find.text('TxDetail:42'), findsOneWidget);
    });

    testWidgets('WorkerTransactionDetailPage shows the ledger entry and links the related job', (tester) async {
      final detail = MockTransactionDetailCubit();
      when(() => detail.load(any())).thenAnswer((_) async {});
      whenListen(
        detail,
        const Stream<TransactionDetailState>.empty(),
        initialState: TransactionDetailLoadedState(earning),
      );

      await tester.pumpWidget(
        _createTestWalletWidget(
          BlocProvider<TransactionDetailCubit>.value(
            value: detail,
            child: const WorkerTransactionDetailPage(transactionId: 't-1'),
          ),
        ),
      );
      await tester.pumpAndSettle();

      verify(() => detail.load('t-1')).called(1);
      expect(find.text('Chi tiết giao dịch'), findsOneWidget);
      expect(find.byKey(const Key('transaction_amount')), findsOneWidget);
      expect(find.text('+297.500đ'), findsOneWidget);
      expect(find.text('Thành công'), findsOneWidget);
      expect(find.text('#t-1'), findsOneWidget);

      await tester.tap(find.byKey(const Key('transaction_related_order')));
      await tester.pumpAndSettle();
      expect(find.text('JobDetail:501'), findsOneWidget);
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
      await tester.pumpWidget(_createTestWalletWidget(const WorkerWithdrawPinPage(withdrawalAmount: '1.000.000đ')));
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
      await tester.pumpWidget(_createTestWalletWidget(const WorkerWithdrawStatusPage(withdrawalAmount: '2.000.000đ')));
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

      expect(find.text('WalletTarget'), findsOneWidget);
    });
  });
}
