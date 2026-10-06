/// Build-time environment config. Override per build with
/// `flutter run --dart-define=API_BASE_URL=https://...` — defaults to the UAT backend.
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
}
