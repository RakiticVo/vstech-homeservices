import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vstech_home_services/core/error/failure.dart';
import 'package:vstech_home_services/core/error/result.dart';
import 'package:vstech_home_services/core/network/network_exception.dart';
import 'package:vstech_home_services/features/auth/domain/entities/user_profile.dart';
import 'package:vstech_home_services/features/messaging/domain/entities/chat.dart';
import 'package:vstech_home_services/features/messaging/domain/entities/voip_call.dart';
import 'package:vstech_home_services/features/messaging/presentation/bloc/chat_cubit.dart';

import '../../../fixtures/auth/auth_fixtures.dart';
import '../../../fixtures/messaging/chat_fixtures.dart';
import '../../../helpers/mocks.dart';

const _offline = Failure(kind: NetworkErrorKind.noConnection);
const _closed = Failure(
  kind: NetworkErrorKind.server,
  errorCode: 'HS-409-0005',
  statusCode: 409,
);

void main() {
  late MockGetProfileUseCase getProfile;
  late MockOpenChatRoomUseCase openRoom;
  late MockGetChatMessagesUseCase getMessages;
  late MockSendChatMessageUseCase sendMessage;
  late MockGetCallHistoryUseCase getCallHistory;
  late MockChatConnection connection;
  late StreamController<ChatLiveEvent> events;
  late StreamController<ChatConnectionStatus> statuses;

  setUp(() {
    getProfile = MockGetProfileUseCase();
    openRoom = MockOpenChatRoomUseCase();
    getMessages = MockGetChatMessagesUseCase();
    sendMessage = MockSendChatMessageUseCase();
    getCallHistory = MockGetCallHistoryUseCase();
    connection = MockChatConnection();
    when(() => getCallHistory('502')).thenAnswer((_) async => Ok([missedCall]));
    events = StreamController.broadcast();
    statuses = StreamController.broadcast();
    when(() => connection.events).thenAnswer((_) => events.stream);
    when(() => connection.status).thenAnswer((_) => statuses.stream);
    when(() => connection.connect(any())).thenAnswer((_) async {});
    when(() => connection.close()).thenAnswer((_) async {});
    when(() => getProfile())
        .thenAnswer((_) async => const Ok<UserProfile>(customerProfile));
    when(() => openRoom('502')).thenAnswer((_) async => const Ok(chatRoom));
    when(() => getMessages('12345')).thenAnswer(
      (_) async => Ok(
        ChatHistoryPage(
          items: [customerReply, workerHello],
          page: 0,
          hasMore: true,
        ),
      ),
    );
  });

  ChatCubit build() => ChatCubit(
    getProfile,
    openRoom,
    getMessages,
    sendMessage,
    getCallHistory,
    connection,
  );

  ChatLoadedState loaded(
    List<ChatRoomMessage> messages, {
    ChatConnectionStatus connection = ChatConnectionStatus.connecting,
    ChatRoom room = chatRoom,
    bool hasMore = true,
    List<VoipCall> calls = const [],
  }) => ChatLoadedState(
    room: room,
    myUserId: '9',
    messages: messages,
    calls: calls,
    page: 0,
    hasMore: hasMore,
    connection: connection,
  );

  blocTest<ChatCubit, ChatState>(
    'open loads the room and history (oldest first), then connects the socket',
    build: build,
    act: (cubit) => cubit.open('502'),
    expect: () => [
      const ChatLoadingState(),
      loaded([workerHello, customerReply], calls: [missedCall]),
    ],
    verify: (_) => verify(() => connection.connect('12345')).called(1),
  );

  blocTest<ChatCubit, ChatState>(
    'a closed room is read-only and never connects',
    setUp: () => when(
      () => openRoom('502'),
    ).thenAnswer((_) async => const Ok(ChatRoom(id: '12345', isClosed: true))),
    build: build,
    act: (cubit) => cubit.open('502'),
    expect: () => [
      const ChatLoadingState(),
      loaded(
        [workerHello, customerReply],
        room: const ChatRoom(id: '12345', isClosed: true),
        connection: ChatConnectionStatus.offline,
        calls: [missedCall],
      ),
    ],
    verify: (_) => verifyNever(() => connection.connect(any())),
  );

  blocTest<ChatCubit, ChatState>(
    'opening a closed room (HS-409-0005) shows the closed notice',
    setUp: () =>
        when(() => openRoom('502')).thenAnswer((_) async => const Err(_closed)),
    build: build,
    act: (cubit) => cubit.open('502'),
    expect: () => [
      const ChatLoadingState(),
      const ChatErrorState(_closed, isRoomClosed: true),
    ],
  );

  blocTest<ChatCubit, ChatState>(
    'live messages and connection status are merged; duplicates by id are ignored',
    build: build,
    act: (cubit) async {
      await cubit.open('502');
      statuses.add(ChatConnectionStatus.connected);
      await pumpEventQueue();
      events
        ..add(ChatLiveMessage(workerLive))
        ..add(ChatLiveMessage(workerLive));
      await pumpEventQueue();
    },
    skip: 2,
    expect: () => [
      loaded(
        [workerHello, customerReply],
        connection: ChatConnectionStatus.connected,
        calls: [missedCall],
      ),
      loaded(
        [workerHello, customerReply, workerLive],
        connection: ChatConnectionStatus.connected,
        calls: [missedCall],
      ),
    ],
  );

  blocTest<ChatCubit, ChatState>(
    'send merges the server copy and reports success',
    setUp: () =>
        when(() => sendMessage('12345', 'Em tới rồi'))
            .thenAnswer((_) async => Ok(workerLive)),
    build: build,
    seed: () => loaded([workerHello]),
    act: (cubit) async => expect(await cubit.send('Em tới rồi'), isTrue),
    expect: () => [
      loaded([workerHello]).copyWith(isSending: true),
      loaded([workerHello, workerLive]),
    ],
  );

  blocTest<ChatCubit, ChatState>(
    'send failure keeps the list and surfaces a one-shot failure',
    setUp: () =>
        when(() => sendMessage('12345', 'Hi'))
            .thenAnswer((_) async => const Err(_offline)),
    build: build,
    seed: () => loaded([workerHello]),
    act: (cubit) async => expect(await cubit.send('Hi'), isFalse),
    expect: () => [
      loaded([workerHello]).copyWith(isSending: true),
      loaded([workerHello]).copyWith(actionFailure: _offline),
    ],
  );

  blocTest<ChatCubit, ChatState>(
    'a socket HS-409-0005 error closes the room',
    build: build,
    act: (cubit) async {
      await cubit.open('502');
      events.add(const ChatLiveError('HS-409-0005'));
      await pumpEventQueue();
    },
    skip: 2,
    expect: () => [
      loaded(
        [workerHello, customerReply],
        room: chatRoom.copyWith(isClosed: true),
        connection: ChatConnectionStatus.offline,
        calls: [missedCall],
      ),
    ],
  );

  blocTest<ChatCubit, ChatState>(
    'loadOlder prepends the next page',
    setUp: () => when(() => getMessages('12345', page: 1)).thenAnswer(
      (_) async =>
          Ok(ChatHistoryPage(items: [workerHello], page: 1, hasMore: false)),
    ),
    build: build,
    seed: () => loaded([customerReply]),
    act: (cubit) => cubit.loadOlder(),
    expect: () => [
      loaded([customerReply]).copyWith(isLoadingOlder: true),
      ChatLoadedState(
        room: chatRoom,
        myUserId: '9',
        messages: [workerHello, customerReply],
        page: 1,
        hasMore: false,
      ),
    ],
  );

  blocTest<ChatCubit, ChatState>(
    'a failing call log does not block the chat',
    setUp: () =>
        when(() => getCallHistory('502'))
            .thenAnswer((_) async => const Err(_offline)),
    build: build,
    act: (cubit) => cubit.open('502'),
    expect: () => [
      const ChatLoadingState(),
      loaded([workerHello, customerReply]),
    ],
  );

  blocTest<ChatCubit, ChatState>(
    'refreshCalls replaces the call log',
    setUp: () {
      final answers = [
        Ok([missedCall]),
        Ok([missedCall, talkedCall]),
      ];
      when(() => getCallHistory('502'))
          .thenAnswer((_) async => answers.removeAt(0));
    },
    build: build,
    act: (cubit) async {
      await cubit.open('502');
      await cubit.refreshCalls();
    },
    skip: 2,
    expect: () => [
      loaded([workerHello, customerReply], calls: [missedCall, talkedCall]),
    ],
  );

  test('close closes the socket', () async {
    final cubit = build();
    await cubit.open('502');
    await cubit.close();
    verify(() => connection.close()).called(1);
  });
}
