part of 'session_cubit.dart';

@immutable
sealed class SessionState {
  const SessionState();
}

/// Session not resolved yet (app just started, secure storage not read).
final class SessionInitialState extends SessionState {
  const SessionInitialState();
}

/// Tokens are stored. [role] is null until the profile has been fetched (splash resolves it).
final class SessionAuthenticatedState extends SessionState {
  const SessionAuthenticatedState({this.role});

  final UserRole? role;

  @override
  bool operator ==(Object other) => other is SessionAuthenticatedState && other.role == role;

  @override
  int get hashCode => role.hashCode;
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
