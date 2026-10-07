import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vstech_home_services/core/utils/logger.dart';

/// Logs every Cubit/BLoC state change on [blocLogger]. Only state *types* are printed — never the
/// state contents, which can hold personal data (remembered credentials, profile fields).
class AppBlocObserver extends BlocObserver {
  const AppBlocObserver();

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    blocLogger.d('${bloc.runtimeType}: ${change.currentState.runtimeType} → ${change.nextState.runtimeType}');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    blocLogger.e('${bloc.runtimeType} threw', error: error, stackTrace: stackTrace);
    super.onError(bloc, error, stackTrace);
  }
}
