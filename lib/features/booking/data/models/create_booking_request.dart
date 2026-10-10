import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:vstech_home_services/core/utils/json_converters.dart';

part 'create_booking_request.freezed.dart';
part 'create_booking_request.g.dart';

/// Body of `POST /api/v1/bookings`. `scheduledTime` is sent in UTC and must be in the future
/// (`HS-400-0002`); coordinates must be valid (`HS-400-0003`).
@freezed
abstract class CreateBookingRequest with _$CreateBookingRequest {
  // Freezed forwards this to the generated class — the documented way to set json options.
  // ignore: invalid_annotation_target
  @JsonSerializable(includeIfNull: false)
  const factory CreateBookingRequest({
    @IdConverter() required String categoryId,
    required String description,
    required String addressDetail,
    required double locationLat,
    required double locationLng,
    @UtcDateTimeConverter() required DateTime scheduledTime,
    @NullableIdConverter() String? applianceId,
    String? deviceIp,
  }) = _CreateBookingRequest;

  factory CreateBookingRequest.fromJson(Map<String, dynamic> json) => _$CreateBookingRequestFromJson(json);
}
