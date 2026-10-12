import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vstech_home_services/core/error/failure.dart';
import 'package:vstech_home_services/core/network/network_exception.dart';
import 'package:vstech_home_services/core/router/app_routes.dart';
import 'package:vstech_home_services/core/theme/app_theme.dart';
import 'package:vstech_home_services/features/messaging/domain/entities/chat.dart';
import 'package:vstech_home_services/features/messaging/presentation/bloc/chat_cubit.dart';
import 'package:vstech_home_services/features/messaging/presentation/pages/chat_page.dart';
import 'package:vstech_home_services/l10n/generated/app_localizations.dart';

import '../../fixtures/messaging/chat_fixtures.dart';
import '../../helpers/mocks.dart';

Widget _app(MockChatCubit cubit, {bool isWorker = false}) {
  final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => BlocProvider<ChatCubit>.value(
          value: cubit,
          child: ChatPage(bookingId: '502', isWorker: isWorker),
        ),
      ),
      GoRoute(
        path: AppRoutes.voipCall,
        builder: (context, state) =>
            Scaffold(body: Text('Call:${state.uri.queryParameters['id']}')),
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

MockChatCubit _cubit(ChatState state) {
  final cubit = MockChatCubit();
  when(() => cubit.send(any())).thenAnswer((_) async => true);
  when(cubit.loadOlder).thenAnswer((_) async {});
  when(cubit.reconnect).thenAnswer((_) async {});
  when(cubit.retry).thenAnswer((_) async {});
  whenListen(cubit, const Stream<ChatState>.empty(), initialState: state);
  return cubit;
}

ChatLoadedState _loaded({
  ChatConnectionStatus connection = ChatConnectionStatus.connected,
  ChatRoom room = chatRoom,
  bool hasMore = false,
}) => ChatLoadedState(
  room: room,
  myUserId: '9',
  messages: [workerHello, customerReply],
  page: 0,
  hasMore: hasMore,
  connection: connection,
);

void main() {
  testWidgets(
    'customer sees the worker role header, masked phones, Sent/Seen and live status',
    (tester) async {
      await tester.binding.setSurfaceSize(const Size(800, 1400));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(_app(_cubit(_loaded())));
      await tester.pumpAndSettle();

      expect(find.text('Thợ phụ trách'), findsOneWidget);
      expect(find.text('Đơn #502'), findsOneWidget);
      expect(find.text('Chào chị, em là thợ phụ trách'), findsOneWidget);
      expect(find.textContaining('0901 ••• •••'), findsOneWidget);
      expect(find.textContaining('234 567'), findsNothing);
      expect(find.textContaining('Đã xem'), findsOneWidget);
      expect(
        find.byKey(const Key('chat_connection_connected')),
        findsOneWidget,
      );
    },
  );

  testWidgets(
    'typing and tapping send calls the cubit; quick replies send too',
    (tester) async {
      await tester.binding.setSurfaceSize(const Size(800, 1400));
      addTearDown(() => tester.binding.setSurfaceSize(null));
      final cubit = _cubit(_loaded());

      await tester.pumpWidget(_app(cubit));
      await tester.pumpAndSettle();
      await tester.enterText(
        find.byKey(const Key('chat_input_field')),
        'Anh tới chưa?',
      );
      await tester.tap(find.byKey(const Key('chat_send_button')));
      await tester.pumpAndSettle();

      verify(() => cubit.send('Anh tới chưa?')).called(1);
      expect(find.text('Anh tới chưa?'), findsNothing);

      await tester.tap(find.text('Gửi xe ở hầm B1'));
      verify(() => cubit.send('Gửi xe ở hầm B1')).called(1);
    },
  );

  testWidgets(
    'offline shows a reconnect action; load older is offered when there is more',
    (tester) async {
      await tester.binding.setSurfaceSize(const Size(800, 1400));
      addTearDown(() => tester.binding.setSurfaceSize(null));
      final cubit = _cubit(
        _loaded(connection: ChatConnectionStatus.offline, hasMore: true),
      );

      await tester.pumpWidget(_app(cubit));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key('chat_reconnect')));
      await tester.tap(find.byKey(const Key('chat_load_older')));

      verify(cubit.reconnect).called(1);
      verify(cubit.loadOlder).called(1);
    },
  );

  testWidgets('a closed room hides the input and disables calling', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(800, 1400));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      _app(_cubit(_loaded(room: chatRoom.copyWith(isClosed: true)))),
    );
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('chat_input_field')), findsNothing);
    expect(find.textContaining('Cuộc trò chuyện đã đóng'), findsOneWidget);
    final call = tester.widget<OutlinedButton>(
      find.descendant(
        of: find.byKey(const Key('chat_call_button')),
        matching: find.byType(OutlinedButton),
      ),
    );
    expect(call.onPressed, isNull);
  });

  testWidgets(
    'worker header names the customer; call opens the call screen for the booking',
    (tester) async {
      await tester.binding.setSurfaceSize(const Size(800, 1400));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(_app(_cubit(_loaded()), isWorker: true));
      await tester.pumpAndSettle();
      expect(find.text('Khách hàng'), findsOneWidget);

      await tester.tap(find.byKey(const Key('chat_call_button')));
      await tester.pumpAndSettle();
      expect(find.text('Call:502'), findsOneWidget);
    },
  );

  testWidgets(
    'load error offers retry; closed room error shows the closed notice',
    (tester) async {
      final cubit = _cubit(
        const ChatErrorState(Failure(kind: NetworkErrorKind.noConnection)),
      );
      await tester.pumpWidget(_app(cubit));
      await tester.pumpAndSettle();
      expect(find.byIcon(Icons.cloud_off_outlined), findsOneWidget);

      final closed = _cubit(
        const ChatErrorState(
          Failure(kind: NetworkErrorKind.server, errorCode: 'HS-409-0005'),
          isRoomClosed: true,
        ),
      );
      await tester.pumpWidget(_app(closed));
      await tester.pumpAndSettle();
      expect(find.text('Cuộc trò chuyện đã đóng'), findsOneWidget);
    },
  );
}
