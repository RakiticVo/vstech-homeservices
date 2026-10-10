part of 'transaction_detail_cubit.dart';

@immutable
sealed class TransactionDetailState {
  const TransactionDetailState();
}

final class TransactionDetailLoadingState extends TransactionDetailState {
  const TransactionDetailLoadingState();
}

final class TransactionDetailLoadedState extends TransactionDetailState {
  const TransactionDetailLoadedState(this.transaction);

  final WalletTransaction transaction;

  @override
  bool operator ==(Object other) => other is TransactionDetailLoadedState && other.transaction == transaction;

  @override
  int get hashCode => transaction.hashCode;
}

final class TransactionDetailErrorState extends TransactionDetailState {
  const TransactionDetailErrorState(this.failure);

  final Failure failure;

  @override
  bool operator ==(Object other) => other is TransactionDetailErrorState && other.failure == failure;

  @override
  int get hashCode => failure.hashCode;
}
