part of 'withdrawal_status_cubit.dart';

@immutable
sealed class WithdrawalStatusState {
  const WithdrawalStatusState();
}

final class WithdrawalStatusLoadingState extends WithdrawalStatusState {
  const WithdrawalStatusLoadingState();
}

final class WithdrawalStatusLoadedState extends WithdrawalStatusState {
  const WithdrawalStatusLoadedState(this.withdrawal);

  final Withdrawal withdrawal;

  @override
  bool operator ==(Object other) => other is WithdrawalStatusLoadedState && other.withdrawal == withdrawal;

  @override
  int get hashCode => withdrawal.hashCode;
}

final class WithdrawalStatusErrorState extends WithdrawalStatusState {
  const WithdrawalStatusErrorState(this.failure);

  final Failure failure;

  @override
  bool operator ==(Object other) => other is WithdrawalStatusErrorState && other.failure == failure;

  @override
  int get hashCode => failure.hashCode;
}
