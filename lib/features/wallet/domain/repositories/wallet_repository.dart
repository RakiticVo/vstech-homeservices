import 'package:vstech_home_services/core/error/result.dart';
import 'package:vstech_home_services/features/wallet/domain/entities/wallet.dart';
import 'package:vstech_home_services/features/wallet/domain/entities/wallet_enums.dart';

abstract interface class WalletRepository {
  Future<Result<Wallet>> getWallet();

  Future<Result<WalletPage<WalletTransaction>>> getTransactions({
    required int page,
    TransactionType? type,
    TransactionStatus? status,
  });

  /// Last fetched copy — there is no `GET /wallets/me/transactions/{id}`.
  WalletTransaction? cachedTransaction(String id);

  Future<Result<Withdrawal>> createWithdrawal({
    required num amount,
    required String bankCode,
    required String bankAccountNumber,
  });

  Future<Result<WalletPage<Withdrawal>>> getWithdrawals({required int page});

  /// Last fetched copy — there is no `GET /wallets/withdrawals/{id}`.
  Withdrawal? cachedWithdrawal(String id);
}
