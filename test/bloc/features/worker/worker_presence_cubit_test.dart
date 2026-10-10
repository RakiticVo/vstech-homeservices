import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vstech_home_services/core/error/failure.dart';
import 'package:vstech_home_services/core/error/result.dart';
import 'package:vstech_home_services/core/location/location_service.dart';
import 'package:vstech_home_services/core/network/network_exception.dart';
import 'package:vstech_home_services/core/session/session_cubit.dart';
import 'package:vstech_home_services/features/worker_dashboard/presentation/bloc/worker_presence_cubit.dart';

import '../../../helpers/mocks.dart';

const _first = GeoPoint(10.70, 106.60);
const _moved = GeoPoint(10.71, 106.61);

void main() {
  late MockLocationService location;
  late MockUpdateTechnicianLocationUseCase updateLocation;
  late MockSessionCubit session;
  late StreamController<GeoPoint> positions;
  late StreamController<SessionState> sessionStates;

  WorkerPresenceCubit build() =>
      WorkerPresenceCubit(location, updateLocation, session, broadcastInterval: const Duration(milliseconds: 20));

  setUpAll(() => registerFallbackValue(_first));

  setUp(() {
    location = MockLocationService();
    updateLocation = MockUpdateTechnicianLocationUseCase();
    session = MockSessionCubit();
    positions = StreamController<GeoPoint>.broadcast();
    sessionStates = StreamController<SessionState>.broadcast();
    when(() => session.stream).thenAnswer((_) => sessionStates.stream);
    when(() => location.watchPosition()).thenAnswer((_) => positions.stream);
    when(() => updateLocation(any())).thenAnswer((_) async => const Ok<void>(null));
  });

  tearDown(() async {
    await positions.close();
    await sessionStates.close();
  });

  blocTest<WorkerPresenceCubit, WorkerPresenceState>(
    'going online sends the first fix immediately, then the latest one every interval',
    setUp: () => when(() => location.currentPosition()).thenAnswer((_) async => (_first, null)),
    build: build,
    act: (cubit) async {
      await cubit.goOnline();
      positions.add(_moved);
      await Future<void>.delayed(const Duration(milliseconds: 70));
      await cubit.goOffline();
    },
    expect: () => [
      const WorkerGoingOnlineState(),
      const WorkerOnlineState(),
      const WorkerOnlineState(lastSent: _first),
      const WorkerOnlineState(lastSent: _moved),
      const WorkerOfflineState(),
    ],
    verify: (_) {
      verify(() => updateLocation(_first)).called(1);
      verify(() => updateLocation(_moved)).called(greaterThanOrEqualTo(2));
    },
  );

  blocTest<WorkerPresenceCubit, WorkerPresenceState>(
    'stays offline with the reason when the position is unavailable',
    setUp: () =>
        when(() => location.currentPosition()).thenAnswer((_) async => (null, LocationFailure.permissionDenied)),
    build: build,
    act: (cubit) => cubit.goOnline(),
    expect: () => [const WorkerGoingOnlineState(), const WorkerPresenceErrorState(LocationFailure.permissionDenied)],
    verify: (_) => verifyNever(() => updateLocation(any())),
  );

  blocTest<WorkerPresenceCubit, WorkerPresenceState>(
    'a failed broadcast keeps the worker online',
    setUp: () {
      when(() => location.currentPosition()).thenAnswer((_) async => (_first, null));
      when(() => updateLocation(any()))
          .thenAnswer((_) async => const Err<void>(Failure(kind: NetworkErrorKind.noConnection)));
    },
    build: build,
    act: (cubit) => cubit.goOnline(),
    expect: () => [
      const WorkerGoingOnlineState(),
      const WorkerOnlineState(),
      const WorkerOnlineState(lastSent: _first),
    ],
  );

  blocTest<WorkerPresenceCubit, WorkerPresenceState>(
    'signing out stops broadcasting',
    setUp: () => when(() => location.currentPosition()).thenAnswer((_) async => (_first, null)),
    build: build,
    act: (cubit) async {
      await cubit.goOnline();
      sessionStates.add(const SessionUnauthenticatedState());
      await Future<void>.delayed(const Duration(milliseconds: 50));
    },
    skip: 3,
    expect: () => [const WorkerOfflineState()],
    verify: (_) => verify(() => updateLocation(any())).called(1),
  );

  blocTest<WorkerPresenceCubit, WorkerPresenceState>(
    'toggle switches between online and offline',
    setUp: () => when(() => location.currentPosition()).thenAnswer((_) async => (_first, null)),
    build: build,
    seed: () => const WorkerOnlineState(),
    act: (cubit) => cubit.toggle(),
    expect: () => [const WorkerOfflineState()],
  );
}
