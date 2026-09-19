/// Abstraction the network layer depends on to read/write auth tokens, implemented by the
/// `auth` feature (backed by `flutter_secure_storage` — see CLAUDE.md, tokens never go in
/// SharedPreferences). Kept here to avoid `core/network` depending on `features/auth`.
abstract class AuthTokenStore {
  Future<String?> readAccessToken();

  Future<String?> readRefreshToken();

  Future<void> saveTokens({required String accessToken, required String refreshToken});

  Future<void> clear();
}
