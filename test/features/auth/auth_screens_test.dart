import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:vstech_home_services/core/router/app_routes.dart';
import 'package:vstech_home_services/core/theme/app_theme.dart';
import 'package:vstech_home_services/features/auth/presentation/pages/forgot_password_page.dart';
import 'package:vstech_home_services/features/auth/presentation/pages/login_page.dart';
import 'package:vstech_home_services/features/auth/presentation/pages/otp_verification_page.dart';
import 'package:vstech_home_services/features/auth/presentation/pages/register_page.dart';
import 'package:vstech_home_services/features/auth/presentation/pages/reset_password_page.dart';
import 'package:vstech_home_services/features/auth/presentation/pages/reset_password_success_page.dart';
import 'package:vstech_home_services/features/auth/presentation/widgets/auth_role_badge.dart';
import 'package:vstech_home_services/features/auth/presentation/widgets/otp_pin_input_widget.dart';
import 'package:vstech_home_services/features/auth/presentation/widgets/social_auth_button.dart';
import 'package:vstech_home_services/l10n/generated/app_localizations.dart';

import '../../helpers/auth_test_providers.dart';

Widget _createTestWidget(Widget child) {
  final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(path: '/', builder: (context, state) => child),
      GoRoute(
        path: AppRoutes.resetPasswordSuccess,
        builder: (context, state) => ResetPasswordSuccessPage(role: state.uri.queryParameters['role'] ?? 'customer'),
      ),
      GoRoute(
        path: AppRoutes.customerHome,
        builder: (context, state) => const Scaffold(body: Text('CustomerHomeTarget')),
      ),
      GoRoute(
        path: AppRoutes.roleGateway,
        builder: (context, state) => const Scaffold(body: Text('RoleGatewayTarget')),
      ),
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const Scaffold(body: Text('LoginTarget')),
      ),
      GoRoute(
        path: AppRoutes.register,
        builder: (context, state) => const Scaffold(body: Text('RegisterTarget')),
      ),
      GoRoute(
        path: AppRoutes.verifyOtp,
        builder: (context, state) => const Scaffold(body: Text('VerifyOtpTarget')),
      ),
      GoRoute(
        path: AppRoutes.forgotPassword,
        builder: (context, state) => const Scaffold(body: Text('ForgotPasswordTarget')),
      ),
    ],
  );

  return AuthTestProviders().wrap(
    MaterialApp.router(
      theme: AppTheme.light,
      routerConfig: router,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      locale: const Locale('vi'),
    ),
  );
}

void main() {
  group('Batch 2 Auth Screens Widget Tests', () {
    testWidgets('LoginPage renders correctly for customer with social buttons', (tester) async {
      await tester.pumpWidget(_createTestWidget(const LoginPage()));
      await tester.pumpAndSettle();

      // Verify Role badge exists
      expect(find.byType(AuthRoleBadge), findsOneWidget);
      expect(find.text('Khách hàng'), findsOneWidget);

      // Verify Social login buttons exist for customer
      expect(find.byType(SocialAuthButton), findsNWidgets(3));

      // Toggle role to worker
      await tester.tap(find.text('Đổi vai trò'));
      await tester.pumpAndSettle();

      // Verify role switched to worker
      expect(find.text('Thợ đối tác'), findsOneWidget);

      // Verify social buttons are hidden for worker
      expect(find.byType(SocialAuthButton), findsNothing);
    });

    testWidgets('RegisterPage renders all form inputs and terms checkbox', (tester) async {
      await tester.pumpWidget(_createTestWidget(const RegisterPage()));
      await tester.pumpAndSettle();

      expect(find.text('Tạo tài khoản mới'), findsOneWidget);
      expect(find.text('Họ và tên'), findsOneWidget);
      expect(find.text('Số điện thoại'), findsOneWidget);
      expect(find.text('Mật khẩu'), findsOneWidget);
      expect(find.text('Xác nhận mật khẩu'), findsOneWidget);
      expect(find.byType(Checkbox), findsOneWidget);
    });

    testWidgets('OtpVerificationPage renders 6-pin input and demo quick fill works', (tester) async {
      await tester.pumpWidget(_createTestWidget(const OtpVerificationPage()));
      await tester.pumpAndSettle();

      // Verify 6 pin input boxes
      expect(find.byType(OtpPinInputWidget), findsOneWidget);

      // Verify demo quick fill button exists
      expect(find.text('Từ Tin nhắn: 123456'), findsOneWidget);

      // Tap quick fill button (which fills 123456 and navigates)
      await tester.tap(find.text('Từ Tin nhắn: 123456'));
      await tester.pumpAndSettle();

      // Verify navigation reached target
      expect(find.text('CustomerHomeTarget'), findsOneWidget);
    });

    testWidgets('ForgotPasswordPage renders phone input and action', (tester) async {
      await tester.pumpWidget(_createTestWidget(const ForgotPasswordPage(phone: '0901 234 567')));
      await tester.pumpAndSettle();

      expect(find.text('Khôi phục mật khẩu'), findsOneWidget);
      expect(find.text('Gửi mã xác thực'), findsOneWidget);
    });

    testWidgets('ResetPasswordPage locks CTA until rules pass, then shows success (Cells 28-29)', (tester) async {
      await tester.binding.setSurfaceSize(const Size(390, 844));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(_createTestWidget(const ResetPasswordPage(role: 'worker')));
      await tester.pumpAndSettle();

      expect(find.text('Tạo mật khẩu mới'), findsOneWidget);
      expect(find.text('Ít nhất 8 ký tự'), findsOneWidget);
      ElevatedButton cta() => tester.widget<ElevatedButton>(
        find.descendant(of: find.byKey(const Key('reset_password_submit')), matching: find.byType(ElevatedButton)),
      );
      expect(cta().onPressed, isNull);

      await tester.enterText(
        find.descendant(of: find.byKey(const Key('reset_password_new')), matching: find.byType(TextField)),
        'abc12345',
      );
      await tester.enterText(
        find.descendant(of: find.byKey(const Key('reset_password_confirm')), matching: find.byType(TextField)),
        'abc1234',
      );
      await tester.pump();
      expect(find.text('Mật khẩu nhập lại không khớp'), findsOneWidget);
      expect(cta().onPressed, isNull);

      await tester.enterText(
        find.descendant(of: find.byKey(const Key('reset_password_confirm')), matching: find.byType(TextField)),
        'abc12345',
      );
      await tester.pump();
      expect(cta().onPressed, isNotNull);

      await tester.tap(find.byKey(const Key('reset_password_submit')));
      await tester.pump(const Duration(milliseconds: 600));
      await tester.pumpAndSettle();

      expect(find.text('Đã đổi mật khẩu'), findsOneWidget);
      expect(find.textContaining('Thợ đối tác'), findsOneWidget);
      expect(find.text('Về đăng nhập'), findsOneWidget);
    });
  });
}
