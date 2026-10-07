import 'package:flutter_test/flutter_test.dart';
import 'package:vstech_home_services/core/router/app_router.dart';
import 'package:vstech_home_services/core/router/app_routes.dart';
import 'package:vstech_home_services/core/session/session_cubit.dart';

void main() {
  group('signed out', () {
    const states = [SessionUnauthenticatedState(), SessionUnauthenticatedState(expired: true)];

    test('protected routes go to login', () {
      for (final state in states) {
        expect(sessionRedirect(state, AppRoutes.customerHome), AppRoutes.login);
        expect(sessionRedirect(state, AppRoutes.workerWallet), AppRoutes.login);
        expect(sessionRedirect(state, AppRoutes.chat), AppRoutes.login);
      }
    });

    test('public routes stay reachable', () {
      for (final state in states) {
        for (final location in [
          AppRoutes.splash,
          AppRoutes.onboarding,
          AppRoutes.roleGateway,
          AppRoutes.login,
          AppRoutes.register,
          AppRoutes.forgotPassword,
        ]) {
          expect(sessionRedirect(state, location), isNull, reason: location);
        }
      }
    });
  });

  group('signed in', () {
    const customer = SessionAuthenticatedState(role: UserRole.customer);
    const worker = SessionAuthenticatedState(role: UserRole.worker);

    test('onboarding and other auth screens send the user to their home', () {
      expect(sessionRedirect(worker, AppRoutes.onboarding), AppRoutes.workerDashboard);
      expect(sessionRedirect(customer, AppRoutes.roleGateway), AppRoutes.customerHome);
      expect(sessionRedirect(customer, AppRoutes.forgotPassword), AppRoutes.customerHome);
    });

    test('splash, login and register are left alone so they can navigate themselves', () {
      for (final location in [AppRoutes.splash, AppRoutes.login, AppRoutes.register]) {
        expect(sessionRedirect(customer, location), isNull, reason: location);
      }
    });

    test('own and shared routes are allowed', () {
      expect(sessionRedirect(customer, AppRoutes.customerOrders), isNull);
      expect(sessionRedirect(worker, AppRoutes.workerWallet), isNull);
      expect(sessionRedirect(worker, AppRoutes.chat), isNull);
    });

    test("the other role's routes go home", () {
      expect(sessionRedirect(customer, AppRoutes.workerWallet), AppRoutes.customerHome);
      expect(sessionRedirect(worker, AppRoutes.customerHome), AppRoutes.workerDashboard);
    });

    test('nothing is redirected while the role is unknown', () {
      expect(sessionRedirect(const SessionAuthenticatedState(), AppRoutes.login), isNull);
      expect(sessionRedirect(const SessionAuthenticatedState(), AppRoutes.workerWallet), isNull);
    });
  });

  test('initial state never redirects', () {
    expect(sessionRedirect(const SessionInitialState(), AppRoutes.customerHome), isNull);
  });
}
