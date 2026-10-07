import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:vstech_home_services/core/session/user_role.dart';
import 'package:vstech_home_services/core/utils/logger.dart';
import 'package:vstech_home_services/features/auth/domain/entities/remembered_credentials.dart';
import 'package:vstech_home_services/features/auth/domain/repositories/credentials_repository.dart';

/// Stores remembered credentials in the iOS Keychain / Android Keystore — never in
/// SharedPreferences or Hive, since it includes the password.
@LazySingleton(as: CredentialsRepository)
class SecureCredentialsRepository implements CredentialsRepository {
  const SecureCredentialsRepository(this._storage);

  final FlutterSecureStorage _storage;

  static String keyFor(UserRole role) => 'auth.remembered.${role.name}';

  @override
  Future<RememberedCredentials?> read(UserRole role) async {
    final raw = await _storage.read(key: keyFor(role));
    if (raw == null) return null;
    try {
      final json = jsonDecode(raw) as Map<String, dynamic>;
      return RememberedCredentials(identifier: json['identifier'] as String, password: json['password'] as String);
    } on Object catch (e) {
      appLogger.w('Discarding unreadable remembered credentials', error: e);
      await clear(role);
      return null;
    }
  }

  @override
  Future<void> save(UserRole role, RememberedCredentials credentials) => _storage.write(
    key: keyFor(role),
    value: jsonEncode({'identifier': credentials.identifier, 'password': credentials.password}),
  );

  @override
  Future<void> clear(UserRole role) => _storage.delete(key: keyFor(role));
}
