import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vstech_home_services/core/network/api_endpoints.dart';
import 'package:vstech_home_services/core/network/api_response.dart';
import 'package:vstech_home_services/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:vstech_home_services/features/auth/data/models/auth_response.dart';
import 'package:vstech_home_services/features/auth/data/models/login_request.dart';
import 'package:vstech_home_services/features/auth/data/models/logout_request.dart';
import 'package:vstech_home_services/features/auth/data/models/register_request.dart';

import '../../../fixtures/fixture_reader.dart';
import '../../../helpers/mocks.dart';

void main() {
  late MockApiClient client;
  late AuthRemoteDataSource dataSource;

  /// Feeds the `data` of a fixture envelope through whatever decoder the datasource passes.
  void stubPost(String path, Map<String, dynamic>? envelope) {
    when(
      () => client.post<AuthResponse>(
        path,
        body: any(named: 'body'),
        authenticated: any(named: 'authenticated'),
        idempotent: any(named: 'idempotent'),
        decode: any(named: 'decode'),
      ),
    ).thenAnswer((invocation) async {
      final decode = invocation.namedArguments[#decode] as AuthResponse Function(Object?);
      final data = envelope?['data'];
      return ApiResponse<AuthResponse>(
        status: 200,
        message: '',
        data: data == null ? null : decode(data),
        errorCode: null,
        timestamp: null,
      );
    });
  }

  setUp(() {
    client = MockApiClient();
    dataSource = AuthRemoteDataSource(client);
  });

  test('login posts the request publicly and decodes AuthResponse', () async {
    stubPost(ApiEndpoints.authLogin, jsonFixture('auth/auth_success.json'));

    final result = await dataSource.login(const LoginRequest(identifier: '0901234567', password: 'Secret123'));

    expect(result.accessToken, 'access-1');
    expect(result.user.fullName, 'Nguyễn Thị Mai');
    expect(result.user.role, 'CUSTOMER');
    verify(
      () => client.post<AuthResponse>(
        ApiEndpoints.authLogin,
        body: {'identifier': '0901234567', 'password': 'Secret123'},
        authenticated: false,
        decode: any(named: 'decode'),
      ),
    ).called(1);
  });

  test('register sends role and is idempotent; returns null without a body', () async {
    stubPost(ApiEndpoints.authRegister, null);

    final result = await dataSource.register(
      const RegisterRequest(fullName: 'A', email: 'a@x.vn', phone: '0901', password: 'Secret123', role: 'WORKER'),
    );

    expect(result, isNull);
    verify(
      () => client.post<AuthResponse>(
        ApiEndpoints.authRegister,
        body: {'fullName': 'A', 'phone': '0901', 'password': 'Secret123', 'role': 'WORKER', 'email': 'a@x.vn'},
        authenticated: false,
        idempotent: true,
        decode: any(named: 'decode'),
      ),
    ).called(1);
  });

  test('user ids parse whether the backend sends a number or a UUID string', () {
    final numeric = AuthResponse.fromJson(jsonFixture('auth/auth_success.json')['data'] as Map<String, dynamic>);
    expect(numeric.user.id, '9');

    final uuid = AuthResponse.fromJson({
      'accessToken': 'a',
      'refreshToken': 'r',
      'user': {'id': '3f0c-uuid', 'role': 'WORKER'},
    });
    expect(uuid.user.id, '3f0c-uuid');
  });

  test('logout posts the refresh token', () async {
    when(
      () => client.post<Object?>(
        ApiEndpoints.authLogout,
        body: any(named: 'body'),
        authenticated: false,
        decode: any(named: 'decode'),
      ),
    ).thenAnswer(
      (_) async => const ApiResponse<Object?>(status: 200, message: '', data: null, errorCode: null, timestamp: null),
    );

    await dataSource.logout(const LogoutRequest(refreshToken: 'r'));

    verify(
      () => client.post<Object?>(
        ApiEndpoints.authLogout,
        body: {'refreshToken': 'r'},
        authenticated: false,
        decode: any(named: 'decode'),
      ),
    ).called(1);
  });
}
