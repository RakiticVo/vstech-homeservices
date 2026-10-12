import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:vstech_home_services/core/utils/json_converters.dart';

part 'voip_call_response.freezed.dart';
part 'voip_call_response.g.dart';

/// A call-log entry (`VoipCallResponse`). `status` is only in the doc (`INITIATED`, `COMPLETED`…).
@freezed
abstract class VoipCallResponse with _$VoipCallResponse {
  const factory VoipCallResponse({
    @IdConverter() required String id,
    @NullableIdConverter() String? bookingId,
    @NullableIdConverter() String? callerId,
    @NullableIdConverter() String? receiverId,
    String? status,
    int? durationSeconds,
    String? recordingUrl,
    @NullableUtcDateTimeConverter() DateTime? startedAt,
    @NullableUtcDateTimeConverter() DateTime? endedAt,
  }) = _VoipCallResponse;

  factory VoipCallResponse.fromJson(Map<String, dynamic> json) =>
      _$VoipCallResponseFromJson(json);
}
