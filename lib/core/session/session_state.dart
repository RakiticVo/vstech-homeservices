part of 'session_cubit.dart';

@immutable
sealed class SessionState {
  const SessionState();
}

/// Session not resolved yet (app just started, secure storage not read).
final class SessionInitialState extends SessionState {
  const SessionInitialState();
}

final class SessionAuthenticatedState extends SessionState {
  const SessionAuthenticatedState();
}

/// [expired] is true when the user was signed out by a failed token refresh, so the router
/// sends them back to the login screen.
final class SessionUnauthenticatedState extends SessionState {
  const SessionUnauthenticatedState({this.expired = false});

  final bool expired;

  @override
  bool operator ==(Object other) => other is SessionUnauthenticatedState && other.expired == expired;

  @override
  int get hashCode => expired.hashCode;
}
