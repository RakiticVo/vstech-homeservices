import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:vstech_home_services/core/error/result.dart';
import 'package:vstech_home_services/core/session/session_cubit.dart';
import 'package:vstech_home_services/features/auth/domain/usecases/login_use_case.dart';
import 'package:vstech_home_services/features/auth/presentation/bloc/auth_form_state.dart';

export 'package:vstech_home_services/features/auth/presentation/bloc/auth_form_state.dart';

@injectable
class LoginCubit extends Cubit<AuthFormState> {
  LoginCubit(this._login, this._session) : super(const AuthFormInitialState());

  final LoginUseCase _login;
  final SessionCubit _session;

  Future<void> login({required String identifier, required String password}) async {
    if (state is AuthFormSubmittingState) return;
    emit(const AuthFormSubmittingState());
    switch (await _login(identifier: identifier, password: password)) {
      case Ok(:final value):
        _session.markAuthenticated(role: value.role);
        emit(AuthFormSuccessState(value.role));
      case Err(:final failure):
        emit(AuthFormFailureState(failure));
    }
  }
}
