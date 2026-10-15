import 'package:injectable/injectable.dart';
import 'package:vstech_home_services/core/network/realtime_socket.dart';
import 'package:vstech_home_services/features/tracking/data/datasources/customer_tracking_socket_data_source.dart';
import 'package:vstech_home_services/features/tracking/data/models/tracking_message_response.dart';
import 'package:vstech_home_services/features/tracking/domain/entities/worker_position.dart';
import 'package:vstech_home_services/features/tracking/domain/repositories/tracking_connection.dart';

@Injectable(as: TrackingConnection)
class TrackingConnectionImpl implements TrackingConnection {
  TrackingConnectionImpl(this._socket);

  final CustomerTrackingSocketDataSource _socket;

  @override
  Stream<TrackingEvent> get events =>
      _socket.messages.map(toEvent).where((event) => event != null).cast();

  @override
  Stream<TrackingConnectionStatus> get status => _socket.status.map(
    (status) => switch (status) {
      RealtimeSocketStatus.connecting => TrackingConnectionStatus.connecting,
      RealtimeSocketStatus.connected => TrackingConnectionStatus.live,
      RealtimeSocketStatus.reconnecting =>
        TrackingConnectionStatus.reconnecting,
      RealtimeSocketStatus.closed => TrackingConnectionStatus.offline,
    },
  );

  @override
  Future<void> connect(String bookingId) => _socket.connect(bookingId);

  @override
  Future<void> disconnect() => _socket.disconnect();

  @override
  Future<void> close() => _socket.close();

  /// Unknown frame types are ignored (null).
  static TrackingEvent? toEvent(TrackingMessageResponse m) => switch (m.type) {
    'CONNECTED' || 'LOCATION_UPDATE' => TrackingPositionEvent(_position(m)),
    'TRACKING_ENDED' => TrackingEndedEvent(m.reason),
    'ERROR' => TrackingErrorEvent(m.errorCode),
    null when m.status == 'error' || m.errorCode != null => TrackingErrorEvent(
      m.errorCode,
    ),
    _ => null,
  };

  static WorkerPosition? _position(TrackingMessageResponse m) {
    final lat = m.latitude;
    final lng = m.longitude;
    if (lat == null || lng == null) return null;
    return WorkerPosition(
      latitude: lat,
      longitude: lng,
      heading: m.heading,
      updatedAt: m.lastUpdated,
    );
  }
}
