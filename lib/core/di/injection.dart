import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:vstech_home_services/core/di/injection.config.dart';

final GetIt getIt = GetIt.instance;

/// Registers all dependencies. Annotate classes with `@injectable` / `@lazySingleton` (or add a
/// provider to `RegisterModule`) and run
/// `dart run build_runner build --delete-conflicting-outputs` to regenerate `injection.config.dart`.
@InjectableInit()
Future<void> configureDependencies() async => getIt.init();
