import 'package:flutter_test/flutter_test.dart';
import 'package:vstech_home_services/core/router/app_router.dart';
import 'package:vstech_home_services/core/router/app_routes.dart';
import 'package:vstech_home_services/core/session/session_cubit.dart';

void main() {
  const expired = SessionUnauthenticatedState(expired: true);

  test('expired session on a protected route goes to login', () {
    expect(sessionRedirect(expired, AppRoutes.customerHome), AppRoutes.login);
    expect(sessionRedirect(expired, AppRoutes.workerWallet), AppRoutes.login);
  });

  test('public routes stay reachable after expiry', () {
    for (final location in [AppRoutes.splash, AppRoutes.onboarding, AppRoutes.login, AppRoutes.register]) {
      expect(sessionRedirect(expired, location), isNull);
    }
  });

  test('no redirect for other session states', () {
    expect(sessionRedirect(const SessionAuthenticatedState(), AppRoutes.customerHome), isNull);
    expect(sessionRedirect(const SessionInitialState(), AppRoutes.customerHome), isNull);
    expect(sessionRedirect(const SessionUnauthenticatedState(), AppRoutes.customerHome), isNull);
  });
}
