import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:vstech_home_services/core/utils/json_converters.dart';

part 'withdrawal_response.freezed.dart';
part 'withdrawal_response.g.dart';

/// `WithdrawalRequestResponse`. The module doc names fields `id`/`reason`, the OpenAPI spec
/// `requestId`/`rejectionReason` — both are declared; use [withdrawalKey] / [rejectReason].
@freezed
abstract class WithdrawalResponse with _$WithdrawalResponse {
  const factory WithdrawalResponse({
    @NullableIdConverter() String? id,
    @NullableIdConverter() String? requestId,
    @NullableMoneyConverter() num? amount,
    String? bankCode,
    String? bankAccountNumber,
    String? status,
    String? reason,
    String? rejectionReason,
    @NullableUtcDateTimeConverter() DateTime? createdAt,
    @NullableUtcDateTimeConverter() DateTime? updatedAt,
  }) = _WithdrawalResponse;

  const WithdrawalResponse._();

  factory WithdrawalResponse.fromJson(Map<String, dynamic> json) => _$WithdrawalResponseFromJson(json);

  String get withdrawalKey => id ?? requestId ?? '';

  String? get rejectReason => reason ?? rejectionReason;
}
