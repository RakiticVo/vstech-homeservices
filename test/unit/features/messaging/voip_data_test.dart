import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vstech_home_services/core/error/failure.dart';
import 'package:vstech_home_services/core/error/result.dart';
import 'package:vstech_home_services/core/network/api_endpoints.dart';
import 'package:vstech_home_services/core/network/api_response.dart';
import 'package:vstech_home_services/features/auth/domain/entities/user_profile.dart';
import 'package:vstech_home_services/features/booking/domain/entities/booking.dart';
import 'package:vstech_home_services/features/booking/domain/entities/booking_status.dart';
import 'package:vstech_home_services/features/messaging/data/datasources/voip_remote_data_source.dart';
import 'package:vstech_home_services/features/messaging/data/models/end_call_request.dart';
import 'package:vstech_home_services/features/messaging/data/models/start_call_request.dart';
import 'package:vstech_home_services/features/messaging/data/models/voip_call_response.dart';
import 'package:vstech_home_services/features/messaging/data/repositories/voip_repository_impl.dart';
import 'package:vstech_home_services/features/messaging/domain/entities/voip_call.dart';
import 'package:vstech_home_services/features/messaging/domain/usecases/voip_use_cases.dart';

import '../../../fixtures/auth/auth_fixtures.dart';
import '../../../helpers/mocks.dart';

ApiResponse<T> _ok<T>(T data) => ApiResponse(
  status: 200,
  message: '',
  data: data,
  errorCode: null,
  timestamp: null,
);

const _booking = Booking(
  id: '502',
  status: BookingStatus.accepted,
  customerId: '9',
  assignedWorkerId: '8821',
);

void main() {
  group('VoipRemoteDataSource', () {
    late MockApiClient client;
    late VoipRemoteDataSource dataSource;

    setUp(() {
      client = MockApiClient();
      dataSource = VoipRemoteDataSource(client);
    });

    test('startCall posts numeric ids idempotently', () async {
      when(
        () => client.post<VoipCallResponse>(
          ApiEndpoints.voipCalls,
          body: any(named: 'body'),
          idempotent: true,
          decode: any(named: 'decode'),
        ),
      ).thenAnswer(
        (_) async => _ok(const VoipCallResponse(id: '70', status: 'INITIATED')),
      );

      await dataSource.startCall(
        const StartCallRequest(
          bookingId: '502',
          callerId: '9',
          receiverId: '8821',
        ),
      );

      verify(
        () => client.post<VoipCallResponse>(
          ApiEndpoints.voipCalls,
          body: {'bookingId': 502, 'callerId': 9, 'receiverId': 8821},
          idempotent: true,
          decode: any(named: 'decode'),
        ),
      ).called(1);
    });

    test('endCall omits recordingUrl when there is none', () async {
      when(
        () => client.post<VoipCallResponse>(
          ApiEndpoints.voipCallsEnd,
          body: any(named: 'body'),
          idempotent: true,
          decode: any(named: 'decode'),
        ),
      ).thenAnswer(
        (_) async => _ok(const VoipCallResponse(id: '70', durationSeconds: 48)),
      );

      await dataSource.endCall(
        const EndCallRequest(callId: '70', durationSeconds: 48),
      );

      verify(
        () => client.post<VoipCallResponse>(
          ApiEndpoints.voipCallsEnd,
          body: {'callId': 70, 'durationSeconds': 48},
          idempotent: true,
          decode: any(named: 'decode'),
        ),
      ).called(1);
    });

    test('getCalls decodes a bare list filtered by booking', () async {
      when(
        () => client.get<List<VoipCallResponse>>(
          ApiEndpoints.voipCalls,
          query: any(named: 'query'),
          decode: any(named: 'decode'),
        ),
      ).thenAnswer((invocation) async {
        final decode =
            invocation.namedArguments[#decode]
                as List<VoipCallResponse> Function(Object?);
        return _ok(
          decode([
            {
              'id': 70,
              'bookingId': 502,
              'durationSeconds': 48,
              'startedAt': '2026-10-11T03:04:00Z',
            },
          ]),
        );
      });

      final calls = await dataSource.getCalls(bookingId: '502');

      expect(calls.single.id, '70');
      expect(calls.single.startedAt, DateTime.utc(2026, 10, 11, 3, 4));
      verify(
        () => client.get<List<VoipCallResponse>>(
          ApiEndpoints.voipCalls,
          query: {'bookingId': '502'},
          decode: any(named: 'decode'),
        ),
      ).called(1);
    });
  });

  group('VoipRepositoryImpl', () {
    test('maps the call log; a zero-length ended call is missed', () async {
      final remote = MockVoipRemoteDataSource();
      when(() => remote.getCalls(bookingId: '502')).thenAnswer(
        (_) async => [
          VoipCallResponse(
            id: '70',
            durationSeconds: 0,
            endedAt: DateTime.utc(2026),
          ),
          const VoipCallResponse(id: '71'),
        ],
      );

      final calls = (await VoipRepositoryImpl(
        remote,
      ).getCalls(bookingId: '502') as Ok<List<VoipCall>>).value;

      expect(calls.first.isMissed, isTrue);
      expect(calls.last.isMissed, isFalse);
    });
  });

  group('StartBookingCallUseCase', () {
    late MockVoipRepository repository;
    late MockGetProfileUseCase getProfile;
    late MockGetBookingUseCase getBooking;

    setUp(() {
      repository = MockVoipRepository();
      getProfile = MockGetProfileUseCase();
      getBooking = MockGetBookingUseCase();
      when(() => getBooking('502')).thenAnswer((_) async => const Ok(_booking));
      when(
        () => repository.startCall(
          bookingId: any(named: 'bookingId'),
          callerId: any(named: 'callerId'),
          receiverId: any(named: 'receiverId'),
        ),
      ).thenAnswer((_) async => const Ok(VoipCall(id: '70')));
    });

    test('a customer calls the assigned worker', () async {
      when(() => getProfile())
          .thenAnswer((_) async => const Ok<UserProfile>(customerProfile));

      await StartBookingCallUseCase(repository, getProfile, getBooking)(
        '502',
        isWorker: false,
      );

      verify(
        () => repository.startCall(
          bookingId: '502',
          callerId: '9',
          receiverId: '8821',
        ),
      ).called(1);
    });

    test('a worker calls the booking customer', () async {
      when(() => getProfile())
          .thenAnswer((_) async => const Ok<UserProfile>(workerProfile));

      await StartBookingCallUseCase(repository, getProfile, getBooking)(
        '502',
        isWorker: true,
      );

      verify(
        () => repository.startCall(
          bookingId: '502',
          callerId: '8821',
          receiverId: '9',
        ),
      ).called(1);
    });

    test(
      'no assigned worker yet → callPeerMissing without calling the API',
      () async {
        when(() => getProfile())
            .thenAnswer((_) async => const Ok<UserProfile>(customerProfile));
        when(() => getBooking('502')).thenAnswer(
          (_) async =>
              const Ok(Booking(id: '502', status: BookingStatus.pending)),
        );

        final result = await StartBookingCallUseCase(
          repository,
          getProfile,
          getBooking,
        )('502', isWorker: false);

        expect((result as Err).failure.errorCode, AppException.callPeerMissing);
        verifyNever(
          () => repository.startCall(
            bookingId: any(named: 'bookingId'),
            callerId: any(named: 'callerId'),
            receiverId: any(named: 'receiverId'),
          ),
        );
      },
    );
  });
}
