import 'package:flutter/material.dart';

import 'package:vstech_home_services/app.dart';
import 'package:vstech_home_services/core/di/injection.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(const VstechHomeServicesApp());
}
