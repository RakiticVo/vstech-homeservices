import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:vstech_home_services/core/error/failure.dart';
import 'package:vstech_home_services/core/error/result.dart';
import 'package:vstech_home_services/features/wallet/domain/entities/wallet.dart';
import 'package:vstech_home_services/features/wallet/domain/usecases/wallet_use_cases.dart';

part 'withdrawal_status_state.dart';

/// One withdrawal request for the status timeline screen.
@injectable
class WithdrawalStatusCubit extends Cubit<WithdrawalStatusState> {
  WithdrawalStatusCubit(this._getWithdrawal) : super(const WithdrawalStatusLoadingState());

  final GetWithdrawalUseCase _getWithdrawal;

  Future<void> load(String id) async {
    emit(const WithdrawalStatusLoadingState());
    switch (await _getWithdrawal(id)) {
      case Ok(:final value):
        emit(WithdrawalStatusLoadedState(value));
      case Err(:final failure):
        emit(WithdrawalStatusErrorState(failure));
    }
  }
}
