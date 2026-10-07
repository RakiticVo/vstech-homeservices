import 'package:vstech_home_services/core/error/result.dart';
import 'package:vstech_home_services/core/session/user_role.dart';
import 'package:vstech_home_services/features/auth/domain/entities/app_user.dart';

abstract interface class AuthRepository {
  /// Signs in and stores the tokens.
  Future<Result<AppUser>> login({required String identifier, required String password});

  /// Creates the account and signs in (tokens stored).
  Future<Result<AppUser>> register({
    required String fullName,
    required String email,
    required String phone,
    required String password,
    required UserRole role,
  });

  /// Revokes the refresh token server-side (best effort) and always clears local tokens.
  Future<void> logout();
}
