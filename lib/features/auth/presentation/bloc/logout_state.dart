part of 'logout_cubit.dart';

@immutable
sealed class LogoutState {
  const LogoutState();
}

final class LogoutInitialState extends LogoutState {
  const LogoutInitialState();
}

final class LogoutInProgressState extends LogoutState {
  const LogoutInProgressState();
}

final class LogoutDoneState extends LogoutState {
  const LogoutDoneState();
}
