import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:vstech_home_services/core/error/failure.dart';
import 'package:vstech_home_services/core/error/result.dart';
import 'package:vstech_home_services/features/booking/domain/entities/booking.dart';
import 'package:vstech_home_services/features/booking/domain/entities/booking_status.dart';
import 'package:vstech_home_services/features/booking/domain/entities/quote_line.dart';
import 'package:vstech_home_services/features/booking/domain/usecases/get_booking_use_case.dart';
import 'package:vstech_home_services/features/booking/domain/usecases/worker_booking_use_cases.dart';
import 'package:vstech_home_services/features/home/domain/usecases/get_category_use_case.dart';

part 'worker_task_state.dart';

/// One job on the worker side: load it, then accept → start → complete. The extra-cost quote is
/// sent from its own screen (`QuoteFormCubit`); this cubit only shows the last one ([refreshQuote]).
/// Provided per screen (job detail, arrived, executing); the booking repository cache keeps the
/// status in sync between them.
@injectable
class WorkerTaskCubit extends Cubit<WorkerTaskState> {
  WorkerTaskCubit(
    this._getBooking,
    this._getCategory,
    this._accept,
    this._start,
    this._getQuote,
    this._complete,
  ) : super(const WorkerTaskLoadingState());

  final GetBookingUseCase _getBooking;
  final GetCategoryUseCase _getCategory;
  final AcceptBookingUseCase _accept;
  final StartBookingUseCase _start;
  final GetSubmittedQuoteUseCase _getQuote;
  final CompleteBookingUseCase _complete;

  Future<void> load(String bookingId) async {
    emit(const WorkerTaskLoadingState());
    switch (await _getBooking(bookingId)) {
      case Err(:final failure):
        emit(WorkerTaskLoadErrorState(failure));
      case Ok(value: final booking):
        final categoryId = booking.categoryId;
        final name = categoryId == null
            ? null
            : switch (await _getCategory(categoryId)) {
                Ok(:final value) => value.name,
                Err() => null,
              };
        emit(
          WorkerTaskReadyState(
            WorkerTaskData(
              booking: booking,
              serviceName: name,
              quote: _getQuote(booking.id),
            ),
          ),
        );
    }
  }

  Future<void> accept() => _transition(WorkerTaskAction.accept, _accept.call);

  Future<void> start() => _transition(WorkerTaskAction.start, _start.call);

  /// Re-reads the last quote sent for this job (after returning from the quote screen).
  void refreshQuote() {
    final current = state;
    if (current is! WorkerTaskWithDataState || current is WorkerTaskBusyState) {
      return;
    }
    final quote = _getQuote(current.task.booking.id);
    if (quote == current.task.quote) return;
    emit(WorkerTaskReadyState(current.task.copyWith(quote: quote)));
  }

  Future<void> complete(num actualPrice) => _transition(
    WorkerTaskAction.complete,
    (id) => _complete(
      id,
      actualPrice: actualPrice,
      estimatedPrice: state.data?.booking.estimatedPrice,
    ),
    finalPrice: actualPrice,
  );

  WorkerTaskData? get _readyData =>
      state is WorkerTaskBusyState ? null : state.data;

  Future<void> _transition(
    WorkerTaskAction action,
    Future<Result<BookingStatus>> Function(String bookingId) call, {
    num? finalPrice,
  }) async {
    final data = _readyData;
    if (data == null) return;
    emit(WorkerTaskBusyState(data, action));
    switch (await call(data.booking.id)) {
      case Ok(value: final status):
        final booking = data.booking.copyWith(
          status: status,
          finalPrice: finalPrice ?? data.booking.finalPrice,
        );
        emit(
          WorkerTaskActionDoneState(data.copyWith(booking: booking), action),
        );
      case Err(:final failure):
        emit(WorkerTaskActionFailedState(data, action, failure));
    }
  }
}
