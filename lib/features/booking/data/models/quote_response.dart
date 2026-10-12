import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:vstech_home_services/core/utils/json_converters.dart';

part 'quote_response.freezed.dart';
part 'quote_response.g.dart';

/// `QuoteResponse` of the quote submit / approve / reject endpoints. The OpenAPI spec and the
/// module doc disagree on most fields (`submittedAt` vs `createdAt` — C16), so all are optional.
@freezed
abstract class QuoteResponse with _$QuoteResponse {
  const factory QuoteResponse({
    String? status,
    @NullableMoneyConverter() num? totalAmount,
    @NullableUtcDateTimeConverter() DateTime? submittedAt,
    @NullableUtcDateTimeConverter() DateTime? createdAt,
  }) = _QuoteResponse;

  factory QuoteResponse.fromJson(Map<String, dynamic> json) =>
      _$QuoteResponseFromJson(json);
}
