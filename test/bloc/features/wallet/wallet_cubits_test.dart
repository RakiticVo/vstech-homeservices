import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vstech_home_services/core/error/failure.dart';
import 'package:vstech_home_services/core/error/result.dart';
import 'package:vstech_home_services/core/network/network_exception.dart';
import 'package:vstech_home_services/features/wallet/domain/entities/wallet.dart';
import 'package:vstech_home_services/features/wallet/presentation/bloc/transaction_detail_cubit.dart';
import 'package:vstech_home_services/features/wallet/presentation/bloc/wallet_cubit.dart';

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
}

late MockGetTransactionUseCase _getTransaction;
