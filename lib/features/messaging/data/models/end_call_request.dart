import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:vstech_home_services/core/utils/json_converters.dart';

part 'end_call_request.freezed.dart';
part 'end_call_request.g.dart';

/// Body of `POST /api/v1/voip/calls/end`. `recordingUrl` is required by the OpenAPI spec but
/// optional in the doc (C14); the app records nothing yet, so it is omitted.
@freezed
abstract class EndCallRequest with _$EndCallRequest {
  // Freezed forwards this to the generated class — the documented way to set json options.
  // ignore: invalid_annotation_target
  @JsonSerializable(includeIfNull: false)
  const factory EndCallRequest({
    @IdConverter() required String callId,
    required int durationSeconds,
    String? recordingUrl,
  }) = _EndCallRequest;

  factory EndCallRequest.fromJson(Map<String, dynamic> json) =>
      _$EndCallRequestFromJson(json);
}
