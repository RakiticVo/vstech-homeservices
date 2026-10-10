import 'dart:async';

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
import 'package:vstech_home_services/features/wallet/presentation/bloc/withdraw_cubit.dart';
import 'package:vstech_home_services/features/wallet/presentation/bloc/withdrawal_status_cubit.dart';
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
      GoRoute(
        path: AppRoutes.workerWithdrawPin,
        builder: (context, state) => const Scaffold(body: Text('PinTarget')),
      ),
      GoRoute(
        path: AppRoutes.workerWithdrawStatus,
        builder: (context, state) => Scaffold(body: Text('StatusTarget:${state.uri.queryParameters['id']}')),
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

    testWidgets('WorkerWithdrawPage checks the real balance and bank details before the PIN step', (tester) async {
      await tester.binding.setSurfaceSize(const Size(800, 1600));
      addTearDown(() => tester.binding.setSurfaceSize(null));
      final withdraw = MockWithdrawCubit();
      final states = StreamController<WithdrawState>.broadcast();
      addTearDown(states.close);
      const draft = WithdrawDraft(balance: 4860000);
      whenListen(withdraw, states.stream, initialState: const WithdrawEditingState(draft));
      when(withdraw.load).thenAnswer((_) async {});
      when(
        () => withdraw.review(
          amount: any(named: 'amount'),
          bankCode: any(named: 'bankCode'),
          bankAccountNumber: any(named: 'bankAccountNumber'),
        ),
      ).thenReturn(null);

      await tester.pumpWidget(
        _createTestWalletWidget(BlocProvider<WithdrawCubit>.value(value: withdraw, child: const WorkerWithdrawPage())),
      );
      await tester.pumpAndSettle();

      expect(find.text('Số tiền rút'), findsOneWidget);
      expect(find.text('4.860.000đ'), findsWidgets);
      // The hardcoded bank card is replaced by inputs (no saved-account API).
      expect(find.textContaining('Vietcombank'), findsNothing);

      await tester.tap(find.byKey(const Key('quick_amt_chip_1000000')));
      await tester.pumpAndSettle();
      final continueButton = find.byKey(const Key('withdraw_continue_button'));
      expect(tester.widget<ElevatedButton>(continueButton).onPressed, isNull, reason: 'bank details missing');

      await tester.enterText(find.byKey(const Key('withdraw_bank_code_input')), 'VCB');
      await tester.enterText(find.byKey(const Key('withdraw_account_input')), '1234567890');
      await tester.pumpAndSettle();
      await tester.tap(continueButton);
      verify(() => withdraw.review(amount: 1000000, bankCode: 'VCB', bankAccountNumber: '1234567890')).called(1);

      states.add(draft.copyWith(amount: 1000000, bankCode: 'VCB', bankAccountNumber: '1234567890').ready);
      await tester.pumpAndSettle();
      expect(find.text('PinTarget'), findsOneWidget);
    });

    testWidgets('WorkerWithdrawPinPage submits after 6 digits and opens the request status', (tester) async {
      final withdraw = MockWithdrawCubit();
      final states = StreamController<WithdrawState>.broadcast();
      addTearDown(states.close);
      const draft = WithdrawDraft(balance: 4860000, amount: 1000000, bankCode: 'VCB', bankAccountNumber: '123');
      whenListen(withdraw, states.stream, initialState: const WithdrawReadyState(draft));
      when(withdraw.submit).thenAnswer((_) async {});

      await tester.pumpWidget(
        _createTestWalletWidget(
          BlocProvider<WithdrawCubit>.value(value: withdraw, child: const WorkerWithdrawPinPage()),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Nhập mã PIN ví'), findsOneWidget);
      expect(find.textContaining('1.000.000đ'), findsOneWidget);

      for (var i = 0; i < 6; i++) {
        await tester.tap(find.byKey(const Key('pin_key_1')));
        await tester.pump();
      }
      verify(withdraw.submit).called(1);

      states.add(WithdrawSubmittedState(draft, pendingWithdrawal));
      await tester.pumpAndSettle();
      expect(find.text('StatusTarget:w-1'), findsOneWidget);
    });

    testWidgets('WorkerWithdrawStatusPage shows the request and its status timeline', (tester) async {
      final status = MockWithdrawalStatusCubit();
      when(() => status.load(any())).thenAnswer((_) async {});
      whenListen(
        status,
        const Stream<WithdrawalStatusState>.empty(),
        initialState: WithdrawalStatusLoadedState(pendingWithdrawal),
      );

      await tester.pumpWidget(
        _createTestWalletWidget(
          BlocProvider<WithdrawalStatusCubit>.value(
            value: status,
            child: const WorkerWithdrawStatusPage(withdrawalId: 'w-1'),
          ),
        ),
      );
      await tester.pumpAndSettle();

      verify(() => status.load('w-1')).called(1);
      expect(find.text('Đã gửi yêu cầu rút tiền thành công!'), findsOneWidget);
      expect(find.byKey(const Key('withdrawal_amount')), findsOneWidget);
      expect(find.text('500.000đ'), findsOneWidget);
      expect(find.text('VCB ••• 7890'), findsOneWidget);
      expect(find.byKey(const Key('withdrawal_status_pendingApproval')), findsOneWidget);
      expect(find.text('Đã gửi yêu cầu'), findsOneWidget);

      await tester.tap(find.text('Về ví thu nhập'));
      await tester.pumpAndSettle();
      expect(find.text('WalletTarget'), findsOneWidget);
    });
  });
}

extension on WithdrawDraft {
  WithdrawState get ready => WithdrawReadyState(this);
}
