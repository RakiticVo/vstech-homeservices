import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:vstech_home_services/core/error/failure.dart';
import 'package:vstech_home_services/core/error/result.dart';
import 'package:vstech_home_services/features/wallet/domain/entities/wallet.dart';
import 'package:vstech_home_services/features/wallet/domain/usecases/wallet_use_cases.dart';

part 'withdraw_state.dart';

/// Withdrawal wizard shared by the amount/bank screen and the PIN screen (one ShellRoute):
/// load balance → review input → (simulated PIN) → `POST /wallets/withdrawals`.
@injectable
class WithdrawCubit extends Cubit<WithdrawState> {
  WithdrawCubit(this._getWallet, this._createWithdrawal) : super(const WithdrawLoadingState());

  final GetWalletUseCase _getWallet;
  final CreateWithdrawalUseCase _createWithdrawal;

  /// App-side minimum shown in the design (the API documents no minimum).
  static const num minAmount = 100000;

  Future<void> load() async {
    emit(const WithdrawLoadingState());
    switch (await _getWallet()) {
      case Ok(:final value):
        emit(WithdrawEditingState(WithdrawDraft(balance: value.balance)));
      case Err(:final failure):
        emit(WithdrawLoadErrorState(failure));
    }
  }

  /// Validates the form; [WithdrawReadyState] means the PIN step can open.
  void review({required num amount, required String bankCode, required String bankAccountNumber}) {
    final draft = state.draft;
    if (draft == null) return;
    final next = draft.copyWith(amount: amount, bankCode: bankCode.trim(), bankAccountNumber: bankAccountNumber.trim());
    emit(next.isValid ? WithdrawReadyState(next) : WithdrawEditingState(next));
  }

  Future<void> submit() async {
    final draft = state.draft;
    if (draft == null || !draft.isValid || state is WithdrawSubmittingState) return;
    emit(WithdrawSubmittingState(draft));
    final result = await _createWithdrawal(
      amount: draft.amount,
      bankCode: draft.bankCode,
      bankAccountNumber: draft.bankAccountNumber,
      availableBalance: draft.balance,
    );
    switch (result) {
      case Ok(:final value):
        emit(WithdrawSubmittedState(draft, value));
      case Err(:final failure):
        emit(WithdrawSubmitErrorState(draft, failure));
    }
  }
}
