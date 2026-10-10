import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:vstech_home_services/core/utils/json_converters.dart';

part 'complete_booking_request.freezed.dart';
part 'complete_booking_request.g.dart';

/// Body of `POST /api/v1/bookings/{id}/complete`. [actualPrice] may not exceed 1.5 × the estimate
/// (`HS-400-0012`).
@freezed
abstract class CompleteBookingRequest with _$CompleteBookingRequest {
  const factory CompleteBookingRequest({@MoneyConverter() required num actualPrice}) = _CompleteBookingRequest;

  factory CompleteBookingRequest.fromJson(Map<String, dynamic> json) => _$CompleteBookingRequestFromJson(json);
}
