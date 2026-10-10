import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:vstech_home_services/features/booking/data/models/quote_item_request.dart';

part 'submit_quote_request.freezed.dart';
part 'submit_quote_request.g.dart';

/// Body of `POST /api/v1/bookings/{id}/quote` — the worker's extra-cost quote.
@freezed
abstract class SubmitQuoteRequest with _$SubmitQuoteRequest {
  // Nested items must be serialised as maps, not objects.
  // ignore: invalid_annotation_target
  @JsonSerializable(explicitToJson: true)
  const factory SubmitQuoteRequest({
    required List<QuoteItemRequest> items,
    @Default(<String>[]) List<String> evidencePhotoUrls,
  }) = _SubmitQuoteRequest;

  factory SubmitQuoteRequest.fromJson(Map<String, dynamic> json) => _$SubmitQuoteRequestFromJson(json);
}
