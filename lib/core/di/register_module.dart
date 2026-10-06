import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:vstech_home_services/app.dart';
import 'package:vstech_home_services/core/config/app_env.dart';
import 'package:vstech_home_services/core/network/api_client.dart';
import 'package:vstech_home_services/core/network/auth_token_store.dart';
import 'package:vstech_home_services/core/session/session_cubit.dart';

/// Third-party / configured instances that can't carry `@injectable` annotations themselves.
@module
abstract class RegisterModule {
  @lazySingleton
  FlutterSecureStorage get secureStorage => const FlutterSecureStorage();

  @lazySingleton
  ApiClient apiClient(AuthTokenStore tokenStore, SessionCubit session) => ApiClient(
    baseUrl: AppEnv.apiBaseUrl,
    tokenStore: tokenStore,
    onSessionExpired: session.expire,
    languageCode: () => appLocaleNotifier.value.languageCode,
  );
}
