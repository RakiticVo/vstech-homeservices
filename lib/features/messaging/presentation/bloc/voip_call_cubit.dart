import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:vstech_home_services/core/error/failure.dart';
import 'package:vstech_home_services/core/error/result.dart';
import 'package:vstech_home_services/core/utils/logger.dart';
import 'package:vstech_home_services/features/messaging/domain/entities/voip_call.dart';
import 'package:vstech_home_services/features/messaging/domain/usecases/voip_use_cases.dart';

part 'voip_call_state.dart';

/// Outgoing call on a booking. The API only keeps a call log, so this logs the start
/// (`POST /voip/calls`), counts talk time locally and logs the end with the duration
/// (`POST /voip/calls/end`). There is no audio transport yet — see NOTES L27.
@injectable
class VoipCallCubit extends Cubit<VoipCallState> {
  VoipCallCubit(this._startCall, this._endCall)
    : super(const VoipCallStartingState());

  final StartBookingCallUseCase _startCall;
  final EndCallUseCase _endCall;

  Timer? _timer;

  Future<void> start(String bookingId, {required bool isWorker}) async {
    emit(const VoipCallStartingState());
    switch (await _startCall(bookingId, isWorker: isWorker)) {
      case Ok(:final value):
        if (isClosed) return;
        emit(VoipCallActiveState(call: value));
        _timer = Timer.periodic(const Duration(seconds: 1), (_) => tick());
      case Err(:final failure):
        if (!isClosed) emit(VoipCallErrorState(failure));
    }
  }

  /// Adds one second of talk time.
  @visibleForTesting
  void tick() {
    final current = state;
    if (current is VoipCallActiveState) {
      emit(current.copyWith(elapsedSeconds: current.elapsedSeconds + 1));
    }
  }

  void toggleMute() {
    final current = state;
    if (current is VoipCallActiveState) {
      emit(current.copyWith(isMuted: !current.isMuted));
    }
  }

  void toggleSpeaker() {
    final current = state;
    if (current is VoipCallActiveState) {
      emit(current.copyWith(isSpeaker: !current.isSpeaker));
    }
  }

  /// Hangs up and logs the duration. The call ends on screen even if the log fails.
  Future<void> hangUp() async {
    _timer?.cancel();
    final current = state;
    if (current is! VoipCallActiveState) {
      emit(const VoipCallEndedState(durationSeconds: 0));
      return;
    }
    emit(VoipCallEndedState(durationSeconds: current.elapsedSeconds));
    await _logEnd(current);
  }

  Future<void> _logEnd(VoipCallActiveState active) async {
    if (await _endCall(active.call.id, durationSeconds: active.elapsedSeconds)
        case Err(:final failure)) {
      appLogger.w(
        'VoIP end log failed for call ${active.call.id}: ${failure.errorCode ?? failure.kind}',
      );
    }
  }

  @override
  Future<void> close() async {
    _timer?.cancel();
    final current = state;
    if (current is VoipCallActiveState) await _logEnd(current);
    return await super.close();
  }
}
