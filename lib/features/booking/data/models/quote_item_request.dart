import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:vstech_home_services/core/utils/json_converters.dart';

part 'quote_item_request.freezed.dart';
part 'quote_item_request.g.dart';

/// One line of `SubmitQuoteRequest.items` (`QuoteItem`).
@freezed
abstract class QuoteItemRequest with _$QuoteItemRequest {
  // Freezed forwards this to the generated class — the documented way to set json options.
  // ignore: invalid_annotation_target
  @JsonSerializable(includeIfNull: false)
  const factory QuoteItemRequest({
    required String itemName,
    @MoneyConverter() required num amount,
    String? receiptUrl,
  }) = _QuoteItemRequest;

  factory QuoteItemRequest.fromJson(Map<String, dynamic> json) => _$QuoteItemRequestFromJson(json);
}
