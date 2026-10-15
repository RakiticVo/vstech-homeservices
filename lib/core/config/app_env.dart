import 'package:flutter/foundation.dart';

/// Build-time environment config, injected via `--dart-define` / `--dart-define-from-file`.
///
/// Values live in `.env.development` / `.env.production` at the project root (gitignored —
/// copy from the matching `*.example`), e.g. `flutter run --dart-define-from-file=.env.development`.
/// Without a file the app runs as development against the UAT backend with empty secrets.
abstract final class AppEnv {
  static const String _uatBaseUrl = 'https://homeservice-uat.vitinhkimhung.com';
  static const String _rawApiBaseUrl = String.fromEnvironment('API_BASE_URL');

  /// `development` (default) or `production` — from `APP_ENV`.
  static const String name = String.fromEnvironment(
    'APP_ENV',
    defaultValue: 'development',
  );

  static bool get isProduction => name == 'production';

  /// True when `API_BASE_URL` is empty, so [apiBaseUrl] fell back to UAT.
  static bool get isApiBaseUrlMissing => _rawApiBaseUrl.isEmpty;

  /// REST origin from `API_BASE_URL`; falls back to UAT when the variable is empty.
  static String get apiBaseUrl =>
      _rawApiBaseUrl.isEmpty ? _uatBaseUrl : _rawApiBaseUrl;

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

  /// In-app debug console (floating bug button → network / logs / info) for testers — from
  /// `DEBUG_CONSOLE`. On in development/UAT files, off in production. When on, logging also runs in
  /// release builds so a tester's installed build can show what happened.
  static const bool debugConsoleEnabled = bool.fromEnvironment('DEBUG_CONSOLE');

  /// Whether logs are produced at all: always in debug/profile, in release only with the console.
  static bool get loggingEnabled => !kReleaseMode || debugConsoleEnabled;
}
