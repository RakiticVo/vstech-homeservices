import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vstech_home_services/core/error/result.dart';
import 'package:vstech_home_services/core/network/api_endpoints.dart';
import 'package:vstech_home_services/core/network/api_response.dart';
import 'package:vstech_home_services/core/network/network_exception.dart';
import 'package:vstech_home_services/features/booking/data/datasources/booking_remote_data_source.dart';
import 'package:vstech_home_services/features/booking/data/models/booking_response.dart';
import 'package:vstech_home_services/features/booking/data/models/create_booking_request.dart';
import 'package:vstech_home_services/features/booking/data/models/estimate_request.dart';
import 'package:vstech_home_services/features/booking/data/models/estimate_response.dart';
import 'package:vstech_home_services/features/booking/data/models/status_transition_response.dart';
import 'package:vstech_home_services/features/booking/data/repositories/booking_repository_impl.dart';
import 'package:vstech_home_services/features/booking/domain/entities/booking.dart';
import 'package:vstech_home_services/features/booking/domain/entities/booking_page.dart';
import 'package:vstech_home_services/features/booking/domain/entities/booking_status.dart';
import 'package:vstech_home_services/features/booking/domain/entities/new_booking.dart';
import 'package:vstech_home_services/features/booking/domain/entities/price_estimate.dart';

import '../../../fixtures/fixture_reader.dart';
import '../../../helpers/mocks.dart';

final CreateBookingRequest _request = CreateBookingRequest(
  categoryId: '1',
  description: 'Máy lạnh không mát',
  addressDetail: '123 ABC',
  locationLat: 10.76,
  locationLng: 106.66,
  scheduledTime: DateTime.utc(2030, 1, 2, 7),
);

const Map<String, Object> _bookingJson = {'requestId': 501, 'status': 'PENDING', 'categoryId': 1, 'estimatedPrice': '500000'};

