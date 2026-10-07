import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vstech_home_services/core/error/failure.dart';
import 'package:vstech_home_services/core/error/result.dart';
import 'package:vstech_home_services/core/network/network_exception.dart';
import 'package:vstech_home_services/core/session/session_cubit.dart';
import 'package:vstech_home_services/features/auth/domain/entities/app_user.dart';
import 'package:vstech_home_services/features/auth/domain/entities/profile_update.dart';
import 'package:vstech_home_services/features/auth/domain/entities/remembered_credentials.dart';
import 'package:vstech_home_services/features/auth/domain/entities/user_profile.dart';
import 'package:vstech_home_services/features/auth/presentation/bloc/login_cubit.dart';
import 'package:vstech_home_services/features/auth/presentation/bloc/logout_cubit.dart';
import 'package:vstech_home_services/features/auth/presentation/bloc/profile_cubit.dart';
import 'package:vstech_home_services/features/auth/presentation/bloc/register_cubit.dart';
import 'package:vstech_home_services/features/auth/presentation/bloc/splash_cubit.dart';

import '../../../fixtures/auth/auth_fixtures.dart';
import '../../../helpers/mocks.dart';

const _offline = Failure(kind: NetworkErrorKind.noConnection);
const _badCredentials = Failure(kind: NetworkErrorKind.server, errorCode: 'HS-401-0002', statusCode: 401);

