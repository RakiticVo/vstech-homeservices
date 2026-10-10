import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:vstech_home_services/core/utils/json_converters.dart';

part 'wallet_response.freezed.dart';
part 'wallet_response.g.dart';

/// `data` of `GET /api/v1/wallets/me`. `balance` is spendable; `frozenBalance` is on hold.
@freezed
abstract class WalletResponse with _$WalletResponse {
  const factory WalletResponse({
    @NullableIdConverter() String? walletId,
    @NullableIdConverter() String? ownerId,
    @NullableMoneyConverter() num? balance,
    @NullableMoneyConverter() num? frozenBalance,
    String? currency,
    String? walletType,
    @NullableUtcDateTimeConverter() DateTime? createdAt,
  }) = _WalletResponse;

  factory WalletResponse.fromJson(Map<String, dynamic> json) => _$WalletResponseFromJson(json);
}
