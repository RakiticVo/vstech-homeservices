import 'package:flutter/material.dart';

import 'package:vstech_home_services/app.dart';
import 'package:vstech_home_services/core/di/injection.dart';
import 'package:vstech_home_services/core/router/app_router.dart';
import 'package:vstech_home_services/core/session/session_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  final session = getIt<SessionCubit>();
  await session.restore();
  runApp(VstechHomeServicesApp(router: createAppRouter(session: session)));
}
