import 'package:vstech_home_services/features/tracking/domain/entities/worker_position.dart';

/// Live tracking of one booking's worker — one per customer tracking screen.
abstract interface class TrackingConnection {
  Stream<TrackingEvent> get events;

  Stream<TrackingConnectionStatus> get status;

  Future<void> connect(String bookingId);

  /// Stops tracking (no reconnect) but allows [connect] again.
  Future<void> disconnect();

  Future<void> close();
}
