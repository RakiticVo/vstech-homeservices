import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:vstech_home_services/core/router/app_routes.dart';
import 'package:vstech_home_services/core/theme/app_theme.dart';
import 'package:vstech_home_services/features/home/presentation/pages/categories_page.dart';
import 'package:vstech_home_services/features/home/presentation/pages/customer_home_page.dart';
import 'package:vstech_home_services/features/home/presentation/pages/service_detail_page.dart';
import 'package:vstech_home_services/features/home/presentation/widgets/customer_floating_dock.dart';
import 'package:vstech_home_services/features/home/presentation/widgets/home_devices_card.dart';
import 'package:vstech_home_services/features/home/presentation/widgets/home_top_header.dart';
import 'package:vstech_home_services/features/home/presentation/widgets/service_category_tile.dart';
import 'package:vstech_home_services/features/home/presentation/widgets/service_offer_card.dart';
import 'package:vstech_home_services/l10n/generated/app_localizations.dart';

Widget _createTestHomeWidget(Widget child) {
  final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => child,
      ),
      GoRoute(
        path: AppRoutes.categories,
        builder: (context, state) => const CategoriesPage(),
      ),
      GoRoute(
        path: AppRoutes.serviceDetail,
        builder: (context, state) {
          final id = state.uri.queryParameters['id'] ?? 'clean';
          return ServiceDetailPage(serviceId: id);
        },
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
    supportedLocales: AppLocalizations.supportedLocales,
    locale: const Locale('vi'),
  );
}

void main() {
  group('Batch 3 Customer Home & Categories Widget Tests', () {
    testWidgets('CustomerHomePage renders all sections and floating dock', (tester) async {
      await tester.pumpWidget(_createTestHomeWidget(const CustomerHomePage()));
      await tester.pumpAndSettle();

      // Verify Header
      expect(find.byType(HomeTopHeader), findsOneWidget);
      expect(find.textContaining('Chào bạn, Mai'), findsOneWidget);

      // Verify 8 Category Tiles
      expect(find.byType(ServiceCategoryTile), findsNWidgets(8));

      // Verify Offers section
      expect(find.text('Ưu đãi đặc quyền'), findsOneWidget);
      expect(find.byType(ServiceOfferCard), findsWidgets);

      // Verify Devices Card
      expect(find.byType(HomeDevicesCard), findsOneWidget);

      // Verify Floating Bottom Dock
      expect(find.byType(CustomerFloatingDock), findsOneWidget);
      expect(find.text('Trang chủ'), findsOneWidget);
    });

    testWidgets('CustomerHomePage dock tab selection updates active tab', (tester) async {
      await tester.pumpWidget(_createTestHomeWidget(const CustomerHomePage()));
      await tester.pumpAndSettle();

      // Tap 'Đơn hàng' tab
      await tester.tap(find.byIcon(Icons.receipt_long_outlined));
      await tester.pumpAndSettle();

      // Verify active label shows
      expect(find.text('Đơn hàng'), findsOneWidget);
    });

    testWidgets('CategoriesPage renders filter chips and handles filter change', (tester) async {
      await tester.pumpWidget(_createTestHomeWidget(const CategoriesPage()));
      await tester.pumpAndSettle();

      expect(find.text('Tất cả dịch vụ'), findsOneWidget);
      expect(find.text('Tất cả'), findsOneWidget);
      expect(find.text('Vệ sinh'), findsOneWidget);
      expect(find.text('Điện lạnh'), findsOneWidget);

      // Tap 'Vệ sinh' filter
      await tester.tap(find.text('Vệ sinh'));
      await tester.pumpAndSettle();

      // Should still show clean services
      expect(find.textContaining('Dọn dẹp vệ sinh'), findsOneWidget);
    });

    testWidgets('ServiceDetailPage renders service info, inclusions, and book CTA', (tester) async {
      await tester.pumpWidget(
        _createTestHomeWidget(const ServiceDetailPage()),
      );
      await tester.pumpAndSettle();

      expect(find.text('Dọn dẹp vệ sinh'), findsWidgets);
      expect(find.text('Bảo hành 0đ trong 30 ngày'), findsOneWidget);
      expect(find.text('Gói dịch vụ bao gồm'), findsOneWidget);
      expect(find.text('Đặt lịch ngay'), findsOneWidget);
    });
  });
}
