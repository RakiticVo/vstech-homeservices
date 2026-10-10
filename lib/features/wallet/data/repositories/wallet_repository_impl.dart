import 'package:injectable/injectable.dart';
import 'package:vstech_home_services/core/error/result.dart';
import 'package:vstech_home_services/features/wallet/data/datasources/wallet_remote_data_source.dart';
import 'package:vstech_home_services/features/wallet/data/models/wallet_transaction_response.dart';
import 'package:vstech_home_services/features/wallet/data/models/withdrawal_request_body.dart';
import 'package:vstech_home_services/features/wallet/data/models/withdrawal_response.dart';
import 'package:vstech_home_services/features/wallet/domain/entities/wallet.dart';
import 'package:vstech_home_services/features/wallet/domain/entities/wallet_enums.dart';
import 'package:vstech_home_services/features/wallet/domain/repositories/wallet_repository.dart';

/// Singleton so fetched transactions/withdrawals stay cached for their detail screens.
@LazySingleton(as: WalletRepository)
class WalletRepositoryImpl implements WalletRepository {
  WalletRepositoryImpl(this._remote);

  final WalletRemoteDataSource _remote;
  final Map<String, WalletTransaction> _transactions = {};
  final Map<String, Withdrawal> _withdrawals = {};

  static const int pageSize = 20;

  @override
  Future<Result<Wallet>> getWallet() => Result.guard(() async {
    final r = await _remote.getWallet();
    return Wallet(balance: r.balance ?? 0, frozenBalance: r.frozenBalance ?? 0, currency: r.currency ?? 'VND');
  });

  @override
  Future<Result<WalletPage<WalletTransaction>>> getTransactions({
    required int page,
    TransactionType? type,
    TransactionStatus? status,
  }) => Result.guard(() async {
    final response = await _remote.getTransactions(
      page: page,
      size: pageSize,
      type: type?.apiValue,
      status: status?.apiValue,
    );
    return WalletPage(
      items: [for (final item in response.content) _transactions[item.transactionKey] = _toTransaction(item)],
      page: response.page,
      hasMore: response.hasMore,
    );
  });

  @override
  WalletTransaction? cachedTransaction(String id) => _transactions[id];

  @override
  Future<Result<Withdrawal>> createWithdrawal({
    required num amount,
    required String bankCode,
    required String bankAccountNumber,
  }) => Result.guard(() async {
    final response = await _remote.createWithdrawal(
      WithdrawalRequestBody(amount: amount, bankCode: bankCode, bankAccountNumber: bankAccountNumber),
    );
    return _withdrawals[response.withdrawalKey] = _toWithdrawal(response);
  });

  @override
  Future<Result<WalletPage<Withdrawal>>> getWithdrawals({required int page}) => Result.guard(() async {
    final response = await _remote.getWithdrawals(page: page, size: pageSize);
    return WalletPage(
      items: [for (final item in response.content) _withdrawals[item.withdrawalKey] = _toWithdrawal(item)],
      page: response.page,
      hasMore: response.hasMore,
    );
  });

  @override
  Withdrawal? cachedWithdrawal(String id) => _withdrawals[id];

  static WalletTransaction _toTransaction(WalletTransactionResponse r) {
    final type = TransactionType.fromApi(r.kind);
    final amount = r.amount ?? r.delta?.abs() ?? 0;
    return WalletTransaction(
      id: r.transactionKey,
      type: type,
      status: TransactionStatus.fromApi(r.status),
      amount: amount,
      delta: r.delta ?? (type.isIncoming ? amount : -amount),
      description: r.description,
      referenceRequestId: r.referenceRequestId,
      createdAt: r.createdAt,
    );
  }

  static Withdrawal _toWithdrawal(WithdrawalResponse r) => Withdrawal(
    id: r.withdrawalKey,
    amount: r.amount ?? 0,
    status: WithdrawalStatus.fromApi(r.status),
    bankCode: r.bankCode,
    bankAccountNumber: r.bankAccountNumber,
    reason: r.rejectReason,
    createdAt: r.createdAt,
    updatedAt: r.updatedAt,
  );
}
