import 'package:injectable/injectable.dart';
import 'package:vstech_home_services/core/error/result.dart';
import 'package:vstech_home_services/features/messaging/data/datasources/voip_remote_data_source.dart';
import 'package:vstech_home_services/features/messaging/data/models/end_call_request.dart';
import 'package:vstech_home_services/features/messaging/data/models/start_call_request.dart';
import 'package:vstech_home_services/features/messaging/data/models/voip_call_response.dart';
import 'package:vstech_home_services/features/messaging/domain/entities/voip_call.dart';
import 'package:vstech_home_services/features/messaging/domain/repositories/voip_repository.dart';

@LazySingleton(as: VoipRepository)
class VoipRepositoryImpl implements VoipRepository {
  VoipRepositoryImpl(this._remote);

  final VoipRemoteDataSource _remote;

  @override
  Future<Result<VoipCall>> startCall({
    required String bookingId,
    required String callerId,
    required String receiverId,
  }) => Result.guard(
    () async => _toCall(
      await _remote.startCall(
        StartCallRequest(
          bookingId: bookingId,
          callerId: callerId,
          receiverId: receiverId,
        ),
      ),
    ),
  );

  @override
  Future<Result<VoipCall>> endCall({
    required String callId,
    required int durationSeconds,
  }) => Result.guard(
    () async => _toCall(
      await _remote.endCall(
        EndCallRequest(callId: callId, durationSeconds: durationSeconds),
      ),
    ),
  );

  @override
  Future<Result<List<VoipCall>>> getCalls({required String bookingId}) =>
      Result.guard(
        () async => [
          for (final call in await _remote.getCalls(bookingId: bookingId))
            _toCall(call),
        ],
      );

  static VoipCall _toCall(VoipCallResponse r) => VoipCall(
    id: r.id,
    bookingId: r.bookingId,
    callerId: r.callerId,
    receiverId: r.receiverId,
    durationSeconds: r.durationSeconds,
    startedAt: r.startedAt,
    endedAt: r.endedAt,
  );
}
