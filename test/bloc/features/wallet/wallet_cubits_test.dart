import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vstech_home_services/core/error/failure.dart';
import 'package:vstech_home_services/core/error/result.dart';
import 'package:vstech_home_services/core/network/network_exception.dart';
import 'package:vstech_home_services/features/wallet/domain/entities/wallet.dart';
import 'package:vstech_home_services/features/wallet/presentation/bloc/transaction_detail_cubit.dart';
import 'package:vstech_home_services/features/wallet/presentation/bloc/wallet_cubit.dart';
import 'package:vstech_home_services/features/wallet/presentation/bloc/withdraw_cubit.dart';
import 'package:vstech_home_services/features/wallet/presentation/bloc/withdrawal_status_cubit.dart';

import '../../../fixtures/wallet/wallet_fixtures.dart';
import '../../../helpers/mocks.dart';

const _offline = Failure(kind: NetworkErrorKind.noConnection);

void main() {
  late MockGetWalletUseCase getWallet;
  late MockGetTransactionsUseCase getTransactions;

  setUp(() {
    getWallet = MockGetWalletUseCase();
    getTransactions = MockGetTransactionsUseCase();
  });

  blocTest<WalletCubit, WalletState>(
    'load emits the wallet with the first ledger page',
    setUp: () {
      when(() => getWallet()).thenAnswer((_) async => const Ok<Wallet>(wallet));
      when(() => getTransactions()).thenAnswer((_) async => Ok(WalletPage(items: [earning], page: 0, hasMore: true)));
    },
    build: () => WalletCubit(getWallet, getTransactions),
    act: (cubit) => cubit.load(),
    expect: () => [
      const WalletLoadingState(),
      WalletLoadedState(wallet: wallet, transactions: [earning], page: 0, hasMore: true),
    ],
  );

  blocTest<WalletCubit, WalletState>(
    'either request failing is an error',
    setUp: () {
      when(() => getWallet()).thenAnswer((_) async => const Ok<Wallet>(wallet));
      when(() => getTransactions()).thenAnswer((_) async => const Err<WalletPage<WalletTransaction>>(_offline));
    },
    build: () => WalletCubit(getWallet, getTransactions),
    act: (cubit) => cubit.load(),
    expect: () => [const WalletLoadingState(), const WalletErrorState(_offline)],
  );

  final first = WalletLoadedState(wallet: wallet, transactions: [earning], page: 0, hasMore: true);

  blocTest<WalletCubit, WalletState>(
    'loadMore appends the next page',
    setUp: () =>
        when(() => getTransactions(page: 1))
            .thenAnswer((_) async => Ok(WalletPage(items: [withdrawalTx], page: 1, hasMore: false))),
    build: () => WalletCubit(getWallet, getTransactions),
    seed: () => first,
    act: (cubit) => cubit.loadMore(),
    expect: () => [
      first.copyWith(isLoadingMore: true),
      first.copyWith(transactions: [earning, withdrawalTx], page: 1, hasMore: false),
    ],
  );

  blocTest<TransactionDetailCubit, TransactionDetailState>(
    'transaction detail loads by id',
    setUp: () {
      final getTransaction = MockGetTransactionUseCase();
      when(() => getTransaction('t-1')).thenAnswer((_) async => Ok(earning));
      _getTransaction = getTransaction;
    },
    build: () => TransactionDetailCubit(_getTransaction),
    act: (cubit) => cubit.load('t-1'),
    expect: () => [const TransactionDetailLoadingState(), TransactionDetailLoadedState(earning)],
  );

  group('withdraw', _withdrawTests);
}

late MockGetTransactionUseCase _getTransaction;

void _withdrawTests() {
  late MockGetWalletUseCase getWallet;
  late MockCreateWithdrawalUseCase createWithdrawal;

  setUp(() {
    getWallet = MockGetWalletUseCase();
    createWithdrawal = MockCreateWithdrawalUseCase();
  });

  const draft = WithdrawDraft(balance: 4860000);
  final ready = draft.copyWith(amount: 1000000, bankCode: 'VCB', bankAccountNumber: '123');

  blocTest<WithdrawCubit, WithdrawState>(
    'load reads the available balance',
    setUp: () => when(() => getWallet()).thenAnswer((_) async => const Ok<Wallet>(wallet)),
    build: () => WithdrawCubit(getWallet, createWithdrawal),
    act: (cubit) => cubit.load(),
    expect: () => [const WithdrawLoadingState(), const WithdrawEditingState(draft)],
  );

  blocTest<WithdrawCubit, WithdrawState>(
    'review accepts a valid form and keeps editing otherwise',
    build: () => WithdrawCubit(getWallet, createWithdrawal),
    seed: () => const WithdrawEditingState(draft),
    act: (cubit) {
      cubit
        ..review(amount: 50000, bankCode: 'VCB', bankAccountNumber: '123')
        ..review(amount: 1000000, bankCode: ' VCB ', bankAccountNumber: '123');
    },
    expect: () => [
      WithdrawEditingState(draft.copyWith(amount: 50000, bankCode: 'VCB', bankAccountNumber: '123')),
      WithdrawReadyState(ready),
    ],
  );

  blocTest<WithdrawCubit, WithdrawState>(
    'submit creates the withdrawal against the balance',
    setUp: () => when(
      () => createWithdrawal(amount: 1000000, bankCode: 'VCB', bankAccountNumber: '123', availableBalance: 4860000),
    ).thenAnswer((_) async => Ok(pendingWithdrawal)),
    build: () => WithdrawCubit(getWallet, createWithdrawal),
    seed: () => WithdrawReadyState(ready),
    act: (cubit) => cubit.submit(),
    expect: () => [WithdrawSubmittingState(ready), WithdrawSubmittedState(ready, pendingWithdrawal)],
  );

  blocTest<WithdrawCubit, WithdrawState>(
    'submit failure keeps the form',
    setUp: () => when(
      () => createWithdrawal(
        amount: any(named: 'amount'),
        bankCode: any(named: 'bankCode'),
        bankAccountNumber: any(named: 'bankAccountNumber'),
        availableBalance: any(named: 'availableBalance'),
      ),
    ).thenAnswer((_) async => const Err<Withdrawal>(_offline)),
    build: () => WithdrawCubit(getWallet, createWithdrawal),
    seed: () => WithdrawReadyState(ready),
    act: (cubit) => cubit.submit(),
    expect: () => [WithdrawSubmittingState(ready), WithdrawSubmitErrorState(ready, _offline)],
  );

  blocTest<WithdrawalStatusCubit, WithdrawalStatusState>(
    'status loads the withdrawal',
    setUp: () {
      final getWithdrawal = MockGetWithdrawalUseCase();
      when(() => getWithdrawal('w-1')).thenAnswer((_) async => Ok(pendingWithdrawal));
      _getWithdrawal = getWithdrawal;
    },
    build: () => WithdrawalStatusCubit(_getWithdrawal),
    act: (cubit) => cubit.load('w-1'),
    expect: () => [const WithdrawalStatusLoadingState(), WithdrawalStatusLoadedState(pendingWithdrawal)],
  );
}

late MockGetWithdrawalUseCase _getWithdrawal;
