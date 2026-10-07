import 'package:injectable/injectable.dart';
import 'package:vstech_home_services/core/network/api_client.dart';
import 'package:vstech_home_services/core/network/api_endpoints.dart';
import 'package:vstech_home_services/features/auth/data/models/auth_response.dart';
import 'package:vstech_home_services/features/auth/data/models/login_request.dart';
import 'package:vstech_home_services/features/auth/data/models/logout_request.dart';
import 'package:vstech_home_services/features/auth/data/models/register_request.dart';

/// `/api/v1/auth/*`. All calls are public (no bearer token).
@injectable
class AuthRemoteDataSource {
  const AuthRemoteDataSource(this._client);

  final ApiClient _client;

  Future<AuthResponse> login(LoginRequest request) async {
    final response = await _client.post(
      ApiEndpoints.authLogin,
      body: request.toJson(),
      authenticated: false,
      decode: _decodeAuth,
    );
    return response.requireData;
  }

  /// Returns null when the server answers 201 without an `AuthResponse` body — the OpenAPI spec
  /// declares no body while the foundation doc says tokens are returned; both are handled.
  Future<AuthResponse?> register(RegisterRequest request) async {
    final response = await _client.post(
      ApiEndpoints.authRegister,
      body: request.toJson(),
      authenticated: false,
      idempotent: true,
      decode: _decodeAuth,
    );
    return response.data;
  }

  Future<void> logout(LogoutRequest request) => _client.post<Object?>(
    ApiEndpoints.authLogout,
    body: request.toJson(),
    authenticated: false,
    decode: (json) => json,
  );

  static AuthResponse _decodeAuth(Object? json) => AuthResponse.fromJson(json! as Map<String, dynamic>);
}
