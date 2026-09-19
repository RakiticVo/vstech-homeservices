/// All API endpoint path constants. Feature modules add their own section here as they're
/// implemented (see the `api-module-integration` skill) — never inline a path literal in a
/// datasource. Base path and per-module paths must match `docs/reference/api/*.md` exactly.
abstract final class ApiEndpoints {
  static const String apiVersion = '/api/v1';

  // --- Auth & Profiles (docs/reference/api/01-auth-profiles.md) ---
  static const String authRegister = '$apiVersion/auth/register';
  static const String authLogin = '$apiVersion/auth/login';
  static const String authRefresh = '$apiVersion/auth/refresh';
  static const String authLogout = '$apiVersion/auth/logout';
  static const String profiles = '$apiVersion/profiles';

  // Remaining modules (bookings, categories-dispatch, wallet-payments, withdrawals, chat,
  // notifications, location-tracking, voip) are added here when their feature is scaffolded —
  // see docs/reference/api/ for the exact contract before adding a constant.
}
