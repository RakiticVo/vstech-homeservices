import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:vstech_home_services/core/error/result.dart';
import 'package:vstech_home_services/core/location/location_service.dart';
import 'package:vstech_home_services/core/session/session_cubit.dart';
import 'package:vstech_home_services/core/utils/logger.dart';
import 'package:vstech_home_services/features/tracking/domain/usecases/update_technician_location_use_case.dart';

part 'worker_presence_state.dart';

/// Worker Online/Offline switch. While Online the latest GPS fix is sent with
/// `PUT /technician/location` every [broadcastInterval] (~2 s, CLAUDE.md Realtime rules).
///
/// The API has no availability endpoint yet, so Online/Offline itself is client-side only.
/// A singleton so broadcasting survives navigation between worker screens; it goes Offline on
/// sign-out.
@lazySingleton
class WorkerPresenceCubit extends Cubit<WorkerPresenceState> {
  WorkerPresenceCubit(
    this._location,
    this._updateLocation,
    SessionCubit session, {
    @ignoreParam this.broadcastInterval = const Duration(seconds: 2),
  }) : super(const WorkerOfflineState()) {
    _sessionSubscription = session.stream.listen((state) {
      if (state is! SessionAuthenticatedState) unawaited(goOffline());
    });
  }

  final LocationService _location;
  final UpdateTechnicianLocationUseCase _updateLocation;
  final Duration broadcastInterval;

  late final StreamSubscription<SessionState> _sessionSubscription;
  StreamSubscription<GeoPoint>? _positionSubscription;
  Timer? _timer;
  GeoPoint? _latest;
  bool _sending = false;

  Future<void> goOnline() async {
    if (state is! WorkerOfflineState && state is! WorkerPresenceErrorState) return;
    emit(const WorkerGoingOnlineState());
    final (position, failure) = await _location.currentPosition();
    if (position == null) {
      emit(WorkerPresenceErrorState(failure ?? LocationFailure.unavailable));
      return;
    }
    _latest = position;
    _positionSubscription = _location.watchPosition().listen((point) => _latest = point);
    _timer = Timer.periodic(broadcastInterval, (_) => unawaited(_broadcast()));
    emit(const WorkerOnlineState());
    await _broadcast();
  }

  Future<void> goOffline() async {
    await _stopBroadcasting();
    if (!isClosed && state is! WorkerOfflineState) emit(const WorkerOfflineState());
  }

  Future<void> _stopBroadcasting() async {
    _timer?.cancel();
    _timer = null;
    await _positionSubscription?.cancel();
    _positionSubscription = null;
  }

  Future<void> toggle() => state is WorkerOnlineState ? goOffline() : goOnline();

  Future<void> _broadcast() async {
    final position = _latest;
    if (position == null || _sending || state is! WorkerOnlineState) return;
    _sending = true;
    final result = await _updateLocation(position);
    _sending = false;
    if (result is Err<void>) appLogger.w('Location broadcast failed: ${result.failure}');
    if (!isClosed && state is WorkerOnlineState) emit(WorkerOnlineState(lastSent: position));
  }

  @override
  Future<void> close() async {
    await _stopBroadcasting();
    await _sessionSubscription.cancel();
    await super.close();
  }
}
