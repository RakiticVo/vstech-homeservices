part of 'withdraw_cubit.dart';

/// What the worker entered on the withdrawal form.
@immutable
class WithdrawDraft {
  const WithdrawDraft({required this.balance, this.amount = 0, this.bankCode = '', this.bankAccountNumber = ''});

  final num balance;
  final num amount;
  final String bankCode;
  final String bankAccountNumber;

  bool get isAmountValid => amount >= WithdrawCubit.minAmount && amount <= balance;

  bool get isValid => isAmountValid && bankCode.isNotEmpty && bankAccountNumber.isNotEmpty;

  WithdrawDraft copyWith({num? amount, String? bankCode, String? bankAccountNumber}) => WithdrawDraft(
    balance: balance,
    amount: amount ?? this.amount,
    bankCode: bankCode ?? this.bankCode,
    bankAccountNumber: bankAccountNumber ?? this.bankAccountNumber,
  );

  @override
  bool operator ==(Object other) =>
      other is WithdrawDraft &&
      other.balance == balance &&
      other.amount == amount &&
      other.bankCode == bankCode &&
      other.bankAccountNumber == bankAccountNumber;

  @override
  int get hashCode => Object.hash(balance, amount, bankCode, bankAccountNumber);
}

@immutable
sealed class WithdrawState {
  const WithdrawState();

  WithdrawDraft? get draft => null;
}

final class WithdrawLoadingState extends WithdrawState {
  const WithdrawLoadingState();
}

final class WithdrawLoadErrorState extends WithdrawState {
  const WithdrawLoadErrorState(this.failure);

  final Failure failure;

  @override
  bool operator ==(Object other) => other is WithdrawLoadErrorState && other.failure == failure;

  @override
  int get hashCode => failure.hashCode;
}

/// Base for states that carry the form.
sealed class WithdrawWithDraftState extends WithdrawState {
  const WithdrawWithDraftState(this.form);

  final WithdrawDraft form;

  @override
  WithdrawDraft get draft => form;

  @override
  bool operator ==(Object other) =>
      other.runtimeType == runtimeType && other is WithdrawWithDraftState && other.form == form;

  @override
  int get hashCode => Object.hash(runtimeType, form);
}

final class WithdrawEditingState extends WithdrawWithDraftState {
  const WithdrawEditingState(super.form);
}

/// The form is valid — open the PIN step.
final class WithdrawReadyState extends WithdrawWithDraftState {
  const WithdrawReadyState(super.form);
}

final class WithdrawSubmittingState extends WithdrawWithDraftState {
  const WithdrawSubmittingState(super.form);
}

final class WithdrawSubmittedState extends WithdrawWithDraftState {
  const WithdrawSubmittedState(super.form, this.withdrawal);

  final Withdrawal withdrawal;

  @override
  bool operator ==(Object other) => super == other && other is WithdrawSubmittedState && other.withdrawal == withdrawal;

  @override
  int get hashCode => Object.hash(super.hashCode, withdrawal);
}

final class WithdrawSubmitErrorState extends WithdrawWithDraftState {
  const WithdrawSubmitErrorState(super.form, this.failure);

  final Failure failure;

  @override
  bool operator ==(Object other) => super == other && other is WithdrawSubmitErrorState && other.failure == failure;

  @override
  int get hashCode => Object.hash(super.hashCode, failure);
}
