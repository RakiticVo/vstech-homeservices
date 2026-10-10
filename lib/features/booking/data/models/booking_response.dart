import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:vstech_home_services/core/utils/json_converters.dart';

part 'booking_response.freezed.dart';
part 'booking_response.g.dart';

/// `BookingResponse` — element of `GET /api/v1/bookings` and result of `POST /api/v1/bookings`.
@freezed
abstract class BookingResponse with _$BookingResponse {
  const factory BookingResponse({
    @IdConverter() required String requestId,
    @NullableIdConverter() String? customerId,
    @NullableIdConverter() String? categoryId,
    @NullableIdConverter() String? assignedWorkerId,
    String? status,
    @NullableMoneyConverter() num? estimatedPrice,
    @NullableMoneyConverter() num? finalPrice,
    String? description,
    String? addressDetail,
    @NullableUtcDateTimeConverter() DateTime? scheduledTime,
    @NullableUtcDateTimeConverter() DateTime? createdAt,
    @NullableUtcDateTimeConverter() DateTime? updatedAt,
  }) = _BookingResponse;

  factory BookingResponse.fromJson(Map<String, dynamic> json) => _$BookingResponseFromJson(json);
}
