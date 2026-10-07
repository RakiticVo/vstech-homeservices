import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:vstech_home_services/core/session/session_cubit.dart';
import 'package:vstech_home_services/features/auth/domain/usecases/logout_use_case.dart';

part 'logout_state.dart';

/// Signs out. Never fails from the user's point of view — local tokens are always cleared.
@injectable
class LogoutCubit extends Cubit<LogoutState> {
  LogoutCubit(this._logout, this._session) : super(const LogoutInitialState());

  final LogoutUseCase _logout;
  final SessionCubit _session;

  Future<void> logout() async {
    if (state is! LogoutInitialState) return;
    emit(const LogoutInProgressState());
    await _logout();
    await _session.signOut();
    emit(const LogoutDoneState());
  }
}
