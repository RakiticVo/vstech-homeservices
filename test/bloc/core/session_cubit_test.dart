import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vstech_home_services/core/session/session_cubit.dart';

import '../../helpers/mocks.dart';

void main() {
  late MockAuthTokenStore tokenStore;

  setUp(() {
    tokenStore = MockAuthTokenStore();
    when(() => tokenStore.clear()).thenAnswer((_) async {});
  });

  test('starts in SessionInitialState', () {
    expect(SessionCubit(tokenStore).state, isA<SessionInitialState>());
  });

  blocTest<SessionCubit, SessionState>(
    'restore emits authenticated when a refresh token is stored',
    setUp: () => when(() => tokenStore.readRefreshToken()).thenAnswer((_) async => 'r'),
    build: () => SessionCubit(tokenStore),
    act: (cubit) => cubit.restore(),
    expect: () => [isA<SessionAuthenticatedState>()],
  );

  blocTest<SessionCubit, SessionState>(
    'restore emits unauthenticated without a refresh token',
    setUp: () => when(() => tokenStore.readRefreshToken()).thenAnswer((_) async => null),
    build: () => SessionCubit(tokenStore),
    act: (cubit) => cubit.restore(),
    expect: () => [const SessionUnauthenticatedState()],
  );

  blocTest<SessionCubit, SessionState>(
    'expire emits an expired unauthenticated state',
    build: () => SessionCubit(tokenStore),
    seed: () => const SessionAuthenticatedState(),
    act: (cubit) => cubit.expire(),
    expect: () => [const SessionUnauthenticatedState(expired: true)],
  );

  blocTest<SessionCubit, SessionState>(
    'signOut clears tokens and emits unauthenticated',
    build: () => SessionCubit(tokenStore),
    seed: () => const SessionAuthenticatedState(),
    act: (cubit) => cubit.signOut(),
    expect: () => [const SessionUnauthenticatedState()],
    verify: (_) => verify(() => tokenStore.clear()).called(1),
  );
}
