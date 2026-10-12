import 'package:injectable/injectable.dart';
import 'package:vstech_home_services/core/error/failure.dart';
import 'package:vstech_home_services/core/error/result.dart';
import 'package:vstech_home_services/core/network/network_exception.dart';
import 'package:vstech_home_services/features/auth/domain/usecases/get_profile_use_case.dart';
import 'package:vstech_home_services/features/booking/domain/usecases/get_booking_use_case.dart';
import 'package:vstech_home_services/features/messaging/domain/entities/voip_call.dart';
import 'package:vstech_home_services/features/messaging/domain/repositories/voip_repository.dart';

/// Logs the start of a call on a booking: the caller is the signed-in user, the receiver is the
/// assigned worker (customer calling) or the booking's customer (worker calling).
@injectable
class StartBookingCallUseCase {
  const StartBookingCallUseCase(
    this._repository,
    this._getProfile,
    this._getBooking,
  );

  final VoipRepository _repository;
  final GetProfileUseCase _getProfile;
  final GetBookingUseCase _getBooking;

  static const Failure _noPeer = Failure(
    kind: NetworkErrorKind.unknown,
    errorCode: AppException.callPeerMissing,
  );

  Future<Result<VoipCall>> call(
    String bookingId, {
    required bool isWorker,
  }) async {
    final (profile, booking) = await (
      _getProfile(),
      _getBooking(bookingId),
    ).wait;
    switch ((profile, booking)) {
      case (Ok(value: final me), Ok(value: final b)):
        final receiver = isWorker ? b.customerId : b.assignedWorkerId;
        if (receiver == null || receiver.isEmpty) return const Err(_noPeer);
        return await _repository.startCall(
          bookingId: bookingId,
          callerId: me.id,
          receiverId: receiver,
        );
      case (Err(:final failure), _) || (_, Err(:final failure)):
        return Err(failure);
    }
  }
}

@injectable
class EndCallUseCase {
  const EndCallUseCase(this._repository);

  final VoipRepository _repository;

  Future<Result<VoipCall>> call(
    String callId, {
    required int durationSeconds,
  }) => _repository.endCall(
    callId: callId,
    durationSeconds: durationSeconds < 0 ? 0 : durationSeconds,
  );
}

@injectable
class GetCallHistoryUseCase {
  const GetCallHistoryUseCase(this._repository);

  final VoipRepository _repository;

  Future<Result<List<VoipCall>>> call(String bookingId) =>
      _repository.getCalls(bookingId: bookingId);
}
