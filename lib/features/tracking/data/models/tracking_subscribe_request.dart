import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:vstech_home_services/core/utils/json_converters.dart';

part 'tracking_subscribe_request.freezed.dart';
part 'tracking_subscribe_request.g.dart';

/// Customer → server frame on `/ws/tracking/customer`: `{"action":"SUBSCRIBE","bookingId":101}`
/// (`bookingId` is a number on the socket).
@freezed
abstract class TrackingSubscribeRequest with _$TrackingSubscribeRequest {
  const factory TrackingSubscribeRequest({
    @IdConverter() required String bookingId,
    @Default('SUBSCRIBE') String action,
  }) = _TrackingSubscribeRequest;

  factory TrackingSubscribeRequest.fromJson(Map<String, dynamic> json) =>
      _$TrackingSubscribeRequestFromJson(json);
}
