import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:vstech_home_services/core/utils/json_converters.dart';

part 'withdrawal_request_body.freezed.dart';
part 'withdrawal_request_body.g.dart';

/// Body of `POST /api/v1/wallets/withdrawals` (`WithdrawalRequestDTO`) — all fields required.
@freezed
abstract class WithdrawalRequestBody with _$WithdrawalRequestBody {
  const factory WithdrawalRequestBody({
    @MoneyConverter() required num amount,
    required String bankCode,
    required String bankAccountNumber,
  }) = _WithdrawalRequestBody;

  factory WithdrawalRequestBody.fromJson(Map<String, dynamic> json) => _$WithdrawalRequestBodyFromJson(json);
}
