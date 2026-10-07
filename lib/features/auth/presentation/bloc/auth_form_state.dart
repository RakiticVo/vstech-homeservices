import 'package:flutter/foundation.dart';
import 'package:vstech_home_services/core/error/failure.dart';
import 'package:vstech_home_services/core/session/user_role.dart';

/// Shared state for the login and register forms.
@immutable
sealed class AuthFormState {
  const AuthFormState();
}

final class AuthFormInitialState extends AuthFormState {
  const AuthFormInitialState();
}

final class AuthFormSubmittingState extends AuthFormState {
  const AuthFormSubmittingState();
}

/// Signed in; the session already carries [role]. The page navigates.
final class AuthFormSuccessState extends AuthFormState {
  const AuthFormSuccessState(this.role);

  final UserRole role;

  @override
  bool operator ==(Object other) => other is AuthFormSuccessState && other.role == role;

  @override
  int get hashCode => role.hashCode;
}

final class AuthFormFailureState extends AuthFormState {
  const AuthFormFailureState(this.failure);

  final Failure failure;

  @override
  bool operator ==(Object other) => other is AuthFormFailureState && other.failure == failure;

  @override
  int get hashCode => failure.hashCode;
}
