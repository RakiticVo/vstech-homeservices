import 'package:vstech_home_services/core/error/result.dart';
import 'package:vstech_home_services/features/messaging/domain/entities/voip_call.dart';

abstract interface class VoipRepository {
  Future<Result<VoipCall>> startCall({
    required String bookingId,
    required String callerId,
    required String receiverId,
  });

  Future<Result<VoipCall>> endCall({
    required String callId,
    required int durationSeconds,
  });

  Future<Result<List<VoipCall>>> getCalls({required String bookingId});
}
