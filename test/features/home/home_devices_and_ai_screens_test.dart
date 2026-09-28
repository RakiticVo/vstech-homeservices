import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:vstech_home_services/core/router/app_routes.dart';
import 'package:vstech_home_services/core/theme/app_theme.dart';
import 'package:vstech_home_services/features/home/presentation/pages/ai_assistant_page.dart';
import 'package:vstech_home_services/features/home/presentation/pages/ai_suggestions_page.dart';
import 'package:vstech_home_services/features/home/presentation/pages/favourite_pros_page.dart';
import 'package:vstech_home_services/features/home/presentation/pages/my_home_devices_page.dart';
import 'package:vstech_home_services/features/home/presentation/pages/worker_profile_preview_page.dart';
import 'package:vstech_home_services/l10n/generated/app_localizations.dart';

Widget _createTestHomeDevicesWidget(Widget child) {
  final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => child,
      ),
      GoRoute(
        path: AppRoutes.aiSuggestions,
        builder: (context, state) => const AiSuggestionsPage(),
      ),
      GoRoute(
        path: AppRoutes.bookingStep1,
        builder: (context, state) => const Scaffold(body: Text('BookingStep1')),
      ),
      GoRoute(
        path: AppRoutes.myAddresses,
        builder: (context, state) => const Scaffold(body: Text('MyAddresses')),
      ),
      GoRoute(
        path: AppRoutes.workerProfilePreview,
        builder: (context, state) => const WorkerProfilePreviewPage(),
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

  group('Batch 12: Home Devices, AI Assistant & Favourite Pros Widget Tests', () {
    testWidgets('MyHomeDevicesPage renders address, devices tab and overdue banner', (tester) async {
      await tester.binding.setSurfaceSize(const Size(390, 844));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(
        _createTestHomeDevicesWidget(const MyHomeDevicesPage()),
      );
      await tester.pumpAndSettle();

      expect(find.text('Ngôi nhà của bạn'), findsOneWidget);
      expect(find.text('123 Nguyễn Thị Minh Khai, Quận 1'), findsOneWidget);
      expect(find.text('Máy lạnh phòng khách'), findsOneWidget);
      expect(find.text('Máy nước nóng trực tiếp'), findsOneWidget);
      expect(find.text('Nhắc bảo trì máy nước nóng'), findsOneWidget);
      expect(find.byKey(const Key('add_device_button')), findsOneWidget);

      // Switch to schedule tab
      await tester.tap(find.text('Lịch bảo trì'));
      await tester.pumpAndSettle();

      expect(find.text('Bảo trì máy nước nóng'), findsOneWidget);
      expect(find.text('Vệ sinh máy lạnh định kỳ'), findsOneWidget);
      expect(find.text('CẦN ĐẶT LỊCH'), findsOneWidget);
    });

    testWidgets('AiAssistantPage renders welcome bubble and handles intent chips', (tester) async {
      await tester.binding.setSurfaceSize(const Size(390, 844));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(
        _createTestHomeDevicesWidget(const AiAssistantPage()),
      );
      await tester.pumpAndSettle();

      expect(find.text('Trợ lý AI HomeService'), findsOneWidget);
      expect(find.text('Sẵn sàng hỗ trợ 24/7'), findsOneWidget);
      expect(
        find.textContaining('Xin chào Mai! Mình là trợ lý AI của HomeService'),
        findsOneWidget,
      );

      // Tap intent chip for house cleaning cost
      await tester.tap(find.text('Chi phí dọn nhà là bao nhiêu?'));
      await tester.pumpAndSettle();

      // Verify user message appears and AI responds
      expect(find.text('Chi phí dọn nhà là bao nhiêu?'), findsNWidgets(2));
      await tester.pump(const Duration(milliseconds: 500));
      await tester.pumpAndSettle();
      expect(find.textContaining('Giá dọn dẹp nhà tiêu chuẩn từ 80.000đ/giờ'), findsOneWidget);

      // Send custom message via text input
      await tester.enterText(find.byKey(const Key('ai_input_field')), 'Vệ sinh máy lạnh giá bao nhiêu?');
      await tester.tap(find.byKey(const Key('ai_send_button')));
      await tester.pumpAndSettle();

      expect(find.text('Vệ sinh máy lạnh giá bao nhiêu?'), findsOneWidget);
      await tester.pump(const Duration(milliseconds: 500));
      await tester.pumpAndSettle();
      expect(find.textContaining('rửa lưới lọc bụi 2 tuần/lần'), findsOneWidget);
    });

    testWidgets('AiSuggestionsPage renders urgent and routine recommendation cards', (tester) async {
      await tester.binding.setSurfaceSize(const Size(390, 844));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(
        _createTestHomeDevicesWidget(const AiSuggestionsPage()),
      );
      await tester.pumpAndSettle();

      expect(find.text('Gợi ý thông minh cho bạn'), findsOneWidget);
      expect(find.text('Bảo trì máy nước nóng Ariston'), findsOneWidget);
      expect(find.text('Đặt lịch ngay · 250.000đ'), findsOneWidget);
      expect(find.text('Vệ sinh máy lạnh'), findsOneWidget);
      expect(find.text('Diệt côn trùng định kỳ'), findsOneWidget);

      // Tap book now
      await tester.tap(find.byKey(const Key('book_suggested_heater_button')));
      await tester.pumpAndSettle();
      expect(find.text('BookingStep1'), findsOneWidget);
    });

    testWidgets('FavouriteProsPage renders technicians, toggles heart and navigates', (tester) async {
      await tester.binding.setSurfaceSize(const Size(390, 844));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(
        _createTestHomeDevicesWidget(const FavouriteProsPage()),
      );
      await tester.pumpAndSettle();

      expect(find.text('Thợ yêu thích'), findsOneWidget);
      expect(find.text('Trần Văn Hùng'), findsOneWidget);
      expect(find.text('Phạm Minh Đức'), findsOneWidget);

      // Toggle heart for Hung
      await tester.tap(find.byKey(const Key('toggle_fav_hung')));
      await tester.pumpAndSettle();
      expect(find.text('Trần Văn Hùng'), findsNothing);

      // Tap rebook on Duc
      await tester.tap(find.byKey(const Key('rebook_duc')));
      await tester.pumpAndSettle();
      expect(find.text('BookingStep1'), findsOneWidget);
    });

    testWidgets('WorkerProfilePreviewPage renders bio, skills, review quote and CTA', (tester) async {
      await tester.binding.setSurfaceSize(const Size(390, 844));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(
        _createTestHomeDevicesWidget(const WorkerProfilePreviewPage()),
      );
      await tester.pumpAndSettle();

      expect(find.text('Hồ sơ thợ'), findsOneWidget);
      expect(find.text('Trần Văn Hùng'), findsOneWidget);
      expect(find.text('Kỹ thuật viên đã xác minh'), findsOneWidget);
      expect(find.text('Vệ sinh máy lạnh'), findsWidgets);
      expect(find.textContaining('Anh Hùng vệ sinh máy lạnh rất kỹ'), findsOneWidget);
      expect(find.byKey(const Key('book_worker_profile_button')), findsOneWidget);

      // Toggle favorite
      await tester.tap(find.byKey(const Key('toggle_worker_fav')));
      await tester.pumpAndSettle();
    });
  });
}
