import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:vstech_home_services/core/error/failure.dart';
import 'package:vstech_home_services/core/error/result.dart';
import 'package:vstech_home_services/core/session/session_cubit.dart';
import 'package:vstech_home_services/features/auth/domain/usecases/get_profile_use_case.dart';

part 'splash_state.dart';

/// Decides where the app opens: onboarding when signed out, otherwise fetches the profile to learn
/// the role (customer → home, worker → dashboard).
@injectable
class SplashCubit extends Cubit<SplashState> {
  SplashCubit(this._session, this._getProfile) : super(const SplashInitialState());

  final SessionCubit _session;
  final GetProfileUseCase _getProfile;

  Future<void> resolve() async {
    emit(const SplashLoadingState());
    if (_session.state is! SessionAuthenticatedState) {
      emit(const SplashResolvedState(SplashDestination.onboarding));
      return;
    }
    switch (await _getProfile()) {
      case Ok(:final value) when value.role == UserRole.unsupported:
        await _session.signOut();
        emit(const SplashResolvedState(SplashDestination.onboarding));
      case Ok(:final value):
        _session.markAuthenticated(role: value.role);
        emit(
          SplashResolvedState(
            value.role == UserRole.worker ? SplashDestination.workerHome : SplashDestination.customerHome,
          ),
        );
      case Err(:final failure) when failure.isUnauthorized:
        // ApiClient already cleared the tokens and expired the session.
        emit(const SplashResolvedState(SplashDestination.onboarding));
      case Err(:final failure):
        emit(SplashErrorState(failure));
    }
  }
}
