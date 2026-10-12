import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vstech_home_services/core/error/failure.dart';
import 'package:vstech_home_services/core/error/result.dart';
import 'package:vstech_home_services/core/network/network_exception.dart';
import 'package:vstech_home_services/features/booking/domain/entities/booking.dart';
import 'package:vstech_home_services/features/booking/domain/entities/booking_status.dart';
import 'package:vstech_home_services/features/booking/domain/entities/quote_line.dart';
import 'package:vstech_home_services/features/home/domain/entities/service_category.dart';
import 'package:vstech_home_services/features/worker_task/presentation/bloc/worker_task_cubit.dart';

import '../../../fixtures/booking/booking_fixtures.dart';
import '../../../helpers/mocks.dart';

const _offline = Failure(kind: NetworkErrorKind.noConnection);
const _quote = SubmittedQuote(
  bookingId: '501',
  status: QuoteStatus.pending,
  lines: [QuoteLine(itemName: 'Gas', amount: 45000)],
  totalAmount: 45000,
);
const _declined = SubmittedQuote(
  bookingId: '501',
  status: QuoteStatus.rejected,
  lines: [QuoteLine(itemName: 'Gas', amount: 45000)],
  totalAmount: 45000,
);

void main() {
  late MockGetBookingUseCase getBooking;
  late MockGetCategoryUseCase getCategory;
  late MockAcceptBookingUseCase accept;
  late MockStartBookingUseCase start;
  late MockGetSubmittedQuoteUseCase getQuote;
  late MockCompleteBookingUseCase complete;

  WorkerTaskCubit build() => WorkerTaskCubit(
    getBooking,
    getCategory,
    accept,
    start,
    getQuote,
    complete,
  );

  setUp(() {
    getBooking = MockGetBookingUseCase();
    getCategory = MockGetCategoryUseCase();
    accept = MockAcceptBookingUseCase();
    start = MockStartBookingUseCase();
    getQuote = MockGetSubmittedQuoteUseCase();
    when(() => getQuote(any())).thenReturn(null);
    complete = MockCompleteBookingUseCase();
  });

  final pendingData = WorkerTaskData(booking: pendingBooking);

  blocTest<WorkerTaskCubit, WorkerTaskState>(
    'load emits the job with its service name',
    setUp: () {
      when(() => getBooking('501'))
          .thenAnswer((_) async => Ok<Booking>(pendingBooking));
      when(() => getCategory('1'))
          .thenAnswer((_) async => const Ok<ServiceCategory>(acCategory));
    },
    build: build,
    act: (cubit) => cubit.load('501'),
    expect: () => [
      const WorkerTaskLoadingState(),
      WorkerTaskReadyState(
        WorkerTaskData(booking: pendingBooking, serviceName: 'Sửa máy lạnh'),
      ),
    ],
  );

  blocTest<WorkerTaskCubit, WorkerTaskState>(
    'load failure is emitted',
    setUp: () =>
        when(() => getBooking('501'))
            .thenAnswer((_) async => const Err<Booking>(_offline)),
    build: build,
    act: (cubit) => cubit.load('501'),
    expect: () => [
      const WorkerTaskLoadingState(),
      const WorkerTaskLoadErrorState(_offline),
    ],
  );

  blocTest<WorkerTaskCubit, WorkerTaskState>(
    'accept updates the booking status',
    setUp: () =>
        when(() => accept('501'))
            .thenAnswer((_) async => const Ok(BookingStatus.accepted)),
    build: build,
    seed: () => WorkerTaskReadyState(pendingData),
    act: (cubit) => cubit.accept(),
    expect: () => [
      WorkerTaskBusyState(pendingData, WorkerTaskAction.accept),
      WorkerTaskActionDoneState(
        WorkerTaskData(
          booking: pendingBooking.copyWith(status: BookingStatus.accepted),
        ),
        WorkerTaskAction.accept,
      ),
    ],
  );

  blocTest<WorkerTaskCubit, WorkerTaskState>(
    'start failure keeps the job and reports the error',
    setUp: () =>
        when(() => start('501'))
            .thenAnswer((_) async => const Err<BookingStatus>(_offline)),
    build: build,
    seed: () => WorkerTaskReadyState(pendingData),
    act: (cubit) => cubit.start(),
    expect: () => [
      WorkerTaskBusyState(pendingData, WorkerTaskAction.start),
      WorkerTaskActionFailedState(
        pendingData,
        WorkerTaskAction.start,
        _offline,
      ),
    ],
  );

  blocTest<WorkerTaskCubit, WorkerTaskState>(
    'load picks up the last quote sent for the job',
    setUp: () {
      when(() => getBooking('501'))
          .thenAnswer((_) async => Ok<Booking>(pendingBooking));
      when(() => getCategory('1'))
          .thenAnswer((_) async => const Ok<ServiceCategory>(acCategory));
      when(() => getQuote('501')).thenReturn(_quote);
    },
    build: build,
    act: (cubit) => cubit.load('501'),
    skip: 1,
    expect: () => [
      WorkerTaskReadyState(
        WorkerTaskData(
          booking: pendingBooking,
          serviceName: 'Sửa máy lạnh',
          quote: _quote,
        ),
      ),
    ],
    verify: (cubit) => expect(cubit.state.data?.suggestedFinalPrice, 545000),
  );

  blocTest<WorkerTaskCubit, WorkerTaskState>(
    'refreshQuote re-reads the cached quote; a declined quote no longer counts toward the price',
    setUp: () => when(() => getQuote('501')).thenReturn(_declined),
    build: build,
    seed: () => WorkerTaskReadyState(pendingData),
    act: (cubit) => cubit.refreshQuote(),
    expect: () => [
      WorkerTaskReadyState(
        WorkerTaskData(booking: pendingBooking, quote: _declined),
      ),
    ],
    verify: (cubit) => expect(cubit.state.data?.suggestedFinalPrice, 500000),
  );

  blocTest<WorkerTaskCubit, WorkerTaskState>(
    'complete sends the price with the estimate and stores it as final price',
    setUp: () =>
        when(() => complete('501', actualPrice: 545000, estimatedPrice: 500000))
            .thenAnswer((_) async => const Ok(BookingStatus.completed)),
    build: build,
    seed: () => WorkerTaskReadyState(pendingData),
    act: (cubit) => cubit.complete(545000),
    expect: () => [
      WorkerTaskBusyState(pendingData, WorkerTaskAction.complete),
      WorkerTaskActionDoneState(
        WorkerTaskData(
          booking: pendingBooking.copyWith(
            status: BookingStatus.completed,
            finalPrice: 545000,
          ),
        ),
        WorkerTaskAction.complete,
      ),
    ],
  );

  blocTest<WorkerTaskCubit, WorkerTaskState>(
    'ignores actions while busy',
    build: build,
    seed: () => WorkerTaskBusyState(pendingData, WorkerTaskAction.accept),
    act: (cubit) => cubit.start(),
    expect: () => <WorkerTaskState>[],
  );
}
