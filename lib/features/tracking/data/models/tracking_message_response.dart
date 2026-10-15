import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:vstech_home_services/core/utils/json_converters.dart';

part 'tracking_message_response.freezed.dart';
part 'tracking_message_response.g.dart';

/// Server → customer frame on `/ws/tracking/customer` (`TrackingMessage`, doc `09` §2.3):
/// `type` is CONNECTED | LOCATION_UPDATE | TRACKING_ENDED | ERROR. A transport-level error envelope
/// (`{"status":"error",...}`) has no `type` but carries `errorCode`.
@freezed
abstract class TrackingMessageResponse with _$TrackingMessageResponse {
  const factory TrackingMessageResponse({
    String? type,
    String? status,
    @NullableIdConverter() String? technicianId,
    @NullableIdConverter() String? bookingId,
    double? latitude,
    double? longitude,
    double? heading,
    @NullableUtcDateTimeConverter() DateTime? lastUpdated,
    String? reason,
    String? message,
    String? errorCode,
  }) = _TrackingMessageResponse;

  factory TrackingMessageResponse.fromJson(Map<String, dynamic> json) =>
      _$TrackingMessageResponseFromJson(json);
}
