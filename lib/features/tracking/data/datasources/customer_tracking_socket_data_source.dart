import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:vstech_home_services/core/network/api_endpoints.dart';
import 'package:vstech_home_services/core/network/realtime_socket.dart';
import 'package:vstech_home_services/features/tracking/data/models/tracking_message_response.dart';
import 'package:vstech_home_services/features/tracking/data/models/tracking_subscribe_request.dart';

/// Customer side of `/ws/tracking/customer`. Every time the socket (re)connects it sends SUBSCRIBE
/// for the booking, so a dropped connection resumes on its own. One per tracking screen.
@injectable
class CustomerTrackingSocketDataSource {
  CustomerTrackingSocketDataSource(RealtimeSocketFactory factory)
    : _socket = factory.create();

  final RealtimeSocket _socket;
  StreamSubscription<RealtimeSocketStatus>? _resubscribe;

  Stream<RealtimeSocketStatus> get status => _socket.status;

  Stream<TrackingMessageResponse> get messages =>
      _socket.messages.map(TrackingMessageResponse.fromJson);

  Future<void> connect(String bookingId) async {
    final subscribe = TrackingSubscribeRequest(bookingId: bookingId).toJson();
    await _resubscribe?.cancel();
    _resubscribe = _socket.status
        .where((status) => status == RealtimeSocketStatus.connected)
        .listen((_) => _socket.send(subscribe));
    await _socket.connect(ApiEndpoints.wsTrackingCustomer);
  }

  Future<void> close() async {
    await _resubscribe?.cancel();
    _resubscribe = null;
    await _socket.close();
  }
}
