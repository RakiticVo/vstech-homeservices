import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:vstech_home_services/core/error/result.dart';
import 'package:vstech_home_services/core/session/session_cubit.dart';
import 'package:vstech_home_services/features/auth/domain/usecases/register_use_case.dart';
import 'package:vstech_home_services/features/auth/presentation/bloc/auth_form_state.dart';

export 'package:vstech_home_services/features/auth/presentation/bloc/auth_form_state.dart';

@injectable
class RegisterCubit extends Cubit<AuthFormState> {
  RegisterCubit(this._register, this._session) : super(const AuthFormInitialState());

  final RegisterUseCase _register;
  final SessionCubit _session;

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
        _session.markAuthenticated(role: value.role);
        emit(AuthFormSuccessState(value.role));
      case Err(:final failure):
        emit(AuthFormFailureState(failure));
    }
  }
}
