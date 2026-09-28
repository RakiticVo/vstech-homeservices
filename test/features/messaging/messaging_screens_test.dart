import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:vstech_home_services/core/router/app_routes.dart';
import 'package:vstech_home_services/core/theme/app_theme.dart';
import 'package:vstech_home_services/features/messaging/presentation/pages/chat_page.dart';
import 'package:vstech_home_services/features/messaging/presentation/pages/voip_call_page.dart';
import 'package:vstech_home_services/l10n/generated/app_localizations.dart';

Widget _createTestMessagingWidget(Widget child) {
  final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => child,
      ),
      GoRoute(
        path: AppRoutes.chat,
        builder: (context, state) => const ChatPage(),
      ),
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
    supportedLocales: const [
      Locale('vi'),
      Locale('en'),
    ],
    locale: const Locale('vi'),
  );
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Batch 11: In-App Chat & Masked VoIP Calls Widget Tests', () {
    testWidgets('ChatPage (Customer) renders header, privacy banner, and message bubbles', (tester) async {
      await tester.binding.setSurfaceSize(const Size(390, 844));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(
        _createTestMessagingWidget(
          const ChatPage(
            peerName: 'Trần Văn Hùng',
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Verify Header & Privacy
      expect(find.text('Trần Văn Hùng'), findsOneWidget);
      expect(find.textContaining('#HS20250425-0012'), findsOneWidget);
      expect(find.text('Số điện thoại của hai bên được ẩn'), findsOneWidget);

      // Verify bottom items (list auto-scrolls to bottom on load)
      expect(find.text('ĐỀ XUẤT CHI PHÍ PHÁT SINH'), findsOneWidget);
      expect(find.text('+45.000đ'), findsOneWidget);
      expect(find.text('Đồng ý'), findsOneWidget);
      expect(find.text('Từ chối'), findsOneWidget);

      // Verify Phone Masking (0901 ••• •••)
      expect(find.text('Nếu cần thì gọi chị số 0901 ••• ••• nha.'), findsOneWidget);
      expect(find.text('Số điện thoại đã được ẩn để bảo vệ hai bên.'), findsWidgets);

      // Scroll up to view top/initial messages
      await tester.drag(find.byKey(const Key('chat_message_list')), const Offset(0, 800));
      await tester.pumpAndSettle();

      // Verify Initial Message bubbles
      expect(find.text('Anh Hùng đã nhận việc · 13:12'), findsOneWidget);
      expect(find.text('Chào chị Mai, em là Hùng. Em sẽ có mặt lúc 14:00 ạ.'), findsOneWidget);
      expect(find.text('Ok em. Nhà chị tầng 12, gửi xe ở hầm B1 nhé.'), findsOneWidget);
    });

    testWidgets('ChatPage (Customer) allows approving extra cost and sending quick reply', (tester) async {
      await tester.binding.setSurfaceSize(const Size(390, 844));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(
        _createTestMessagingWidget(
          const ChatPage(),
        ),
      );
      await tester.pumpAndSettle();

      // Scroll down to locate extra cost card
      await tester.drag(find.byKey(const Key('chat_message_list')), const Offset(0, -600));
      await tester.pumpAndSettle();

      // Tap Approve on extra cost card
      final approveBtn = find.text('Đồng ý');
      expect(approveBtn, findsOneWidget);
      await tester.tap(approveBtn);
      await tester.pumpAndSettle();

      expect(find.text('Đã đồng ý · cộng vào hoá đơn khi nghiệm thu'), findsOneWidget);

      // Tap Quick Reply chip
      final quickReply = find.text('Mình ở nhà rồi');
      expect(quickReply, findsOneWidget);
      await tester.tap(quickReply);
      await tester.pumpAndSettle();

      expect(find.text('Mình ở nhà rồi'), findsNWidgets(2)); // in chip + in message bubble
    });

    testWidgets('ChatPage (Worker) renders worker quick replies and pending extra cost status', (tester) async {
      await tester.binding.setSurfaceSize(const Size(390, 844));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(
        _createTestMessagingWidget(
          const ChatPage(
            role: 'worker',
            peerName: 'Nguyễn Thị Mai',
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Nguyễn Thị Mai'), findsOneWidget);
      expect(find.text('Tôi đang đến'), findsOneWidget);
      expect(find.text('Tôi đã tới sảnh'), findsOneWidget);

      // Scroll to view pending extra cost card
      await tester.drag(find.byKey(const Key('chat_message_list')), const Offset(0, -600));
      await tester.pumpAndSettle();
      expect(find.text('Đang chờ khách xác nhận'), findsOneWidget);
    });

    testWidgets('ChatPage (Closed) shows closed notice and hides input bar', (tester) async {
      await tester.binding.setSurfaceSize(const Size(390, 844));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(
        _createTestMessagingWidget(
          const ChatPage(
            isClosed: true,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(
        find.text('Cuộc trò chuyện đã đóng 24 giờ sau khi hoàn tất đơn. Cần hỗ trợ, vui lòng liên hệ Trung tâm hỗ trợ.'),
        findsOneWidget,
      );
      expect(find.text('Nhập tin nhắn…'), findsNothing);
    });

    testWidgets('VoipCallPage (Outgoing) renders connecting state, recording banner and controls', (tester) async {
      await tester.binding.setSurfaceSize(const Size(390, 844));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(
        _createTestMessagingWidget(
          const VoipCallPage(
            peerName: 'Trần Văn Hùng',
          ),
        ),
      );
      await tester.pump();

      expect(find.text('Trần Văn Hùng'), findsOneWidget);
      expect(find.text('Đang kết nối…'), findsOneWidget);
      expect(find.text('Cuộc gọi được ghi âm để bảo vệ hai bên và hỗ trợ giải quyết khiếu nại'), findsOneWidget);
      expect(find.text('Tắt mic'), findsOneWidget);
      expect(find.text('Loa ngoài'), findsOneWidget);
      expect(find.text('Kết thúc'), findsOneWidget);

      // Toggle Mute
      await tester.tap(find.text('Tắt mic'));
      await tester.pump();

      // End Call
      await tester.tap(find.text('Kết thúc'));
      await tester.pumpAndSettle();
    });

    testWidgets('VoipCallPage (Incoming) renders incoming state with accept and decline buttons', (tester) async {
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
    });
  });
}
