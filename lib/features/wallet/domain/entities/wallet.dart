import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:vstech_home_services/features/wallet/domain/entities/wallet_enums.dart';

part 'wallet.freezed.dart';

/// The signed-in user's wallet.
@freezed
abstract class Wallet with _$Wallet {
  const factory Wallet({required num balance, @Default(0) num frozenBalance, @Default('VND') String currency}) =
      _Wallet;
}

/// One wallet ledger entry. [delta] is signed: positive = money in, negative = money out.
@freezed
abstract class WalletTransaction with _$WalletTransaction {
  const factory WalletTransaction({
    required String id,
    required TransactionType type,
    required TransactionStatus status,
    required num amount,
    required num delta,
    String? description,
    String? referenceRequestId,
    DateTime? createdAt,
  }) = _WalletTransaction;
}

/// A withdrawal-to-bank request.
@freezed
abstract class Withdrawal with _$Withdrawal {
  const factory Withdrawal({
    required String id,
    required num amount,
    required WithdrawalStatus status,
    String? bankCode,
    String? bankAccountNumber,
    String? reason,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _Withdrawal;
}

/// One page of a paged wallet list.
class WalletPage<T> {
  const WalletPage({required this.items, required this.page, required this.hasMore});

  final List<T> items;
  final int page;
  final bool hasMore;
}
