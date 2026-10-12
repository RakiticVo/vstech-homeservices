import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vstech_home_services/core/error/failure.dart';
import 'package:vstech_home_services/core/error/result.dart';
import 'package:vstech_home_services/core/network/network_exception.dart';
import 'package:vstech_home_services/features/messaging/domain/entities/voip_call.dart';
import 'package:vstech_home_services/features/messaging/presentation/bloc/voip_call_cubit.dart';

import '../../../helpers/mocks.dart';

const _call = VoipCall(id: '70', bookingId: '502');
const _offline = Failure(kind: NetworkErrorKind.noConnection);

void main() {
  late MockStartBookingCallUseCase startCall;
  late MockEndCallUseCase endCall;

  setUp(() {
    startCall = MockStartBookingCallUseCase();
    endCall = MockEndCallUseCase();
    when(() => endCall(any(), durationSeconds: any(named: 'durationSeconds')))
        .thenAnswer((_) async => const Ok(_call));
  });

  VoipCallCubit build() => VoipCallCubit(startCall, endCall);

  blocTest<VoipCallCubit, VoipCallState>(
    'start logs the call and becomes active',
    setUp: () =>
        when(() => startCall('502', isWorker: false))
            .thenAnswer((_) async => const Ok(_call)),
    build: build,
    act: (cubit) => cubit.start('502', isWorker: false),
    expect: () => [
      const VoipCallStartingState(),
      const VoipCallActiveState(call: _call),
    ],
  );

  blocTest<VoipCallCubit, VoipCallState>(
    'start failure shows the error',
    setUp: () =>
        when(() => startCall('502', isWorker: true))
            .thenAnswer((_) async => const Err(_offline)),
    build: build,
    act: (cubit) => cubit.start('502', isWorker: true),
    expect: () => [
      const VoipCallStartingState(),
      const VoipCallErrorState(_offline),
    ],
  );

  blocTest<VoipCallCubit, VoipCallState>(
    'talk time, mute and speaker update the active call; hang up logs the duration',
    build: build,
    seed: () => const VoipCallActiveState(call: _call),
    act: (cubit) async {
      cubit
        ..tick()
        ..tick()
        ..toggleMute()
        ..toggleSpeaker();
      await cubit.hangUp();
    },
    expect: () => [
      const VoipCallActiveState(call: _call, elapsedSeconds: 1),
      const VoipCallActiveState(call: _call, elapsedSeconds: 2),
      const VoipCallActiveState(call: _call, elapsedSeconds: 2, isMuted: true),
      const VoipCallActiveState(
        call: _call,
        elapsedSeconds: 2,
        isMuted: true,
        isSpeaker: true,
      ),
      const VoipCallEndedState(durationSeconds: 2),
    ],
    verify: (_) => verify(() => endCall('70', durationSeconds: 2)).called(1),
  );

  blocTest<VoipCallCubit, VoipCallState>(
    'a failed end log still ends the call on screen',
    setUp: () => when(
      () => endCall(any(), durationSeconds: any(named: 'durationSeconds')),
    ).thenAnswer((_) async => const Err(_offline)),
    build: build,
    seed: () => const VoipCallActiveState(call: _call, elapsedSeconds: 5),
    act: (cubit) => cubit.hangUp(),
    expect: () => [const VoipCallEndedState(durationSeconds: 5)],
  );

  test('closing during an active call logs its end', () async {
    when(() => startCall('502', isWorker: false))
        .thenAnswer((_) async => const Ok(_call));
    final cubit = build();
    await cubit.start('502', isWorker: false);
    cubit.tick();

    await cubit.close();

    verify(() => endCall('70', durationSeconds: 1)).called(1);
  });
}
