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
  if (!kReleaseMode) Bloc.observer = const AppBlocObserver();
  await configureDependencies();
  final session = getIt<SessionCubit>();
  await session.restore();
  appLogger.i('App started · API ${AppEnv.apiBaseUrl} · session ${session.state.runtimeType}');
  runApp(VstechHomeServicesApp(router: createAppRouter(session: session)));
}
