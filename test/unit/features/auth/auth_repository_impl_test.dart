import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vstech_home_services/core/error/failure.dart';
import 'package:vstech_home_services/core/error/result.dart';
import 'package:vstech_home_services/core/network/network_exception.dart';
import 'package:vstech_home_services/core/session/user_role.dart';
import 'package:vstech_home_services/features/auth/data/models/auth_response.dart';
import 'package:vstech_home_services/features/auth/data/models/login_request.dart';
import 'package:vstech_home_services/features/auth/data/models/logout_request.dart';
import 'package:vstech_home_services/features/auth/data/models/register_request.dart';
import 'package:vstech_home_services/features/auth/data/models/user_info_response.dart';
import 'package:vstech_home_services/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:vstech_home_services/features/auth/domain/entities/app_user.dart';

import '../../../helpers/mocks.dart';

AuthResponse _auth(String role) => AuthResponse(
  accessToken: 'a',
  refreshToken: 'r',
  user: UserInfoResponse(id: 9, fullName: 'Mai', role: role),
);

void main() {
  late MockAuthRemoteDataSource remote;
  late MockAuthTokenStore tokenStore;
  late AuthRepositoryImpl repository;

  setUpAll(() {
    registerFallbackValue(const LoginRequest(identifier: '', password: ''));
    registerFallbackValue(const RegisterRequest(fullName: '', phone: '', password: '', role: ''));
    registerFallbackValue(const LogoutRequest(refreshToken: ''));
  });

  setUp(() {
    remote = MockAuthRemoteDataSource();
    tokenStore = MockAuthTokenStore();
    repository = AuthRepositoryImpl(remote, tokenStore);
    when(
      () => tokenStore.saveTokens(
        accessToken: any(named: 'accessToken'),
        refreshToken: any(named: 'refreshToken'),
      ),
    ).thenAnswer((_) async {});
    when(() => tokenStore.clear()).thenAnswer((_) async {});
  });

  group('login', () {
    test('stores tokens and returns the user with a mapped role', () async {
      when(() => remote.login(any())).thenAnswer((_) async => _auth('WORKER'));

      final result = await repository.login(identifier: '0909', password: 'p');

      expect(result, isA<Ok<AppUser>>().having((r) => r.value.role, 'role', UserRole.worker));
      verify(() => tokenStore.saveTokens(accessToken: 'a', refreshToken: 'r')).called(1);
    });

    test('rejects roles the app does not serve without storing tokens', () async {
      when(() => remote.login(any())).thenAnswer((_) async => _auth('ADMIN'));

      final result = await repository.login(identifier: 'admin@x.vn', password: 'p');

      expect(result, isA<Err<AppUser>>().having((r) => r.failure.errorCode, 'errorCode', AppException.unsupportedRole));
      verifyNever(
        () => tokenStore.saveTokens(
          accessToken: any(named: 'accessToken'),
          refreshToken: any(named: 'refreshToken'),
        ),
      );
    });

    test('maps API errors to a Failure', () async {
      when(() => remote.login(any()))
          .thenThrow(const NetworkException(kind: NetworkErrorKind.server, errorCode: 'HS-401-0002', statusCode: 401));

      final result = await repository.login(identifier: '0909', password: 'wrong');

      expect(result, isA<Err<AppUser>>().having((r) => r.failure.errorCode, 'errorCode', 'HS-401-0002'));
    });
  });

  group('register', () {
    test('uses the tokens returned by register', () async {
      when(() => remote.register(any())).thenAnswer((_) async => _auth('CUSTOMER'));

      final result = await repository.register(fullName: 'Mai', phone: '0901', password: 'p', role: UserRole.customer);

      expect(result, isA<Ok<AppUser>>());
      verify(
        () => remote.register(const RegisterRequest(fullName: 'Mai', phone: '0901', password: 'p', role: 'CUSTOMER')),
      ).called(1);
      verifyNever(() => remote.login(any()));
    });

    test('falls back to login when register returns no body', () async {
      when(() => remote.register(any())).thenAnswer((_) async => null);
      when(() => remote.login(any())).thenAnswer((_) async => _auth('WORKER'));

      final result = await repository.register(fullName: 'Hùng', phone: '0909', password: 'p', role: UserRole.worker);

      expect(result, isA<Ok<AppUser>>().having((r) => r.value.role, 'role', UserRole.worker));
      verify(() => remote.login(const LoginRequest(identifier: '0909', password: 'p'))).called(1);
    });
  });

  group('logout', () {
    test('revokes the refresh token and clears local tokens', () async {
      when(() => tokenStore.readRefreshToken()).thenAnswer((_) async => 'r');
      when(() => remote.logout(any())).thenAnswer((_) async {});

      await repository.logout();

      verify(() => remote.logout(const LogoutRequest(refreshToken: 'r'))).called(1);
      verify(() => tokenStore.clear()).called(1);
    });

    test('still clears local tokens when the request fails', () async {
      when(() => tokenStore.readRefreshToken()).thenAnswer((_) async => 'r');
      when(() => remote.logout(any())).thenThrow(const NetworkException(kind: NetworkErrorKind.noConnection));

      await repository.logout();

      verify(() => tokenStore.clear()).called(1);
    });
  });
}
