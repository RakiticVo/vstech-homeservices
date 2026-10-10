import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:vstech_home_services/core/utils/json_converters.dart';

part 'wallet_transaction_response.freezed.dart';
part 'wallet_transaction_response.g.dart';

/// Element of `GET /api/v1/wallets/me/transactions`. The module doc names fields `id`/`type`,
/// the OpenAPI spec `transactionId`/`txType` — both are declared; use [transactionKey] / [kind].
@freezed
abstract class WalletTransactionResponse with _$WalletTransactionResponse {
  const factory WalletTransactionResponse({
    @NullableIdConverter() String? id,
    @NullableIdConverter() String? transactionId,
    String? type,
    String? txType,
    @NullableMoneyConverter() num? amount,
    @NullableMoneyConverter() num? delta,
    String? status,
    String? description,
    @NullableIdConverter() String? referenceRequestId,
    @NullableUtcDateTimeConverter() DateTime? createdAt,
  }) = _WalletTransactionResponse;

  const WalletTransactionResponse._();

  factory WalletTransactionResponse.fromJson(Map<String, dynamic> json) => _$WalletTransactionResponseFromJson(json);

  String get transactionKey => id ?? transactionId ?? '';

  String? get kind => type ?? txType;
}
