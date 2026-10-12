import 'package:freezed_annotation/freezed_annotation.dart';

part 'voip_call.freezed.dart';

/// One call-log entry of a booking. Times are UTC.
@freezed
abstract class VoipCall with _$VoipCall {
  const factory VoipCall({
    required String id,
    String? bookingId,
    String? callerId,
    String? receiverId,
    int? durationSeconds,
    DateTime? startedAt,
    DateTime? endedAt,
  }) = _VoipCall;

  const VoipCall._();

  /// Ended without talk time — shown as a missed call.
  bool get isMissed => endedAt != null && (durationSeconds ?? 0) == 0;
}
