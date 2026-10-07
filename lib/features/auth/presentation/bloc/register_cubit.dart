import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:vstech_home_services/core/error/result.dart';
import 'package:vstech_home_services/core/session/session_cubit.dart';
import 'package:vstech_home_services/features/auth/domain/entities/remembered_credentials.dart';
import 'package:vstech_home_services/features/auth/domain/repositories/credentials_repository.dart';
import 'package:vstech_home_services/features/auth/domain/usecases/register_use_case.dart';
import 'package:vstech_home_services/features/auth/presentation/bloc/auth_form_state.dart';

export 'package:vstech_home_services/features/auth/presentation/bloc/auth_form_state.dart';

/// Creates the account; the page then shows the (simulated) OTP step before entering the app.
@injectable
class RegisterCubit extends Cubit<AuthFormState> {
  RegisterCubit(this._register, this._session, this._credentials) : super(const AuthFormInitialState());

  final RegisterUseCase _register;
  final SessionCubit _session;
  final CredentialsRepository _credentials;

  Future<void> register({
    required String fullName,
    required String phone,
    required String password,
    required UserRole role,
  }) async {
    if (state is AuthFormSubmittingState) return;
    emit(const AuthFormSubmittingState());
    switch (await _register(fullName: fullName, phone: phone, password: password, role: role)) {
      case Ok(:final value):
        // Remember the new account so the login form is prefilled after the first logout.
        await _credentials.save(value.role, RememberedCredentials(identifier: phone.trim(), password: password));
        _session.markAuthenticated(role: value.role);
        emit(AuthFormSuccessState(value.role));
      case Err(:final failure):
        emit(AuthFormFailureState(failure));
    }
  }
}
