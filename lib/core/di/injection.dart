import 'package:get_it/get_it.dart';

final GetIt getIt = GetIt.instance;

/// Registers all dependencies. Currently empty — as feature modules are scaffolded, either
/// register them manually here or switch to `injectable`'s `@InjectableInit` generator once
/// there are enough `@injectable`/`@singleton` annotated classes to justify codegen
/// (see `flutter-feature-scaffold` skill).
Future<void> configureDependencies() async {}
