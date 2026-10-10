import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vstech_home_services/core/error/failure.dart';
import 'package:vstech_home_services/core/error/result.dart';
import 'package:vstech_home_services/core/network/network_exception.dart';
import 'package:vstech_home_services/features/booking/domain/entities/booking.dart';
import 'package:vstech_home_services/features/booking/domain/entities/booking_status.dart';
import 'package:vstech_home_services/features/booking/domain/entities/new_booking.dart';
import 'package:vstech_home_services/features/booking/domain/usecases/create_booking_use_case.dart';
import 'package:vstech_home_services/features/booking/domain/usecases/get_booking_use_case.dart';

import '../../../fixtures/booking/booking_fixtures.dart';
import '../../../helpers/mocks.dart';

NewBooking _newBooking(DateTime at) => NewBooking(
  categoryId: '1',
  description: 'x',
  addressDetail: 'y',
  lat: 10,
  lng: 106,
  scheduledTime: at,
);

void main() {
  late MockBookingRepository repository;

  setUpAll(() => registerFallbackValue(_newBooking(DateTime.utc(2030))));

  setUp(() => repository = MockBookingRepository());

  group('CreateBookingUseCase', () {
    final now = DateTime.utc(2026, 10, 10, 8);

    test('rejects a time that is not in the future with HS-400-0002', () async {
      final useCase = CreateBookingUseCase(repository, now: () => now);

      final result = await useCase(_newBooking(now));

      expect(result, isA<Err<Booking>>().having((r) => r.failure.errorCode, 'code', 'HS-400-0002'));
      verifyNever(() => repository.create(any()));
    });

    test('creates future bookings', () async {
      when(() => repository.create(any())).thenAnswer((_) async => Ok(pendingBooking));
      final useCase = CreateBookingUseCase(repository, now: () => now);

      final result = await useCase(_newBooking(now.add(const Duration(hours: 1))));

      expect(result, isA<Ok<Booking>>());
    });
  });

  group('GetBookingUseCase', () {
    test('returns the cached copy without calling the API', () async {
      when(() => repository.cached('501')).thenReturn(pendingBooking);

      final result = await GetBookingUseCase(repository)('501');

      expect((result as Ok<Booking>).value, pendingBooking);
      verifyNever(() => repository.getMyBookings(page: any(named: 'page')));
    });

    test('pages through the list until it finds the booking', () async {
      when(() => repository.cached(any())).thenReturn(null);
      when(() => repository.getMyBookings(page: 0)).thenAnswer((_) async => Ok(pageOf([pendingBooking], hasMore: true)));
      when(
        () => repository.getMyBookings(page: 1),
      ).thenAnswer((_) async => Ok(pageOf([completedBooking], page: 1)));

      final result = await GetBookingUseCase(repository)('503');

      expect((result as Ok<Booking>).value.status, BookingStatus.completed);
    });

    test('reports HS-404-0010 when the booking is not in any page', () async {
      when(() => repository.cached(any())).thenReturn(null);
      when(() => repository.getMyBookings(page: 0)).thenAnswer((_) async => Ok(pageOf([pendingBooking])));

      final result = await GetBookingUseCase(repository)('missing');

      expect(result, isA<Err<Booking>>().having((r) => r.failure.errorCode, 'code', 'HS-404-0010'));
    });

    test('propagates list errors', () async {
      when(() => repository.cached(any())).thenReturn(null);
      when(
        () => repository.getMyBookings(page: 0),
      ).thenAnswer((_) async => const Err(Failure(kind: NetworkErrorKind.noConnection)));

      final result = await GetBookingUseCase(repository)('501', refresh: true);

      expect(result, isA<Err<Booking>>().having((r) => r.failure.kind, 'kind', NetworkErrorKind.noConnection));
    });
  });

  test('BookingStatus maps API values and allowed actions', () {
    expect(BookingStatus.fromApi('IN_PROGRESS'), BookingStatus.inProgress);
    expect(BookingStatus.fromApi('DISPATCH_FAILED'), BookingStatus.dispatchFailed);
    expect(BookingStatus.fromApi('???'), BookingStatus.unknown);
    expect(BookingStatus.accepted.canCancel, isTrue);
    expect(BookingStatus.inProgress.canCancel, isFalse);
    expect(BookingStatus.completed.canDispute, isTrue);
    expect(BookingStatus.pending.canDispute, isFalse);
  });
}
