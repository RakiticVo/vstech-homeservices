import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:vstech_home_services/core/utils/json_converters.dart';

part 'quote_response.freezed.dart';
part 'quote_response.g.dart';

/// `QuoteResponse` of the quote approve/reject endpoints. The OpenAPI spec and the module doc
/// disagree on most fields, so everything except [status] is optional.
@freezed
abstract class QuoteResponse with _$QuoteResponse {
  const factory QuoteResponse({
    String? status,
    @NullableMoneyConverter() num? totalAmount,
  }) = _QuoteResponse;

  factory QuoteResponse.fromJson(Map<String, dynamic> json) =>
      _$QuoteResponseFromJson(json);
}
