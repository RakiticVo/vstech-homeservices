import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:vstech_home_services/core/error/failure.dart';
import 'package:vstech_home_services/core/error/result.dart';
import 'package:vstech_home_services/features/auth/domain/usecases/get_profile_use_case.dart';
import 'package:vstech_home_services/features/booking/domain/entities/booking.dart';
import 'package:vstech_home_services/features/booking/domain/entities/booking_status.dart';
import 'package:vstech_home_services/features/booking/domain/usecases/get_booking_use_case.dart';
import 'package:vstech_home_services/features/tracking/domain/entities/worker_position.dart';
import 'package:vstech_home_services/features/tracking/domain/repositories/tracking_connection.dart';

part 'customer_tracking_state.dart';

/// Customer's live view of one booking: the stage comes from the booking status (the API has no
/// "arrived" status), and while the job is ACCEPTED / IN_PROGRESS the worker's position streams in
/// over `/ws/tracking/customer`. `TRACKING_ENDED` reloads the booking; `ERROR` stops tracking. The
/// socket lives and dies with this cubit.
@injectable
class CustomerTrackingCubit extends Cubit<CustomerTrackingState> {
  CustomerTrackingCubit(this._getBooking, this._getProfile, this._connection)
    : super(const CustomerTrackingLoadingState());

  final GetBookingUseCase _getBooking;
  final GetProfileUseCase _getProfile;
  final TrackingConnection _connection;

  StreamSubscription<TrackingEvent>? _events;
  StreamSubscription<TrackingConnectionStatus>? _status;
  String? _bookingId;
  bool _listening = false;

  Future<void> load(String bookingId) async {
    _bookingId = bookingId;
    if (state is! CustomerTrackingLoadedState) {
      emit(const CustomerTrackingLoadingState());
    }
    final (booking, profile) = await (
      _getBooking(bookingId, refresh: true),
      _getProfile(),
    ).wait;
    if (isClosed) return;
    switch (booking) {
      case Err(:final failure):
        emit(CustomerTrackingErrorState(failure));
      case Ok(value: final b):
        final previous = state;
        final home = switch (profile) {
          Ok(value: final p) when p.lat != null && p.lng != null => (
            p.lat!,
            p.lng!,
          ),
          _ => null,
        };
        final trackable = TrackingStage.of(b.status).isTrackable;
        emit(
          CustomerTrackingLoadedState(
            booking: b,
            home: home,
            position: previous is CustomerTrackingLoadedState
                ? previous.position
                : null,
            connection: trackable
                ? TrackingConnectionStatus.connecting
                : TrackingConnectionStatus.offline,
          ),
        );
        if (trackable) {
          await _listen(bookingId);
        } else {
          await _stop();
        }
    }
  }

  /// Opens the socket again after it gave up or the server rejected the subscription.
  Future<void> reconnect() async {
    final current = state;
    final bookingId = _bookingId;
    if (current is! CustomerTrackingLoadedState ||
        bookingId == null ||
        !current.stage.isTrackable) {
      return;
    }
    await _stop();
    emit(
      current.copyWith(
        connection: TrackingConnectionStatus.connecting,
        clearErrorCode: true,
      ),
    );
    await _listen(bookingId);
  }

  Future<void> _listen(String bookingId) async {
    if (_listening) return;
    _listening = true;
    _events = _connection.events.listen(_onEvent);
    _status = _connection.status.listen((status) {
      final current = state;
      if (current is CustomerTrackingLoadedState && !isClosed) {
        emit(current.copyWith(connection: status));
      }
    });
    await _connection.connect(bookingId);
  }

  void _onEvent(TrackingEvent event) {
    final current = state;
    if (current is! CustomerTrackingLoadedState) return;
    switch (event) {
      case TrackingPositionEvent(:final position):
        if (position != null) emit(current.copyWith(position: position));
      case TrackingEndedEvent():
        // The job moved on (e.g. COMPLETED): stop and re-read the booking for the new stage.
        unawaited(
          _stop().then(
            (_) => _bookingId == null || isClosed ? null : load(_bookingId!),
          ),
        );
      case TrackingErrorEvent(:final errorCode):
        unawaited(_stop());
        emit(
          current.copyWith(
            connection: TrackingConnectionStatus.offline,
            errorCode: errorCode ?? '',
          ),
        );
    }
  }

  Future<void> _stop() async {
    if (!_listening) return;
    _listening = false;
    await _events?.cancel();
    await _status?.cancel();
    _events = null;
    _status = null;
    await _connection.disconnect();
  }

  @override
  Future<void> close() async {
    await _stop();
    await _connection.close();
    return await super.close();
  }
}