void main() {
  late MockSessionCubit session;
  late MockCredentialsRepository credentials;

  setUpAll(() {
    registerFallbackValue(const ProfileUpdate());
    registerFallbackValue(UserRole.customer);
    registerFallbackValue(const RememberedCredentials(identifier: '', password: ''));
  });

  setUp(() {
    session = MockSessionCubit();
    when(() => session.signOut()).thenAnswer((_) async {});
    credentials = MockCredentialsRepository();
    when(() => credentials.save(any(), any())).thenAnswer((_) async {});
    when(() => credentials.clear(any())).thenAnswer((_) async {});
  });

  group('SplashCubit', () {
    late MockGetProfileUseCase getProfile;

    setUp(() => getProfile = MockGetProfileUseCase());

    blocTest<SplashCubit, SplashState>(
      'goes to onboarding when signed out, without fetching the profile',
      setUp: () => when(() => session.state).thenReturn(const SessionUnauthenticatedState()),
      build: () => SplashCubit(session, getProfile),
      act: (cubit) => cubit.resolve(),
      expect: () => [const SplashLoadingState(), const SplashResolvedState(SplashDestination.onboarding)],
      verify: (_) => verifyNever(() => getProfile()),
    );

    blocTest<SplashCubit, SplashState>(
      'resolves a worker to the dashboard and records the role',
      setUp: () {
        when(() => session.state).thenReturn(const SessionAuthenticatedState());
        when(() => getProfile()).thenAnswer((_) async => const Ok<UserProfile>(workerProfile));
      },
      build: () => SplashCubit(session, getProfile),
      act: (cubit) => cubit.resolve(),
      expect: () => [const SplashLoadingState(), const SplashResolvedState(SplashDestination.workerHome)],
      verify: (_) => verify(() => session.markAuthenticated(role: UserRole.worker)).called(1),
    );

    blocTest<SplashCubit, SplashState>(
      'resolves a customer to home',
      setUp: () {
        when(() => session.state).thenReturn(const SessionAuthenticatedState());
        when(() => getProfile()).thenAnswer((_) async => const Ok<UserProfile>(customerProfile));
      },
      build: () => SplashCubit(session, getProfile),
      act: (cubit) => cubit.resolve(),
      expect: () => [const SplashLoadingState(), const SplashResolvedState(SplashDestination.customerHome)],
    );

    blocTest<SplashCubit, SplashState>(
      'signs out unsupported roles',
      setUp: () {
        when(() => session.state).thenReturn(const SessionAuthenticatedState());
        when(() => getProfile())
            .thenAnswer((_) async => const Ok<UserProfile>(UserProfile(id: 1, role: UserRole.unsupported)));
      },
      build: () => SplashCubit(session, getProfile),
      act: (cubit) => cubit.resolve(),
      expect: () => [const SplashLoadingState(), const SplashResolvedState(SplashDestination.onboarding)],
      verify: (_) => verify(() => session.signOut()).called(1),
    );

    blocTest<SplashCubit, SplashState>(
      'an expired session falls back to onboarding',
      setUp: () {
        when(() => session.state).thenReturn(const SessionAuthenticatedState());
        when(() => getProfile())
            .thenAnswer((_) async => const Err<UserProfile>(Failure(kind: NetworkErrorKind.server, statusCode: 401)));
      },
      build: () => SplashCubit(session, getProfile),
      act: (cubit) => cubit.resolve(),
      expect: () => [const SplashLoadingState(), const SplashResolvedState(SplashDestination.onboarding)],
    );

    blocTest<SplashCubit, SplashState>(
      'other errors are surfaced for retry',
      setUp: () {
        when(() => session.state).thenReturn(const SessionAuthenticatedState());
        when(() => getProfile()).thenAnswer((_) async => const Err<UserProfile>(_offline));
      },
      build: () => SplashCubit(session, getProfile),
      act: (cubit) => cubit.resolve(),
      expect: () => [const SplashLoadingState(), const SplashErrorState(_offline)],
    );
  });

  group('LoginCubit', () {
    late MockLoginUseCase login;

    setUp(() => login = MockLoginUseCase());

    blocTest<LoginCubit, AuthFormState>(
      'success marks the session with the role',
      setUp: () => when(
        () => login(
          identifier: any(named: 'identifier'),
          password: any(named: 'password'),
        ),
      ).thenAnswer((_) async => const Ok<AppUser>(workerUser)),
      build: () => LoginCubit(login, session, credentials),
      act: (cubit) => cubit.login(identifier: '0909', password: 'p'),
      expect: () => [const AuthFormSubmittingState(), const AuthFormSuccessState(UserRole.worker)],
      verify: (_) => verify(() => session.markAuthenticated(role: UserRole.worker)).called(1),
    );

    blocTest<LoginCubit, AuthFormState>(
      'failure is emitted and the session untouched',
      setUp: () => when(
        () => login(
          identifier: any(named: 'identifier'),
          password: any(named: 'password'),
        ),
      ).thenAnswer((_) async => const Err<AppUser>(_badCredentials)),
      build: () => LoginCubit(login, session, credentials),
      act: (cubit) => cubit.login(identifier: '0909', password: 'wrong'),
      expect: () => [const AuthFormSubmittingState(), const AuthFormFailureState(_badCredentials)],
      verify: (_) {
        verifyNever(() => session.markAuthenticated(role: any(named: 'role')));
        verifyNever(() => credentials.save(any(), any()));
      },
    );

    blocTest<LoginCubit, AuthFormState>(
      'ignores taps while submitting',
      build: () => LoginCubit(login, session, credentials),
      seed: () => const AuthFormSubmittingState(),
      act: (cubit) => cubit.login(identifier: '0909', password: 'p'),
      expect: () => <AuthFormState>[],
    );
  });

  group('RegisterCubit', () {
    late MockRegisterUseCase register;

    setUp(() => register = MockRegisterUseCase());

    blocTest<RegisterCubit, AuthFormState>(
      'success marks the session with the role',
      setUp: () => when(
        () => register(
          fullName: any(named: 'fullName'),
          phone: any(named: 'phone'),
          password: any(named: 'password'),
          role: UserRole.customer,
        ),
      ).thenAnswer((_) async => const Ok<AppUser>(customerUser)),
      build: () => RegisterCubit(register, session, credentials),
      act: (cubit) => cubit.register(fullName: 'Mai', phone: '0901', password: 'p', role: UserRole.customer),
      expect: () => [const AuthFormSubmittingState(), const AuthFormSuccessState(UserRole.customer)],
      verify: (_) {
        verify(
          () => credentials.save(UserRole.customer, const RememberedCredentials(identifier: '0901', password: 'p')),
        ).called(1);
        verify(() => session.markAuthenticated(role: UserRole.customer)).called(1);
      },
    );

    blocTest<RegisterCubit, AuthFormState>(
      'failure is emitted',
      setUp: () => when(
        () => register(
          fullName: any(named: 'fullName'),
          phone: any(named: 'phone'),
          password: any(named: 'password'),
          role: any(named: 'role'),
        ),
      ).thenAnswer((_) async => const Err<AppUser>(_offline)),
      build: () => RegisterCubit(register, session, credentials),
      act: (cubit) => cubit.register(fullName: 'Mai', phone: '0901', password: 'p', role: UserRole.customer),
      expect: () => [const AuthFormSubmittingState(), const AuthFormFailureState(_offline)],
    );
  });

  group('LogoutCubit', () {
    late MockLogoutUseCase logout;

    setUp(() {
      logout = MockLogoutUseCase();
      when(() => logout()).thenAnswer((_) async {});
    });

    blocTest<LogoutCubit, LogoutState>(
      'revokes tokens then signs the session out',
      build: () => LogoutCubit(logout, session),
      act: (cubit) => cubit.logout(),
      expect: () => [const LogoutInProgressState(), const LogoutDoneState()],
      verify: (_) {
        verify(() => logout()).called(1);
        verify(() => session.signOut()).called(1);
      },
    );

    blocTest<LogoutCubit, LogoutState>(
      'only runs once',
      build: () => LogoutCubit(logout, session),
      seed: () => const LogoutInProgressState(),
      act: (cubit) => cubit.logout(),
      expect: () => <LogoutState>[],
    );
  });

  group('ProfileCubit', () {
    late MockGetProfileUseCase getProfile;
    late MockUpdateProfileUseCase updateProfile;

    setUp(() {
      getProfile = MockGetProfileUseCase();
      updateProfile = MockUpdateProfileUseCase();
    });

    blocTest<ProfileCubit, ProfileState>(
      'load emits the profile',
      setUp: () => when(() => getProfile()).thenAnswer((_) async => const Ok<UserProfile>(customerProfile)),
      build: () => ProfileCubit(getProfile, updateProfile),
      act: (cubit) => cubit.load(),
      expect: () => [const ProfileLoadingState(), const ProfileLoadedState(customerProfile)],
    );

    blocTest<ProfileCubit, ProfileState>(
      'load failure is emitted',
      setUp: () => when(() => getProfile()).thenAnswer((_) async => const Err<UserProfile>(_offline)),
      build: () => ProfileCubit(getProfile, updateProfile),
      act: (cubit) => cubit.load(),
      expect: () => [const ProfileLoadingState(), const ProfileLoadErrorState(_offline)],
    );

    final updated = customerProfile.copyWith(fullName: 'Nguyễn Thị Hương Mai');

    blocTest<ProfileCubit, ProfileState>(
      'save emits saving then saved with the server profile',
      setUp: () => when(() => updateProfile(any())).thenAnswer((_) async => Ok<UserProfile>(updated)),
      build: () => ProfileCubit(getProfile, updateProfile),
      seed: () => const ProfileLoadedState(customerProfile),
      act: (cubit) => cubit.save(const ProfileUpdate(fullName: 'Nguyễn Thị Hương Mai')),
      expect: () => [const ProfileSavingState(customerProfile), ProfileSavedState(updated)],
    );

    blocTest<ProfileCubit, ProfileState>(
      'save failure keeps the previous profile',
      setUp: () => when(() => updateProfile(any())).thenAnswer((_) async => const Err<UserProfile>(_offline)),
      build: () => ProfileCubit(getProfile, updateProfile),
      seed: () => const ProfileLoadedState(customerProfile),
      act: (cubit) => cubit.save(const ProfileUpdate(fullName: 'X')),
      expect: () => [const ProfileSavingState(customerProfile), const ProfileSaveErrorState(customerProfile, _offline)],
    );

    blocTest<ProfileCubit, ProfileState>(
      'save is ignored before the profile is loaded',
      build: () => ProfileCubit(getProfile, updateProfile),
      act: (cubit) => cubit.save(const ProfileUpdate(fullName: 'X')),
      expect: () => <ProfileState>[],
      verify: (_) => verifyNever(() => updateProfile(any())),
    );
  });
}
