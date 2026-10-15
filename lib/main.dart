import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:vstech_home_services/app.dart';
import 'package:vstech_home_services/core/config/app_env.dart';
import 'package:vstech_home_services/core/di/injection.dart';
import 'package:vstech_home_services/core/router/app_router.dart';
import 'package:vstech_home_services/core/session/session_cubit.dart';
import 'package:vstech_home_services/core/utils/app_bloc_observer.dart';
import 'package:vstech_home_services/core/utils/logger.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (AppEnv.loggingEnabled) {
    Bloc.observer = const AppBlocObserver();
    // Uncaught errors also reach the debug console (Crashlytics is not wired yet).
    final presentError = FlutterError.onError;
    FlutterError.onError = (details) {
      appLogger.e(
        'Flutter error: ${details.exceptionAsString()}',
        error: details.exception,
        stackTrace: details.stack,
      );
      presentError?.call(details);
    };
    PlatformDispatcher.instance.onError = (error, stack) {
      appLogger.e('Uncaught error', error: error, stackTrace: stack);
      return false;
    };
  }
  await configureDependencies();
  final session = getIt<SessionCubit>();
  await session.restore();
  if (AppEnv.isProduction && AppEnv.isApiBaseUrlMissing) {
    appLogger.w(
      'APP_ENV=production but API_BASE_URL is empty — falling back to UAT',
    );
  }
  appLogger.i(
    'App started · env ${AppEnv.name} · API ${AppEnv.apiBaseUrl} · session ${session.state.runtimeType}',
  );
  runApp(VstechHomeServicesApp(router: createAppRouter(session: session)));
}
