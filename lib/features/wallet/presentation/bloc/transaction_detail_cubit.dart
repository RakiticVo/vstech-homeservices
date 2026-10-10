import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:vstech_home_services/core/error/failure.dart';
import 'package:vstech_home_services/core/error/result.dart';
import 'package:vstech_home_services/features/wallet/domain/entities/wallet.dart';
import 'package:vstech_home_services/features/wallet/domain/usecases/wallet_use_cases.dart';

part 'transaction_detail_state.dart';

/// One ledger entry for the transaction detail screen.
@injectable
class TransactionDetailCubit extends Cubit<TransactionDetailState> {
  TransactionDetailCubit(this._getTransaction) : super(const TransactionDetailLoadingState());

  final GetTransactionUseCase _getTransaction;

  Future<void> load(String id) async {
    emit(const TransactionDetailLoadingState());
    switch (await _getTransaction(id)) {
      case Ok(:final value):
        emit(TransactionDetailLoadedState(value));
      case Err(:final failure):
        emit(TransactionDetailErrorState(failure));
    }
  }
}
