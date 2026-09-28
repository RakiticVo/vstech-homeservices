import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:vstech_home_services/core/router/app_routes.dart';
import 'package:vstech_home_services/core/theme/app_theme.dart';
import 'package:vstech_home_services/features/auth/presentation/pages/change_password_page.dart';
import 'package:vstech_home_services/features/auth/presentation/pages/customer_profile_page.dart';
import 'package:vstech_home_services/features/auth/presentation/pages/customer_settings_page.dart';
import 'package:vstech_home_services/features/auth/presentation/pages/delete_account_page.dart';
import 'package:vstech_home_services/features/auth/presentation/pages/edit_address_page.dart';
import 'package:vstech_home_services/features/auth/presentation/pages/edit_profile_page.dart';
import 'package:vstech_home_services/features/auth/presentation/pages/link_wallet_page.dart';
import 'package:vstech_home_services/features/auth/presentation/pages/my_addresses_page.dart';
import 'package:vstech_home_services/features/auth/presentation/pages/payment_methods_page.dart';
import 'package:vstech_home_services/l10n/generated/app_localizations.dart';

Widget _createTestAuthWidget(Widget child) {
  final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => child,
      ),
      GoRoute(
        path: AppRoutes.editProfile,
        builder: (context, state) => const EditProfilePage(),
      ),
      GoRoute(
        path: AppRoutes.myAddresses,
        builder: (context, state) => const MyAddressesPage(),
      ),
      GoRoute(
        path: AppRoutes.editAddress,
        builder: (context, state) => const EditAddressPage(),
      ),
      GoRoute(
        path: AppRoutes.paymentMethods,
        builder: (context, state) => const PaymentMethodsPage(),
      ),
      GoRoute(
        path: AppRoutes.linkWallet,
        builder: (context, state) => const LinkWalletPage(),
      ),
      GoRoute(
        path: AppRoutes.favouritePros,
        builder: (context, state) => const Scaffold(body: Text('FavouritePros')),
      ),
      GoRoute(
        path: AppRoutes.customerNotificationSettings,
        builder: (context, state) => const Scaffold(body: Text('NotificationSettings')),
      ),
      GoRoute(
        path: AppRoutes.customerSettings,
        builder: (context, state) => const CustomerSettingsPage(),
      ),
      GoRoute(
        path: AppRoutes.changePassword,
        builder: (context, state) => const ChangePasswordPage(),
      ),
      GoRoute(
        path: AppRoutes.deleteAccount,
        builder: (context, state) => const DeleteAccountPage(),
      ),
      GoRoute(
        path: AppRoutes.customerDisputeList,
        builder: (context, state) => const Scaffold(body: Text('DisputeList')),
      ),
      GoRoute(
        path: AppRoutes.customerOrders,
        builder: (context, state) => const Scaffold(body: Text('CustomerOrders')),
      ),
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const Scaffold(body: Text('LoginPage')),
      ),
    ],
  );

  return MaterialApp.router(
    theme: AppTheme.light,
    routerConfig: router,
    localizationsDelegates: const [
      AppLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    supportedLocales: const [
      Locale('vi'),
      Locale('en'),
    ],
    locale: const Locale('vi'),
  );
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Batch 12: Customer Profile, Addresses, Wallets & Settings Widget Tests', () {
    testWidgets('CustomerProfilePage renders user card and menu options', (tester) async {
      await tester.binding.setSurfaceSize(const Size(390, 844));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(
        _createTestAuthWidget(const CustomerProfilePage()),
      );
      await tester.pumpAndSettle();

      expect(find.text('Hồ sơ cá nhân'), findsOneWidget);
      expect(find.text('Nguyễn Thị Mai'), findsOneWidget);
      expect(find.text('maingvyen@gmail.com'), findsOneWidget);
      expect(find.byKey(const Key('profile_edit_link')), findsOneWidget);

      expect(find.text('Thông tin cá nhân'), findsOneWidget);
      expect(find.text('Địa chỉ của tôi'), findsOneWidget);
      expect(find.text('Thợ yêu thích'), findsOneWidget);
      expect(find.text('Phương thức thanh toán'), findsOneWidget);
      expect(find.text('Cài đặt thông báo'), findsOneWidget);
      expect(find.text('Cài đặt & bảo mật'), findsOneWidget);

      // Tap on edit profile
      await tester.tap(find.byKey(const Key('profile_edit_link')));
      await tester.pumpAndSettle();
      expect(find.byKey(const Key('save_profile_button')), findsOneWidget);
    });

    testWidgets('EditProfilePage updates input fields and saves profile', (tester) async {
      await tester.binding.setSurfaceSize(const Size(390, 844));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(
        _createTestAuthWidget(const EditProfilePage()),
      );
      await tester.pumpAndSettle();

      expect(find.text('Họ và tên'), findsOneWidget);
      expect(find.text('Số điện thoại'), findsOneWidget);
      expect(find.text('Cần xác thực OTP khi đổi số điện thoại'), findsOneWidget);

      await tester.enterText(find.byKey(const Key('edit_profile_name')), 'Nguyễn Thị Hương Mai');
      await tester.tap(find.byKey(const Key('save_profile_button')));
      await tester.pumpAndSettle();

      expect(find.text('Đã lưu thay đổi thông tin thành công'), findsWidgets);
    });

    testWidgets('MyAddressesPage renders addresses and toggles default address', (tester) async {
      await tester.binding.setSurfaceSize(const Size(390, 844));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(
        _createTestAuthWidget(const MyAddressesPage()),
      );
      await tester.pumpAndSettle();

      expect(find.text('Địa chỉ của tôi'), findsOneWidget);
      expect(find.text('Nhà riêng'), findsOneWidget);
      expect(find.text('Văn phòng Bitexco'), findsOneWidget);
      expect(find.text('MẶC ĐỊNH'), findsOneWidget);

      // Set Bitexco as default
      await tester.ensureVisible(find.byKey(const Key('set_default_addr_2')));
      await tester.tap(find.byKey(const Key('set_default_addr_2')));
      await tester.pumpAndSettle();

      // Delete Nhà riêng (now non-default)
      await tester.ensureVisible(find.byKey(const Key('delete_addr_1')));
      expect(find.byKey(const Key('delete_addr_1')), findsOneWidget);
      await tester.tap(find.byKey(const Key('delete_addr_1')));
      await tester.pumpAndSettle();
      expect(find.text('Nhà riêng'), findsNothing);
    });

    testWidgets('EditAddressPage selects labels, adjusts floor stepper and toggles switch', (tester) async {
      await tester.binding.setSurfaceSize(const Size(390, 844));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(
        _createTestAuthWidget(const EditAddressPage()),
      );
      await tester.pumpAndSettle();

      expect(find.text('Thêm / Sửa địa chỉ'), findsOneWidget);
      expect(find.byKey(const Key('label_chip_work')), findsOneWidget);

      // Select work label
      await tester.tap(find.byKey(const Key('label_chip_work')));
      await tester.pumpAndSettle();

      // Floor stepper test
      expect(find.text('5'), findsOneWidget);
      await tester.tap(find.byKey(const Key('floor_plus_button')));
      await tester.pumpAndSettle();
      expect(find.text('6'), findsOneWidget);

      await tester.tap(find.byKey(const Key('floor_minus_button')));
      await tester.pumpAndSettle();
      expect(find.text('5'), findsOneWidget);

      // Toggle default switch
      await tester.ensureVisible(find.byKey(const Key('default_address_switch')));
      await tester.tap(find.byKey(const Key('default_address_switch')));
      await tester.pumpAndSettle();
    });

    testWidgets('PaymentMethodsPage unlinks wallet through confirmation dialog', (tester) async {
      await tester.binding.setSurfaceSize(const Size(390, 844));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(
        _createTestAuthWidget(const PaymentMethodsPage()),
      );
      await tester.pumpAndSettle();

      expect(find.text('Phương thức thanh toán'), findsOneWidget);
      expect(find.text('Ví điện tử VNPay'), findsOneWidget);
      expect(find.text('Ví điện tử ZaloPay'), findsOneWidget);

      // Unlink ZaloPay
      await tester.tap(find.byKey(const Key('unlink_wallet_zalopay')));
      await tester.pumpAndSettle();

      expect(find.text('Huỷ liên kết ví này? Bạn có thể liên kết lại bất cứ lúc nào.'), findsOneWidget);
      await tester.tap(find.byKey(const Key('confirm_unlink_button')));
      await tester.pumpAndSettle();

      expect(find.text('Ví điện tử ZaloPay'), findsNothing);
    });

    testWidgets('LinkWalletPage navigates 3-step wallet linking flow', (tester) async {
      await tester.binding.setSurfaceSize(const Size(390, 844));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(
        _createTestAuthWidget(const LinkWalletPage()),
      );
      await tester.pumpAndSettle();

      expect(find.text('Liên kết ví điện tử'), findsOneWidget);
      expect(find.text('Ví MoMo'), findsOneWidget);
      expect(find.text('Ví ShopeePay'), findsOneWidget);

      // Step 0 -> Step 1
      await tester.tap(find.byKey(const Key('select_wallet_shopeepay')));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key('link_wallet_action_button')));
      await tester.pumpAndSettle();

      expect(find.text('Xác nhận trên ứng dụng ví'), findsOneWidget);

      // Step 1 -> Step 2 (Success)
      await tester.tap(find.byKey(const Key('link_wallet_action_button')));
      await tester.pumpAndSettle();

      expect(find.text('Đã liên kết ví thành công!'), findsOneWidget);
      expect(find.text('Số điện thoại: 0901 ••• 567'), findsOneWidget);
    });

    testWidgets('CustomerSettingsPage displays options, history and handles logout sheet', (tester) async {
      await tester.binding.setSurfaceSize(const Size(390, 844));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(
        _createTestAuthWidget(const CustomerSettingsPage()),
      );
      await tester.pumpAndSettle();

      expect(find.text('Cài đặt & Lịch sử'), findsOneWidget);
      expect(find.text('Đổi mật khẩu'), findsOneWidget);
      expect(find.text('Về ứng dụng'), findsOneWidget);
      expect(find.text('Xoá tài khoản'), findsOneWidget);

      // Switch to history tab
      await tester.tap(find.text('Lịch sử đơn hàng'));
      await tester.pumpAndSettle();
      expect(find.text('Xem toàn bộ đơn hàng'), findsOneWidget);

      // Switch back to settings tab
      await tester.tap(find.text('Cài đặt'));
      await tester.pumpAndSettle();

      // Open logout bottom sheet
      await tester.tap(find.byKey(const Key('open_logout_button')));
      await tester.pumpAndSettle();

      expect(find.text('Đăng xuất khỏi tài khoản?'), findsOneWidget);
      expect(find.byKey(const Key('confirm_logout_button')), findsOneWidget);

      // Cancel logout
      await tester.tap(find.byKey(const Key('cancel_logout_button')));
      await tester.pumpAndSettle();
      expect(find.text('Đăng xuất khỏi tài khoản?'), findsNothing);
    });

    testWidgets('ChangePasswordPage toggles visibility and submits change', (tester) async {
      await tester.binding.setSurfaceSize(const Size(390, 844));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(
        _createTestAuthWidget(const ChangePasswordPage()),
      );
      await tester.pumpAndSettle();

      expect(find.text('Đổi mật khẩu'), findsOneWidget);
      expect(find.text('Mật khẩu hiện tại'), findsOneWidget);
      expect(find.text('Mật khẩu mới'), findsOneWidget);
      expect(find.text('Nhập lại mật khẩu mới'), findsOneWidget);

      await tester.enterText(find.byKey(const Key('password_input_current')), 'Secret123');
      await tester.enterText(find.byKey(const Key('password_input_new')), 'NewSecret456');
      await tester.enterText(find.byKey(const Key('password_input_confirm')), 'NewSecret456');

      await tester.tap(find.byKey(const Key('submit_change_password_button')));
      await tester.pumpAndSettle();

      expect(find.text('Đã đổi mật khẩu thành công!'), findsWidgets);
    });

    testWidgets('DeleteAccountPage selects reason and displays consequences', (tester) async {
      await tester.binding.setSurfaceSize(const Size(390, 844));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(
        _createTestAuthWidget(const DeleteAccountPage()),
      );
      await tester.pumpAndSettle();

      expect(find.text('Xoá tài khoản'), findsOneWidget);
      expect(find.text('Hành động này không thể hoàn tác'), findsOneWidget);
      expect(find.text('Hồ sơ cá nhân và số điện thoại'), findsOneWidget);
      expect(find.text('Phiếu bảo hành còn hiệu lực'), findsOneWidget);

      // Select reason
      await tester.tap(find.byKey(const Key('delete_reason_1')));
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('confirm_delete_account_button')), findsOneWidget);
      expect(find.byKey(const Key('keep_account_button')), findsOneWidget);
    });
  });
}
