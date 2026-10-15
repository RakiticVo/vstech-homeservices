import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vstech_home_services/core/network/realtime_socket.dart';
import 'package:vstech_home_services/features/tracking/data/datasources/customer_tracking_socket_data_source.dart';
import 'package:vstech_home_services/features/tracking/data/models/tracking_message_response.dart';
import 'package:vstech_home_services/features/tracking/data/repositories/tracking_connection_impl.dart';
import 'package:vstech_home_services/features/tracking/domain/entities/worker_position.dart';

import '../../../helpers/fake_web_socket_channel.dart';
import '../../../helpers/mocks.dart';

class _Factory implements RealtimeSocketFactory {
  _Factory(this.tokenStore);

  final MockAuthTokenStore tokenStore;
  final List<FakeWebSocketChannel> channels = [];
  final List<Uri> uris = [];

  @override
  RealtimeSocket create() => RealtimeSocket(
    tokenStore: tokenStore,
    baseUrl: 'wss://uat.example.com',
    reconnectDelay: (_) => Duration.zero,
    connector: (uri, headers) {
      uris.add(uri);
      final channel = FakeWebSocketChannel();
      channels.add(channel);
      return channel;
    },
  );
}

void main() {
  late MockAuthTokenStore tokenStore;
  late _Factory factory;

  setUp(() {
    tokenStore = MockAuthTokenStore();
    when(tokenStore.readAccessToken).thenAnswer((_) async => 'jwt');
    factory = _Factory(tokenStore);
  });

  group('CustomerTrackingSocketDataSource', () {
    test('connects to /ws/tracking/customer and subscribes with a numeric booking id', () async {
      final dataSource = CustomerTrackingSocketDataSource(factory);

      await dataSource.connect('101');
      await pumpEventQueue();

      expect(
        factory.uris.single.toString(),
        'wss://uat.example.com/ws/tracking/customer',
      );
      expect(jsonDecode(factory.channels.single.sent.single as String), {
        'bookingId': 101,
        'action': 'SUBSCRIBE',
      });
      await dataSource.close();
    });

    test('subscribes again after a reconnect', () async {
      final dataSource = CustomerTrackingSocketDataSource(factory);
      await dataSource.connect('101');
      await pumpEventQueue();

      await factory.channels.first.serverClose();
      await pumpEventQueue();

      expect(factory.channels, hasLength(2));
      expect(factory.channels.last.sent, hasLength(1));
      await dataSource.close();
    });

    test('decodes server frames', () async {
      final dataSource = CustomerTrackingSocketDataSource(factory);
      final frames = <TrackingMessageResponse>[];
      dataSource.messages.listen(frames.add);
      await dataSource.connect('101');

      factory.channels.single.serverSend(
        '{"type":"LOCATION_UPDATE","technicianId":"t-1","latitude":10.76,"longitude":106,"heading":90,'
        '"lastUpdated":"2026-10-15T03:00:00Z","bookingId":null}',
      );
      await pumpEventQueue();

      expect(frames.single.longitude, 106.0);
      expect(frames.single.lastUpdated, DateTime.utc(2026, 10, 15, 3));
      await dataSource.close();
    });
  });

  group('TrackingConnectionImpl.toEvent', () {
    test('maps every documented frame type and ignores unknown ones', () {
      expect(
        (TrackingConnectionImpl.toEvent(
                  const TrackingMessageResponse(
                    type: 'CONNECTED',
                    latitude: 10.7,
                    longitude: 106.6,
                    heading: 45,
                  ),
                )!
                as TrackingPositionEvent)
            .position,
        const WorkerPosition(latitude: 10.7, longitude: 106.6, heading: 45),
      );
      expect(
        (TrackingConnectionImpl.toEvent(
                  const TrackingMessageResponse(type: 'CONNECTED'),
                )!
                as TrackingPositionEvent)
            .position,
        isNull,
      );
      expect(
        (TrackingConnectionImpl.toEvent(
                  const TrackingMessageResponse(
                    type: 'TRACKING_ENDED',
                    reason: 'COMPLETED',
                  ),
                )!
                as TrackingEndedEvent)
            .reason,
        'COMPLETED',
      );
      expect(
        (TrackingConnectionImpl.toEvent(
                  const TrackingMessageResponse(
                    type: 'ERROR',
                    errorCode: 'HS-403-0001',
                  ),
                )!
                as TrackingErrorEvent)
            .errorCode,
        'HS-403-0001',
      );
      expect(
        TrackingConnectionImpl.toEvent(
          const TrackingMessageResponse(
            status: 'error',
            errorCode: 'HS-401-0001',
          ),
        ),
        isA<TrackingErrorEvent>(),
      );
      expect(
        TrackingConnectionImpl.toEvent(
          const TrackingMessageResponse(type: 'PING'),
        ),
        isNull,
      );
    });
  });

  test('WorkerPosition.distanceTo is about right across Ho Chi Minh City', () {
    // Ben Thanh market → a point ~0.8 km north-north-east.
    const benThanh = WorkerPosition(latitude: 10.7725, longitude: 106.6980);
    final metres = benThanh.distanceTo(latitude: 10.7798, longitude: 106.6990);

    expect(metres, inInclusiveRange(780, 850));
    expect(benThanh.distanceTo(latitude: 10.7725, longitude: 106.6980), 0);
  });
}
