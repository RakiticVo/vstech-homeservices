import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:vstech_home_services/core/error/failure.dart';
import 'package:vstech_home_services/core/error/result.dart';
import 'package:vstech_home_services/features/booking/domain/entities/booking_status.dart';
import 'package:vstech_home_services/features/booking/domain/usecases/change_booking_status_use_case.dart';

part 'booking_action_state.dart';

/// Customer cancel / dispute of one booking (`POST /bookings/{id}/cancel|dispute`, idempotent).
@injectable
class BookingActionCubit extends Cubit<BookingActionState> {
  BookingActionCubit(this._cancel, this._dispute) : super(const BookingActionIdleState());

  final CancelBookingUseCase _cancel;
  final DisputeBookingUseCase _dispute;

  Future<void> cancel(String bookingId) => _run(() => _cancel(bookingId));

  Future<void> dispute(String bookingId) => _run(() => _dispute(bookingId));

  Future<void> _run(Future<Result<BookingStatus>> Function() action) async {
    if (state is BookingActionInProgressState) return;
    emit(const BookingActionInProgressState());
    switch (await action()) {
      case Ok(:final value):
        emit(BookingActionDoneState(value));
      case Err(:final failure):
        emit(BookingActionFailedState(failure));
    }
  }
}
