/// Build-time environment config, injected via `--dart-define` / `--dart-define-from-file`.
///
/// Local values live in `env/dev.json` (gitignored — copy from `env/example.json`):
/// `flutter run --dart-define-from-file=env/dev.json`. Without a file the app falls back to
/// the UAT backend and empty secrets.
abstract final class AppEnv {
  static const String apiBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'https://homeservice-uat.vitinhkimhung.com',
  );

  /// WebSocket origin (`/ws/chat/{roomId}`, `/ws/tracking`, ...). Derived from [apiBaseUrl]
  /// unless `WS_BASE_URL` is passed explicitly.
  static String get wsBaseUrl {
    const override = String.fromEnvironment('WS_BASE_URL');
    if (override.isNotEmpty) return override;
    return apiBaseUrl.replaceFirst(RegExp('^http'), 'ws');
  }

  /// Google Maps key for the tracking map (not wired natively yet — see README).
  static const String googleMapsApiKey = String.fromEnvironment(
    'GOOGLE_MAPS_API_KEY',
  );

  /// UAT test accounts supplied by the backend team — for local manual testing only.
  static const String testCustomerPhone = String.fromEnvironment(
    'TEST_CUSTOMER_PHONE',
  );
  static const String testCustomerPassword = String.fromEnvironment(
    'TEST_CUSTOMER_PASSWORD',
  );
  static const String testWorkerPhone = String.fromEnvironment(
    'TEST_WORKER_PHONE',
  );
  static const String testWorkerPassword = String.fromEnvironment(
    'TEST_WORKER_PASSWORD',
  );
}
