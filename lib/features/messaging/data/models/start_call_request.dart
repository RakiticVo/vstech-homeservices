import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:vstech_home_services/core/utils/json_converters.dart';

part 'start_call_request.freezed.dart';
part 'start_call_request.g.dart';

/// Body of `POST /api/v1/voip/calls` — all fields required.
@freezed
abstract class StartCallRequest with _$StartCallRequest {
  const factory StartCallRequest({
    @IdConverter() required String bookingId,
    @IdConverter() required String callerId,
    @IdConverter() required String receiverId,
  }) = _StartCallRequest;

  factory StartCallRequest.fromJson(Map<String, dynamic> json) =>
      _$StartCallRequestFromJson(json);
}
