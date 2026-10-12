import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vstech_home_services/core/error/result.dart';
import 'package:vstech_home_services/core/network/api_endpoints.dart';
import 'package:vstech_home_services/core/network/api_response.dart';
import 'package:vstech_home_services/core/network/realtime_socket.dart';
import 'package:vstech_home_services/features/messaging/data/datasources/chat_remote_data_source.dart';
import 'package:vstech_home_services/features/messaging/data/datasources/chat_socket_data_source.dart';
import 'package:vstech_home_services/features/messaging/data/models/chat_message_request.dart';
import 'package:vstech_home_services/features/messaging/data/models/chat_message_response.dart';
import 'package:vstech_home_services/features/messaging/data/models/chat_room_response.dart';
import 'package:vstech_home_services/features/messaging/data/models/create_chat_room_request.dart';
import 'package:vstech_home_services/features/messaging/data/repositories/chat_repository_impl.dart';
import 'package:vstech_home_services/features/messaging/domain/entities/chat.dart';
import 'package:vstech_home_services/features/messaging/domain/usecases/chat_use_cases.dart';

import '../../../fixtures/fixture_reader.dart';
import '../../../helpers/mocks.dart';

ApiResponse<T> _ok<T>(T data) => ApiResponse(
  status: 200,
  message: '',
  data: data,
  errorCode: null,
  timestamp: null,
);

