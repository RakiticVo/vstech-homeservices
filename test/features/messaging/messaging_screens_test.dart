import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:vstech_home_services/core/router/app_routes.dart';
import 'package:vstech_home_services/core/theme/app_theme.dart';
import 'package:vstech_home_services/features/messaging/presentation/pages/voip_call_page.dart';
import 'package:vstech_home_services/l10n/generated/app_localizations.dart';

Widget _createTestMessagingWidget(Widget child) {
  final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(path: '/', builder: (context, state) => child),
      GoRoute(
        path: AppRoutes.voipCall,
        builder: (context, state) => const VoipCallPage(),
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
    supportedLocales: const [Locale('vi'), Locale('en')],
    locale: const Locale('vi'),
  );
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Batch 11: Masked VoIP Calls Widget Tests', () {
    testWidgets(
      'VoipCallPage (Outgoing) renders connecting state, recording banner and controls',
      (tester) async {
        await tester.binding.setSurfaceSize(const Size(390, 844));
        addTearDown(() => tester.binding.setSurfaceSize(null));

        await tester.pumpWidget(
          _createTestMessagingWidget(
            const VoipCallPage(peerName: 'Trần Văn Hùng'),
          ),
        );
        await tester.pump();

        expect(find.text('Trần Văn Hùng'), findsOneWidget);
        expect(find.text('Đang kết nối…'), findsOneWidget);
        expect(
          find.text(
            'Cuộc gọi được ghi âm để bảo vệ hai bên và hỗ trợ giải quyết khiếu nại',
          ),
          findsOneWidget,
        );
        expect(find.text('Tắt mic'), findsOneWidget);
        expect(find.text('Loa ngoài'), findsOneWidget);
        expect(find.text('Kết thúc'), findsOneWidget);

        // Toggle Mute
        await tester.tap(find.text('Tắt mic'));
        await tester.pump();

        // End Call
        await tester.tap(find.text('Kết thúc'));
        await tester.pumpAndSettle();
      },
    );

    testWidgets(
      'VoipCallPage (Incoming) renders incoming state with accept and decline buttons',
      (tester) async {
        await tester.binding.setSurfaceSize(const Size(390, 844));
        addTearDown(() => tester.binding.setSurfaceSize(null));

        await tester.pumpWidget(
          _createTestMessagingWidget(
            const VoipCallPage(
              role: 'worker',
              mode: 'callin',
              peerName: 'Nguyễn Thị Mai',
            ),
          ),
        );
        await tester.pump();

        expect(find.text('Nguyễn Thị Mai'), findsOneWidget);
        expect(find.text('Cuộc gọi đến'), findsOneWidget);
        expect(find.text('Từ chối'), findsOneWidget);
        expect(find.text('Nghe máy'), findsOneWidget);

        // Tap Accept
        await tester.tap(find.text('Nghe máy'));
        await tester.pump();

        // Now transitions to live call with 3 buttons
        expect(find.text('Kết thúc'), findsOneWidget);
        expect(find.text('Tắt mic'), findsOneWidget);
      },
    );
  });
}
