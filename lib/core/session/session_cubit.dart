import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:vstech_home_services/core/network/auth_token_store.dart';

part 'session_state.dart';

/// App-wide authentication status. The only app-level Cubit: GoRouter's `redirect` listens to it,
/// `ApiClient` calls [expire] when a token refresh fails, and the auth feature calls
/// [markAuthenticated] / [signOut] after login/logout.
@lazySingleton
class SessionCubit extends Cubit<SessionState> {
  SessionCubit(this._tokenStore) : super(const SessionInitialState());

  final AuthTokenStore _tokenStore;

  /// Resolves the initial state from secure storage. A stored refresh token is enough — an expired
  /// access token is renewed transparently on the first request.
  Future<void> restore() async {
    final refreshToken = await _tokenStore.readRefreshToken();
    emit(refreshToken == null ? const SessionUnauthenticatedState() : const SessionAuthenticatedState());
  }

  void markAuthenticated() => emit(const SessionAuthenticatedState());

  /// Called by `ApiClient` after tokens were cleared because refresh failed.
  void expire() => emit(const SessionUnauthenticatedState(expired: true));

  Future<void> signOut() async {
    await _tokenStore.clear();
    emit(const SessionUnauthenticatedState());
  }
}