void main() {
  group('ChatRemoteDataSource', () {
    late MockApiClient client;
    late ChatRemoteDataSource dataSource;

    setUp(() {
      client = MockApiClient();
      dataSource = ChatRemoteDataSource(client);
    });

    test('openRoom is an idempotent POST with a numeric booking id', () async {
      when(
        () => client.post<ChatRoomResponse>(
          ApiEndpoints.chatRooms,
          body: any(named: 'body'),
          idempotent: true,
          decode: any(named: 'decode'),
        ),
      ).thenAnswer((invocation) async {
        final decode =
            invocation.namedArguments[#decode]
                as ChatRoomResponse Function(Object?);
        return _ok(
          decode({
            'id': 12345,
            'bookingId': 30001,
            'customerId': 20000,
            'workerId': 20001,
            'status': 'ACTIVE',
          }),
        );
      });

      final room = await dataSource.openRoom(
        const CreateChatRoomRequest(bookingId: '30001'),
      );

      expect(room.id, '12345');
      verify(
        () => client.post<ChatRoomResponse>(
          ApiEndpoints.chatRooms,
          body: {'bookingId': 30001},
          idempotent: true,
          decode: any(named: 'decode'),
        ),
      ).called(1);
    });

    test('getMessages decodes the bare messages list', () async {
      when(
        () => client.get<ChatMessagePageResponse>(
          ApiEndpoints.chatMessages('12345'),
          query: any(named: 'query'),
          decode: any(named: 'decode'),
        ),
      ).thenAnswer((invocation) async {
        final decode =
            invocation.namedArguments[#decode]
                as ChatMessagePageResponse Function(Object?);
        return _ok(
          decode(jsonFixture('messaging/chat_messages_page.json')['data']),
        );
      });

      final page = await dataSource.getMessages('12345', page: 0, size: 50);

      expect(page.messages.map((m) => m.senderId), ['20000', '20001']);
      expect(page.messages.last.mediaUrls, isEmpty);
    });

    test('sendMessage omits null mediaUrls and is idempotent', () async {
      when(
        () => client.post<ChatMessageResponse>(
          ApiEndpoints.chatMessages('12345'),
          body: any(named: 'body'),
          idempotent: true,
          decode: any(named: 'decode'),
        ),
      ).thenAnswer(
        (_) async => _ok(const ChatMessageResponse(id: '1', messageText: 'Hi')),
      );

      await dataSource.sendMessage(
        '12345',
        const ChatMessageRequest(messageText: 'Hi'),
      );

      verify(
        () => client.post<ChatMessageResponse>(
          ApiEndpoints.chatMessages('12345'),
          body: {'messageText': 'Hi'},
          idempotent: true,
          decode: any(named: 'decode'),
        ),
      ).called(1);
    });
  });

  group('ChatRepositoryImpl', () {
    late MockChatRemoteDataSource remote;
    late ChatRepositoryImpl repository;

    setUpAll(() {
      registerFallbackValue(const CreateChatRoomRequest(bookingId: ''));
      registerFallbackValue(const ChatMessageRequest(messageText: ''));
    });

    setUp(() {
      remote = MockChatRemoteDataSource();
      repository = ChatRepositoryImpl(remote);
    });

    test('openRoom maps CLOSED status to a read-only room', () async {
      when(
        () => remote.openRoom(const CreateChatRoomRequest(bookingId: '7')),
      ).thenAnswer(
        (_) async =>
            const ChatRoomResponse(id: '1', bookingId: '7', status: 'CLOSED'),
      );

      final room = (await repository.openRoom('7') as Ok<ChatRoom>).value;

      expect(room, const ChatRoom(id: '1', bookingId: '7', isClosed: true));
    });

    test('history infers hasMore from a full page of 50', () async {
      when(() => remote.getMessages('1', page: 0, size: 50)).thenAnswer(
        (_) async => ChatMessagePageResponse(
          messages: [
            for (var i = 0; i < 50; i++)
              ChatMessageResponse(id: '$i', messageText: 'm$i'),
          ],
        ),
      );

      final page = (await repository.getMessages(
        '1',
        page: 0,
      ) as Ok<ChatHistoryPage>).value;

      expect(page.hasMore, isTrue);
      expect(page.items.first.text, 'm0');
    });

    test('sendMessage trims the text', () async {
      when(() => remote.sendMessage('1', any())).thenAnswer(
        (_) async => const ChatMessageResponse(
          id: '9',
          senderId: '5',
          messageText: 'Hi',
        ),
      );

      final message = (await repository.sendMessage(
        '1',
        '  Hi  ',
      ) as Ok<ChatRoomMessage>).value;

      expect(
        message,
        const ChatRoomMessage(id: '9', senderId: '5', text: 'Hi'),
      );
      verify(
        () => remote.sendMessage(
          '1',
          const ChatMessageRequest(messageText: 'Hi'),
        ),
      ).called(1);
    });
  });

  group('ChatConnectionImpl', () {
    test('maps socket frames and statuses to domain events', () async {
      final socket = MockChatSocketDataSource();
      final frames = StreamController<ChatSocketFrame>();
      final statuses = StreamController<RealtimeSocketStatus>();
      when(() => socket.frames).thenAnswer((_) => frames.stream);
      when(() => socket.status).thenAnswer((_) => statuses.stream);
      final connection = ChatConnectionImpl(socket);

      final events = connection.events.toList();
      final states = connection.status.toList();
      frames
        ..add(
          const ChatSocketMessage(
            ChatMessageResponse(id: '1', messageText: 'Hi'),
          ),
        )
        ..add(const ChatSocketError('HS-409-0005'));
      statuses
        ..add(RealtimeSocketStatus.connected)
        ..add(RealtimeSocketStatus.closed);
      await frames.close();
      await statuses.close();

      final received = await events;
      expect((received.first as ChatLiveMessage).message.text, 'Hi');
      expect((received.last as ChatLiveError).errorCode, 'HS-409-0005');
      expect(await states, [
        ChatConnectionStatus.connected,
        ChatConnectionStatus.offline,
      ]);
    });
  });

  group('SendChatMessageUseCase', () {
    test('rejects blank text without calling the server', () async {
      final repository = MockChatRepository();

      final result = await SendChatMessageUseCase(repository)('1', '   ');

      expect((result as Err).failure.errorCode, 'HS-400-0001');
      verifyZeroInteractions(repository);
    });
  });

  group('ChatSocketDataSource', () {
    test('turns error envelopes into ChatSocketError frames', () async {
      final factory = _FakeFactory();
      final dataSource = ChatSocketDataSource(factory);
      final frames = dataSource.frames.toList();

      factory.messages
        ..add({'id': 5, 'messageText': 'Xin chào'})
        ..add({'status': 'error', 'errorCode': 'HS-403-0004'});
      await factory.messages.close();

      final received = await frames;
      expect(
        (received.first as ChatSocketMessage).message.messageText,
        'Xin chào',
      );
      expect((received.last as ChatSocketError).errorCode, 'HS-403-0004');
    });
  });
}

class _FakeSocket extends Mock implements RealtimeSocket;

class _FakeFactory implements RealtimeSocketFactory {
  final StreamController<Map<String, dynamic>> messages = StreamController();

  @override
  RealtimeSocket create() {
    final socket = _FakeSocket();
    when(() => socket.messages).thenAnswer((_) => messages.stream);
    return socket;
  }
}
