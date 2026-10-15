import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vstech_home_services/core/error/failure.dart';
import 'package:vstech_home_services/core/error/result.dart';
import 'package:vstech_home_services/core/network/network_exception.dart';
import 'package:vstech_home_services/features/auth/domain/entities/user_profile.dart';
import 'package:vstech_home_services/features/booking/domain/entities/booking.dart';
import 'package:vstech_home_services/features/booking/domain/entities/booking_status.dart';
import 'package:vstech_home_services/features/tracking/domain/entities/worker_position.dart';
import 'package:vstech_home_services/features/tracking/presentation/bloc/customer_tracking_cubit.dart';

import '../../../fixtures/auth/auth_fixtures.dart';
import '../../../fixtures/booking/booking_fixtures.dart';
import '../../../helpers/mocks.dart';

const _offline = Failure(kind: NetworkErrorKind.noConnection);
const _home = (10.7725, 106.6980);
final UserProfile _profile = customerProfile.copyWith(
  lat: _home.$1,
  lng: _home.$2,
);
final _position = WorkerPosition(
  latitude: 10.7798,
  longitude: 106.6990,
  updatedAt: DateTime.utc(2026, 10, 15, 3),
);

void main() {
  late MockGetBookingUseCase getBooking;
  late MockGetProfileUseCase getProfile;
  late MockTrackingConnection connection;
  late StreamController<TrackingEvent> events;
  late StreamController<TrackingConnectionStatus> statuses;

  setUp(() {
    getBooking = MockGetBookingUseCase();
    getProfile = MockGetProfileUseCase();
    connection = MockTrackingConnection();
    events = StreamController.broadcast();
    statuses = StreamController.broadcast();
    when(() => connection.events).thenAnswer((_) => events.stream);
    when(() => connection.status).thenAnswer((_) => statuses.stream);
    when(() => connection.connect(any())).thenAnswer((_) async {});
    when(() => connection.disconnect()).thenAnswer((_) async {});
    when(() => connection.close()).thenAnswer((_) async {});
    when(() => getBooking('502', refresh: true))
        .thenAnswer((_) async => Ok<Booking>(acceptedBooking));
    when(() => getProfile()).thenAnswer((_) async => Ok<UserProfile>(_profile));
  });

  CustomerTrackingCubit build() =>
      CustomerTrackingCubit(getBooking, getProfile, connection);

  CustomerTrackingLoadedState loaded({
    Booking? booking,
    WorkerPosition? position,
    TrackingConnectionStatus connection = TrackingConnectionStatus.connecting,
    String? errorCode,
  }) => CustomerTrackingLoadedState(
    booking: booking ?? acceptedBooking,
    home: _home,
    position: position,
    connection: connection,
    errorCode: errorCode,
  );

  blocTest<CustomerTrackingCubit, CustomerTrackingState>(
    'an accepted booking is "en route" and starts tracking it',
    build: build,
    act: (cubit) => cubit.load('502'),
    expect: () => [const CustomerTrackingLoadingState(), loaded()],
    verify: (cubit) {
      verify(() => connection.connect('502')).called(1);
      expect(
        (cubit.state as CustomerTrackingLoadedState).stage,
        TrackingStage.enRoute,
      );
    },
  );

  blocTest<CustomerTrackingCubit, CustomerTrackingState>(
    'a completed booking awaits sign-off and never connects',
    setUp: () => when(() => getBooking('502', refresh: true)).thenAnswer(
      (_) async => Ok<Booking>(
        acceptedBooking.copyWith(status: BookingStatus.completed),
      ),
    ),
    build: build,
    act: (cubit) => cubit.load('502'),
    expect: () => [
      const CustomerTrackingLoadingState(),
      loaded(
        booking: acceptedBooking.copyWith(status: BookingStatus.completed),
        connection: TrackingConnectionStatus.offline,
      ),
    ],
    verify: (_) => verifyNever(() => connection.connect(any())),
  );

  blocTest<CustomerTrackingCubit, CustomerTrackingState>(
    'a booking load failure is shown; a missing profile only drops the distance',
    setUp: () =>
        when(() => getBooking('502', refresh: true))
            .thenAnswer((_) async => const Err<Booking>(_offline)),
    build: build,
    act: (cubit) => cubit.load('502'),
    expect: () => [
      const CustomerTrackingLoadingState(),
      const CustomerTrackingErrorState(_offline),
    ],
  );

  blocTest<CustomerTrackingCubit, CustomerTrackingState>(
    'live status and positions stream in; distance is measured to the profile address',
    build: build,
    act: (cubit) async {
      await cubit.load('502');
      statuses.add(TrackingConnectionStatus.live);
      await pumpEventQueue();
      events
        ..add(const TrackingPositionEvent(null))
        ..add(TrackingPositionEvent(_position));
      await pumpEventQueue();
    },
    skip: 2,
    expect: () => [
      loaded(connection: TrackingConnectionStatus.live),
      loaded(connection: TrackingConnectionStatus.live, position: _position),
    ],
    verify: (cubit) => expect(
      (cubit.state as CustomerTrackingLoadedState).distanceMeters,
      inInclusiveRange(780, 850),
    ),
  );

  blocTest<CustomerTrackingCubit, CustomerTrackingState>(
    'TRACKING_ENDED stops the socket and reloads the booking',
    build: build,
    act: (cubit) async {
      await cubit.load('502');
      when(() => getBooking('502', refresh: true)).thenAnswer(
        (_) async => Ok<Booking>(
          acceptedBooking.copyWith(status: BookingStatus.completed),
        ),
      );
      events.add(const TrackingEndedEvent('COMPLETED'));
      await pumpEventQueue();
    },
    skip: 2,
    expect: () => [
      loaded(
        booking: acceptedBooking.copyWith(status: BookingStatus.completed),
        connection: TrackingConnectionStatus.offline,
      ),
    ],
    verify: (_) => verify(() => connection.disconnect()).called(1),
  );

  blocTest<CustomerTrackingCubit, CustomerTrackingState>(
    'an ERROR frame stops tracking and keeps the code; reconnect clears it and connects again',
    build: build,
    act: (cubit) async {
      await cubit.load('502');
      events.add(const TrackingErrorEvent('HS-403-0001'));
      await pumpEventQueue();
      await cubit.reconnect();
    },
    skip: 2,
    expect: () => [
      loaded(
        connection: TrackingConnectionStatus.offline,
        errorCode: 'HS-403-0001',
      ),
      loaded(),
    ],
    verify: (_) {
      // Once on ERROR, once more when bloc_test closes the reconnected cubit.
      verify(() => connection.disconnect()).called(2);
      verify(() => connection.connect('502')).called(2);
    },
  );

  test('close closes the socket', () async {
    final cubit = build();
    await cubit.load('502');
    await cubit.close();
    verify(() => connection.close()).called(1);
  });
}
