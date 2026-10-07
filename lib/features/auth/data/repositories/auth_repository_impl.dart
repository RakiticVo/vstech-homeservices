import 'package:injectable/injectable.dart';
import 'package:vstech_home_services/core/error/failure.dart';
import 'package:vstech_home_services/core/error/result.dart';
import 'package:vstech_home_services/core/network/auth_token_store.dart';
import 'package:vstech_home_services/core/network/network_exception.dart';
import 'package:vstech_home_services/core/session/user_role.dart';
import 'package:vstech_home_services/core/utils/logger.dart';
import 'package:vstech_home_services/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:vstech_home_services/features/auth/data/models/auth_response.dart';
import 'package:vstech_home_services/features/auth/data/models/login_request.dart';
import 'package:vstech_home_services/features/auth/data/models/logout_request.dart';
import 'package:vstech_home_services/features/auth/data/models/register_request.dart';
import 'package:vstech_home_services/features/auth/domain/entities/app_user.dart';
import 'package:vstech_home_services/features/auth/domain/repositories/auth_repository.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl(this._remote, this._tokenStore);

  final AuthRemoteDataSource _remote;
  final AuthTokenStore _tokenStore;

  @override
  Future<Result<AppUser>> login({required String identifier, required String password}) =>
      Result.guard(() async {
        final auth = await _remote.login(LoginRequest(identifier: identifier, password: password));
        return await _startSession(auth);
      });

  @override
  Future<Result<AppUser>> register({
    required String fullName,
    required String phone,
    required String password,
    required UserRole role,
  }) => Result.guard(() async {
    final auth = await _remote.register(
      RegisterRequest(fullName: fullName, phone: phone, password: password, role: role.apiValue),
    );
    return await _startSession(auth ?? await _remote.login(LoginRequest(identifier: phone, password: password)));
  });

  @override
  Future<void> logout() async {
    final refreshToken = await _tokenStore.readRefreshToken();
    if (refreshToken != null) {
      try {
        await _remote.logout(LogoutRequest(refreshToken: refreshToken));
      } on NetworkException catch (e) {
        // Local sign-out must always succeed; the server token simply expires on its own.
        appLogger.w('Logout request failed', error: e);
      }
    }
    await _tokenStore.clear();
  }

  Future<AppUser> _startSession(AuthResponse auth) async {
    final user = AppUser(
      id: auth.user.id,
      role: UserRole.fromApi(auth.user.role),
      fullName: auth.user.fullName,
      email: auth.user.email,
      phoneNumber: auth.user.phoneNumber,
      avatarUrl: auth.user.avatarUrl,
    );
    if (user.role == UserRole.unsupported) throw const AppException(AppException.unsupportedRole);
    await _tokenStore.saveTokens(accessToken: auth.accessToken, refreshToken: auth.refreshToken);
    return user;
  }
}