void main() {
  group('BookingRemoteDataSource', () {
    late MockApiClient client;
    late BookingRemoteDataSource dataSource;

    setUp(() {
      client = MockApiClient();
      dataSource = BookingRemoteDataSource(client);
    });

    void stubCreate(Object? raw) => when(
      () => client.sendUnwrapped(
        ApiEndpoints.bookings,
        method: 'POST',
        body: any(named: 'body'),
        idempotent: true,
      ),
    ).thenAnswer((_) async => raw);

    test('createBooking sends the contract fields, UTC time and an idempotency key', () async {
      stubCreate(_bookingJson);

      await dataSource.createBooking(_request);

      verify(
        () => client.sendUnwrapped(
          ApiEndpoints.bookings,
          method: 'POST',
          body: {
            'categoryId': 1,
            'description': 'Máy lạnh không mát',
            'addressDetail': '123 ABC',
            'locationLat': 10.76,
            'locationLng': 106.66,
            'scheduledTime': '2030-01-02T07:00:00.000Z',
          },
          idempotent: true,
        ),
      ).called(1);
    });

    test('createBooking accepts a bare BookingResponse (OpenAPI)', () async {
      stubCreate(_bookingJson);

      final booking = await dataSource.createBooking(_request);

      expect(booking.requestId, '501');
      expect(booking.estimatedPrice, 500000);
    });

    test('createBooking accepts an ApiResponse envelope (module doc)', () async {
      stubCreate({'status': 201, 'message': 'Created', 'data': _bookingJson, 'errorCode': null});

      final booking = await dataSource.createBooking(_request);

      expect(booking.requestId, '501');
    });

    test('createBooking surfaces an error envelope', () async {
      stubCreate({'status': 400, 'message': 'x', 'data': null, 'errorCode': 'HS-400-0002'});

      await expectLater(
        dataSource.createBooking(_request),
        throwsA(isA<NetworkException>().having((e) => e.errorCode, 'code', 'HS-400-0002')),
      );
    });

    test('getBookings omits status when not filtering and decodes the page', () async {
      when(
        () => client.get<PagedResponse<BookingResponse>>(
          ApiEndpoints.bookings,
          query: any(named: 'query'),
          decode: any(named: 'decode'),
        ),
      ).thenAnswer((invocation) async {
        final decode = invocation.namedArguments[#decode] as PagedResponse<BookingResponse> Function(Object?);
        return ApiResponse(
          status: 200,
          message: '',
          data: decode(jsonFixture('booking/bookings_page.json')['data']),
          errorCode: null,
          timestamp: null,
        );
      });

      final page = await dataSource.getBookings(page: 0, size: 20);

      expect(page.content.map((b) => b.requestId), ['501', 'b-uuid-2']);
      expect(page.content.last.finalPrice, 320000);
      expect(page.content.first.scheduledTime, DateTime.utc(2026, 10, 11, 7));
      verify(
        () => client.get<PagedResponse<BookingResponse>>(
          ApiEndpoints.bookings,
          query: {'page': 0, 'size': 20},
          decode: any(named: 'decode'),
        ),
      ).called(1);
    });

    test('cancel is an idempotent POST without a body', () async {
      when(
        () => client.post<StatusTransitionResponse>(
          ApiEndpoints.bookingCancel('501'),
          idempotent: true,
          decode: any(named: 'decode'),
        ),
      ).thenAnswer(
        (_) async => const ApiResponse(
          status: 200,
          message: '',
          data: StatusTransitionResponse(newStatus: 'CANCELLED'),
          errorCode: null,
          timestamp: null,
        ),
      );

      final response = await dataSource.cancel('501');

      expect(response.newStatus, 'CANCELLED');
    });
  });

  group('BookingRepositoryImpl', () {
    late MockBookingRemoteDataSource remote;
    late BookingRepositoryImpl repository;

    setUpAll(() {
      registerFallbackValue(const EstimateRequest(categoryId: '', description: ''));
      registerFallbackValue(_request);
    });

    setUp(() {
      remote = MockBookingRemoteDataSource();
      repository = BookingRepositoryImpl(remote);
    });

    test('estimate falls back to price + commission when the total is missing', () async {
      when(() => remote.estimate(any())).thenAnswer(
        (_) async => const EstimateResponse(estimatedPrice: 500000, commissionFee: 50000),
      );

      final result = await repository.estimate(categoryId: '1', description: 'x');

      expect((result as Ok<PriceEstimate>).value.totalEstimated, 550000);
    });

    test('create sends UTC time and caches the new booking', () async {
      when(() => remote.createBooking(any())).thenAnswer((_) async => BookingResponse.fromJson(_bookingJson));

      final result = await repository.create(
        NewBooking(
          categoryId: '1',
          description: 'Máy lạnh không mát',
          addressDetail: '123 ABC',
          lat: 10.76,
          lng: 106.66,
          scheduledTime: DateTime(2030, 1, 2, 14),
        ),
      );

      expect((result as Ok<Booking>).value.status, BookingStatus.pending);
      expect(repository.cached('501'), isNotNull);
      final sent = verify(() => remote.createBooking(captureAny())).captured.single as CreateBookingRequest;
      expect(sent.scheduledTime.isUtc, isTrue);
    });

    test('getMyBookings maps statuses and filters by API value', () async {
      when(() => remote.getBookings(page: 0, size: 20, status: 'COMPLETED')).thenAnswer(
        (_) async => PagedResponse(
          content: [BookingResponse.fromJson(const {'requestId': 7, 'status': 'COMPLETED'})],
          page: 0,
          size: 20,
          totalItems: 1,
          totalPages: 1,
        ),
      );

      final result = await repository.getMyBookings(page: 0, status: BookingStatus.completed);

      final page = (result as Ok<BookingPage>).value;
      expect(page.items.single.status, BookingStatus.completed);
      expect(page.hasMore, isFalse);
    });

    test('cancel returns the new status and updates the cache', () async {
      when(() => remote.createBooking(any())).thenAnswer((_) async => BookingResponse.fromJson(_bookingJson));
      await repository.create(
        NewBooking(
          categoryId: '1',
          description: 'x',
          addressDetail: 'y',
          lat: 1,
          lng: 1,
          scheduledTime: DateTime.utc(2030),
        ),
      );
      when(() => remote.cancel('501')).thenAnswer(
        (_) async => const StatusTransitionResponse(previousStatus: 'PENDING', newStatus: 'CANCELLED'),
      );

      final result = await repository.cancel('501');

      expect((result as Ok<BookingStatus>).value, BookingStatus.cancelled);
      expect(repository.cached('501')?.status, BookingStatus.cancelled);
    });
  });
}
