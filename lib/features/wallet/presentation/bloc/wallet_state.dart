part of 'wallet_cubit.dart';

@immutable
sealed class WalletState {
  const WalletState();
}

final class WalletLoadingState extends WalletState {
  const WalletLoadingState();
}

final class WalletErrorState extends WalletState {
  const WalletErrorState(this.failure);

  final Failure failure;

  @override
  bool operator ==(Object other) => other is WalletErrorState && other.failure == failure;

  @override
  int get hashCode => failure.hashCode;
}

final class WalletLoadedState extends WalletState {
  const WalletLoadedState({
    required this.wallet,
    required this.transactions,
    required this.page,
    required this.hasMore,
    this.isLoadingMore = false,
  });

  final Wallet wallet;
  final List<WalletTransaction> transactions;
  final int page;
  final bool hasMore;
  final bool isLoadingMore;

  WalletLoadedState copyWith({List<WalletTransaction>? transactions, int? page, bool? hasMore, bool? isLoadingMore}) =>
      WalletLoadedState(
        wallet: wallet,
        transactions: transactions ?? this.transactions,
        page: page ?? this.page,
        hasMore: hasMore ?? this.hasMore,
        isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      );

  @override
  bool operator ==(Object other) =>
      other is WalletLoadedState &&
      other.wallet == wallet &&
      listEquals(other.transactions, transactions) &&
      other.page == page &&
      other.hasMore == hasMore &&
      other.isLoadingMore == isLoadingMore;

  @override
  int get hashCode => Object.hash(wallet, Object.hashAll(transactions), page, hasMore, isLoadingMore);
}
