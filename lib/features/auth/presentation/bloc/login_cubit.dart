import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:vstech_home_services/core/error/result.dart';
import 'package:vstech_home_services/core/session/session_cubit.dart';
import 'package:vstech_home_services/features/auth/domain/entities/remembered_credentials.dart';
import 'package:vstech_home_services/features/auth/domain/repositories/credentials_repository.dart';
import 'package:vstech_home_services/features/auth/domain/usecases/login_use_case.dart';
import 'package:vstech_home_services/features/auth/presentation/bloc/auth_form_state.dart';

export 'package:vstech_home_services/features/auth/presentation/bloc/auth_form_state.dart';

@injectable
class LoginCubit extends Cubit<AuthFormState> {
  LoginCubit(this._login, this._session, this._credentials) : super(const AuthFormInitialState());

  final LoginUseCase _login;
  final SessionCubit _session;
  final CredentialsRepository _credentials;

  /// Loads the remembered phone/password for the [role] tab currently shown.
  Future<void> prefill(UserRole role) async {
    emit(AuthFormPrefilledState(await _credentials.read(role)));
  }

  /// Signs in. With [remember] the credentials are kept (per the account's role) for the next
  /// login; without it any previously remembered ones are forgotten.
  Future<void> login({required String identifier, required String password, bool remember = true}) async {
    if (state is AuthFormSubmittingState) return;
    emit(const AuthFormSubmittingState());
    switch (await _login(identifier: identifier, password: password)) {
      case Ok(:final value):
        if (remember) {
          await _credentials.save(value.role, RememberedCredentials(identifier: identifier.trim(), password: password));
        } else {
          await _credentials.clear(value.role);
        }
        _session.markAuthenticated(role: value.role);
        emit(AuthFormSuccessState(value.role));
      case Err(:final failure):
        emit(AuthFormFailureState(failure));
    }
  }
}
