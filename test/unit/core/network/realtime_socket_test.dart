import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vstech_home_services/core/network/realtime_socket.dart';

import '../../../helpers/fake_web_socket_channel.dart';
import '../../../helpers/mocks.dart';

void main() {
  late MockAuthTokenStore tokenStore;
  late List<FakeWebSocketChannel> channels;
  late List<(Uri, Map<String, String>)> handshakes;
  late List<bool> failHandshakes;

  setUp(() {
    tokenStore = MockAuthTokenStore();
    when(tokenStore.readAccessToken).thenAnswer((_) async => 'jwt-1');
    channels = [];
    handshakes = [];
    failHandshakes = [];
  });

  RealtimeSocket socket({int maxReconnectAttempts = 5}) => RealtimeSocket(
    tokenStore: tokenStore,
    baseUrl: 'wss://uat.example.com',
    maxReconnectAttempts: maxReconnectAttempts,
    reconnectDelay: (_) => Duration.zero,
    connector: (uri, headers) {
      handshakes.add((uri, headers));
      final fail = failHandshakes.isNotEmpty && failHandshakes.removeAt(0);
      final channel = FakeWebSocketChannel(failHandshake: fail);
      channels.add(channel);
      return channel;
    },
  );

  test(
    'connects with the bearer header, decodes JSON frames and sends JSON',
    () async {
      final s = socket();
      final statuses = <RealtimeSocketStatus>[];
      s.status.listen(statuses.add);
      final received = <Map<String, dynamic>>[];
      s.messages.listen(received.add);

      await s.connect('/ws/chat/12');
      channels.single
        ..serverSend('{"id":1,"messageText":"Xin chào"}')
        ..serverSend('not json')
        ..serverSend('[1,2]');
      await pumpEventQueue();

      expect(
        handshakes.single.$1.toString(),
        'wss://uat.example.com/ws/chat/12',
      );
      expect(handshakes.single.$2, {'Authorization': 'Bearer jwt-1'});
      expect(received, [
        {'id': 1, 'messageText': 'Xin chào'},
      ]);
      expect(s.send({'messageText': 'Ok'}), isTrue);
      expect(jsonDecode(channels.single.sent.single as String), {
        'messageText': 'Ok',
      });
      expect(statuses, [
        RealtimeSocketStatus.connecting,
        RealtimeSocketStatus.connected,
      ]);
      await s.close();
    },
  );

  test(
    'reconnects with a fresh token after the server drops the connection',
    () async {
      final s = socket();
      await s.connect('/ws/chat/12');
      when(tokenStore.readAccessToken).thenAnswer((_) async => 'jwt-2');

      await channels.first.serverClose();
      await pumpEventQueue();

      expect(channels, hasLength(2));
      expect(handshakes.last.$2, {'Authorization': 'Bearer jwt-2'});
      await s.close();
    },
  );

  test('gives up after maxReconnectAttempts failed handshakes', () async {
    failHandshakes.addAll(List.filled(10, true));
    final s = socket(maxReconnectAttempts: 2);
    final statuses = <RealtimeSocketStatus>[];
    s.status.listen(statuses.add);

    await s.connect('/ws/chat/12');
    await pumpEventQueue();

    expect(channels, hasLength(3));
    expect(statuses.last, RealtimeSocketStatus.closed);
    await s.close();
  });

  test('close stops reconnecting and closes the sink', () async {
    final s = socket();
    await s.connect('/ws/chat/12');
    final first = channels.single;

    await s.close();
    await pumpEventQueue();

    expect(first.isClosedByClient, isTrue);
    expect(channels, hasLength(1));
    expect(s.send({'messageText': 'late'}), isFalse);
  });
}
