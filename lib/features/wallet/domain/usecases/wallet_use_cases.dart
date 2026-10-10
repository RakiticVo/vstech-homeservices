import 'package:injectable/injectable.dart';
import 'package:vstech_home_services/core/error/failure.dart';
import 'package:vstech_home_services/core/error/result.dart';
import 'package:vstech_home_services/core/network/network_exception.dart';
import 'package:vstech_home_services/features/wallet/domain/entities/wallet.dart';
import 'package:vstech_home_services/features/wallet/domain/entities/wallet_enums.dart';
import 'package:vstech_home_services/features/wallet/domain/repositories/wallet_repository.dart';

@injectable
class GetWalletUseCase {
  const GetWalletUseCase(this._repository);

  final WalletRepository _repository;

  Future<Result<Wallet>> call() => _repository.getWallet();
}

@injectable
class GetTransactionsUseCase {
  const GetTransactionsUseCase(this._repository);

  final WalletRepository _repository;

  Future<Result<WalletPage<WalletTransaction>>> call({
    int page = 0,
    TransactionType? type,
    TransactionStatus? status,
  }) => _repository.getTransactions(page: page, type: type, status: status);
}

/// Creates a withdrawal request. Rejects locally what the server would: amount above the available
/// balance (`HS-400-0020`) or missing / non-positive input (`HS-400-0001`).
@injectable
class CreateWithdrawalUseCase {
  const CreateWithdrawalUseCase(this._repository);

  final WalletRepository _repository;

  Future<Result<Withdrawal>> call({
    required num amount,
    required String bankCode,
    required String bankAccountNumber,
    num? availableBalance,
  }) async {
    if (amount <= 0 || bankCode.trim().isEmpty || bankAccountNumber.trim().isEmpty) {
      return const Err(Failure(kind: NetworkErrorKind.unknown, errorCode: 'HS-400-0001'));
    }
    if (availableBalance != null && amount > availableBalance) {
      return const Err(Failure(kind: NetworkErrorKind.unknown, errorCode: 'HS-400-0020'));
    }
    return await _repository.createWithdrawal(
      amount: amount,
      bankCode: bankCode.trim().toUpperCase(),
      bankAccountNumber: bankAccountNumber.replaceAll(RegExp(r'\s'), ''),
    );
  }
}

/// One withdrawal by id: cache first, otherwise the first pages of `GET /wallets/withdrawals`.
@injectable
class GetWithdrawalUseCase {
  const GetWithdrawalUseCase(this._repository);

  final WalletRepository _repository;

  static const int maxPages = 3;

  Future<Result<Withdrawal>> call(String id) async {
    final cached = _repository.cachedWithdrawal(id);
    if (cached != null) return Ok(cached);
    for (var page = 0; page < maxPages; page++) {
      final result = await _repository.getWithdrawals(page: page);
      if (result is Err<WalletPage<Withdrawal>>) return Err(result.failure);
      final value = (result as Ok<WalletPage<Withdrawal>>).value;
      for (final withdrawal in value.items) {
        if (withdrawal.id == id) return Ok(withdrawal);
      }
      if (!value.hasMore) break;
    }
    return const Err(Failure(kind: NetworkErrorKind.server, errorCode: 'HS-404-0021', statusCode: 404));
  }
}

/// One transaction by id: cache first, otherwise the first pages of the ledger.
@injectable
class GetTransactionUseCase {
  const GetTransactionUseCase(this._repository);

  final WalletRepository _repository;

  static const int maxPages = 3;

  Future<Result<WalletTransaction>> call(String id) async {
    final cached = _repository.cachedTransaction(id);
    if (cached != null) return Ok(cached);
    for (var page = 0; page < maxPages; page++) {
      final result = await _repository.getTransactions(page: page);
      if (result is Err<WalletPage<WalletTransaction>>) return Err(result.failure);
      final value = (result as Ok<WalletPage<WalletTransaction>>).value;
      for (final transaction in value.items) {
        if (transaction.id == id) return Ok(transaction);
      }
      if (!value.hasMore) break;
    }
    return const Err(Failure(kind: NetworkErrorKind.server, errorCode: 'HS-404-0001', statusCode: 404));
  }
}
