import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:vstech_home_services/core/error/failure.dart';
import 'package:vstech_home_services/core/error/result.dart';
import 'package:vstech_home_services/features/wallet/domain/entities/wallet.dart';
import 'package:vstech_home_services/features/wallet/domain/usecases/wallet_use_cases.dart';

part 'wallet_state.dart';

/// Wallet balance (`GET /wallets/me`) plus the paged ledger (`GET /wallets/me/transactions`).
@injectable
class WalletCubit extends Cubit<WalletState> {
  WalletCubit(this._getWallet, this._getTransactions) : super(const WalletLoadingState());

  final GetWalletUseCase _getWallet;
  final GetTransactionsUseCase _getTransactions;

  Future<void> load() async {
    if (state is! WalletLoadedState) emit(const WalletLoadingState());
    final (wallet, transactions) = await (_getWallet(), _getTransactions()).wait;
    switch ((wallet, transactions)) {
      case (Ok(value: final wallet), Ok(value: final page)):
        emit(WalletLoadedState(wallet: wallet, transactions: page.items, page: page.page, hasMore: page.hasMore));
      case (Err(:final failure), _) || (_, Err(:final failure)):
        emit(WalletErrorState(failure));
    }
  }

  Future<void> loadMore() async {
    final current = state;
    if (current is! WalletLoadedState || !current.hasMore || current.isLoadingMore) return;
    emit(current.copyWith(isLoadingMore: true));
    switch (await _getTransactions(page: current.page + 1)) {
      case Ok(:final value):
        emit(
          current.copyWith(
            transactions: [...current.transactions, ...value.items],
            page: value.page,
            hasMore: value.hasMore,
            isLoadingMore: false,
          ),
        );
      case Err():
        emit(current.copyWith(isLoadingMore: false));
    }
  }
}
