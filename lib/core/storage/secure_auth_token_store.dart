import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:vstech_home_services/core/network/auth_token_store.dart';

/// [AuthTokenStore] backed by the iOS Keychain / Android Keystore. Tokens never go to
/// SharedPreferences or Hive (CLAUDE.md API Contract Rules).
@LazySingleton(as: AuthTokenStore)
class SecureAuthTokenStore implements AuthTokenStore {
  SecureAuthTokenStore(this._storage);

  static const String accessTokenKey = 'auth.access_token';
  static const String refreshTokenKey = 'auth.refresh_token';

  final FlutterSecureStorage _storage;

  @override
  Future<String?> readAccessToken() => _storage.read(key: accessTokenKey);

  @override
  Future<String?> readRefreshToken() => _storage.read(key: refreshTokenKey);

  @override
  Future<void> saveTokens({required String accessToken, required String refreshToken}) async {
    await _storage.write(key: accessTokenKey, value: accessToken);
    await _storage.write(key: refreshTokenKey, value: refreshToken);
  }

  @override
  Future<void> clear() async {
    await _storage.delete(key: accessTokenKey);
    await _storage.delete(key: refreshTokenKey);
  }
}
