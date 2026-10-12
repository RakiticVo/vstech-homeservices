import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vstech_home_services/core/error/result.dart';
import 'package:vstech_home_services/core/network/api_endpoints.dart';
import 'package:vstech_home_services/core/network/api_response.dart';
import 'package:vstech_home_services/features/booking/data/datasources/booking_remote_data_source.dart';
import 'package:vstech_home_services/features/booking/data/models/complete_booking_request.dart';
import 'package:vstech_home_services/features/booking/data/models/quote_response.dart';
import 'package:vstech_home_services/features/booking/data/models/status_transition_response.dart';
import 'package:vstech_home_services/features/booking/data/models/submit_quote_request.dart';
import 'package:vstech_home_services/features/booking/data/repositories/booking_repository_impl.dart';
import 'package:vstech_home_services/features/booking/domain/entities/booking_status.dart';
import 'package:vstech_home_services/features/booking/domain/entities/quote_line.dart';
import 'package:vstech_home_services/features/booking/domain/usecases/worker_booking_use_cases.dart';

import '../../../helpers/mocks.dart';

ApiResponse<T> _ok<T>(T data) => ApiResponse(
  status: 200,
  message: '',
  data: data,
  errorCode: null,
  timestamp: null,
);

void main() {
  group('BookingRemoteDataSource (worker)', () {
    late MockApiClient client;
    late BookingRemoteDataSource dataSource;

    setUp(() {
      client = MockApiClient();
      dataSource = BookingRemoteDataSource(client);
      when(
        () => client.post<StatusTransitionResponse>(
          any(),
          body: any(named: 'body'),
          idempotent: true,
          decode: any(named: 'decode'),
        ),
      ).thenAnswer(
        (_) async => _ok(const StatusTransitionResponse(newStatus: 'ACCEPTED')),
      );
      when(
        () => client.post<QuoteResponse>(
          any(),
          body: any(named: 'body'),
          idempotent: true,
          decode: any(named: 'decode'),
        ),
      ).thenAnswer(
        (_) async =>
            _ok(const QuoteResponse(status: 'PENDING', totalAmount: 45000)),
      );
    });

    test('accept and start are idempotent POSTs without a body', () async {
      await dataSource.accept('7');
      await dataSource.start('7');

      verify(
        () => client.post<StatusTransitionResponse>(
          ApiEndpoints.bookingAccept('7'),
          idempotent: true,
          decode: any(named: 'decode'),
        ),
      ).called(1);
      verify(
        () => client.post<StatusTransitionResponse>(
          ApiEndpoints.bookingStart('7'),
          idempotent: true,
          decode: any(named: 'decode'),
        ),
      ).called(1);
    });

    test('complete sends actualPrice', () async {
      await dataSource.complete(
        '7',
        const CompleteBookingRequest(actualPrice: 600000),
      );

      verify(
        () => client.post<StatusTransitionResponse>(
          ApiEndpoints.bookingComplete('7'),
          body: {'actualPrice': 600000},
          idempotent: true,
          decode: any(named: 'decode'),
        ),
      ).called(1);
    });

    test('submitQuote serialises items as maps', () async {
      await dataSource.submitQuote(
        '7',
        SubmitQuoteRequest.fromJson(const {
          'items': [
            {'itemName': 'Gas R32', 'amount': 45000},
          ],
        }),
      );

      verify(
        () => client.post<QuoteResponse>(
          ApiEndpoints.bookingQuote('7'),
          body: {
            'items': [
              {'itemName': 'Gas R32', 'amount': 45000},
            ],
            'evidencePhotoUrls': <String>[],
          },
          idempotent: true,
          decode: any(named: 'decode'),
        ),
      ).called(1);
    });
  });

  group('BookingRepositoryImpl (worker)', () {
    late MockBookingRemoteDataSource remote;
    late BookingRepositoryImpl repository;

    setUpAll(() {
      registerFallbackValue(const CompleteBookingRequest(actualPrice: 0));
      registerFallbackValue(const SubmitQuoteRequest(items: []));
    });

    setUp(() {
      remote = MockBookingRemoteDataSource();
      repository = BookingRepositoryImpl(remote);
    });

    test('accept/start/complete return the new status', () async {
      when(() => remote.accept('7')).thenAnswer(
        (_) async => const StatusTransitionResponse(newStatus: 'ACCEPTED'),
      );
      when(() => remote.start('7')).thenAnswer(
        (_) async => const StatusTransitionResponse(newStatus: 'IN_PROGRESS'),
      );
      when(() => remote.complete('7', any())).thenAnswer(
        (_) async => const StatusTransitionResponse(newStatus: 'COMPLETED'),
      );

      expect(
        await repository.accept('7'),
        isA<Ok<BookingStatus>>().having(
          (r) => r.value,
          'v',
          BookingStatus.accepted,
        ),
      );
      expect(
        await repository.start('7'),
        isA<Ok<BookingStatus>>().having(
          (r) => r.value,
          'v',
          BookingStatus.inProgress,
        ),
      );
      expect(
        await repository.complete('7', actualPrice: 600000),
        isA<Ok<BookingStatus>>().having(
          (r) => r.value,
          'v',
          BookingStatus.completed,
        ),
      );
      final sent =
          verify(() => remote.complete('7', captureAny())).captured.single
              as CompleteBookingRequest;
      expect(sent.actualPrice, 600000);
    });

    test('submitQuote maps lines to items', () async {
      when(() => remote.submitQuote('7', any()))
          .thenAnswer((_) async => const QuoteResponse(status: 'PENDING'));

      await repository.submitQuote('7', const [
        QuoteLine(itemName: 'Gas R32', amount: 45000),
      ]);

      final sent =
          verify(() => remote.submitQuote('7', captureAny())).captured.single
              as SubmitQuoteRequest;
      expect(sent.items.single.itemName, 'Gas R32');
      expect(sent.items.single.amount, 45000);
    });
  });

  group('worker use cases', () {
    late MockBookingRepository repository;

    setUpAll(() => registerFallbackValue(<QuoteLine>[]));

    setUp(() => repository = MockBookingRepository());

    test('CompleteBookingUseCase rejects prices above 1.5 × estimate with HS-400-0012', () async {
      final result = await CompleteBookingUseCase(repository)(
        '7',
        actualPrice: 760000,
        estimatedPrice: 500000,
      );

      expect(
        result,
        isA<Err<BookingStatus>>().having(
          (r) => r.failure.errorCode,
          'code',
          'HS-400-0012',
        ),
      );
      verifyNever(
        () =>
            repository.complete(any(), actualPrice: any(named: 'actualPrice')),
      );
    });

    test('CompleteBookingUseCase completes within the limit', () async {
      when(() => repository.complete('7', actualPrice: 750000))
          .thenAnswer((_) async => const Ok(BookingStatus.completed));

      final result = await CompleteBookingUseCase(repository)(
        '7',
        actualPrice: 750000,
        estimatedPrice: 500000,
      );

      expect(result, isA<Ok<BookingStatus>>());
    });

    test('SubmitQuoteUseCase validates and trims lines', () async {
      when(() => repository.submitQuote(any(), any()))
          .thenAnswer((_) async => const Ok<void>(null));

      final invalid = await SubmitQuoteUseCase(repository)('7', const [
        QuoteLine(itemName: ' ', amount: 1),
      ]);
      expect(
        invalid,
        isA<Err<void>>().having(
          (r) => r.failure.errorCode,
          'code',
          'HS-400-0001',
        ),
      );

      await SubmitQuoteUseCase(repository)('7', const [
        QuoteLine(itemName: ' Gas R32 ', amount: 45000),
      ]);
      final sent =
          verify(() => repository.submitQuote('7', captureAny()))
                  .captured
                  .single
              as List<QuoteLine>;
      expect(sent.single.itemName, 'Gas R32');
    });
  });
}
