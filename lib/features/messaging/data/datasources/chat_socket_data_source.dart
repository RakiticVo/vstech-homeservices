import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:vstech_home_services/core/network/api_endpoints.dart';
import 'package:vstech_home_services/core/network/realtime_socket.dart';
import 'package:vstech_home_services/features/messaging/data/models/chat_message_request.dart';
import 'package:vstech_home_services/features/messaging/data/models/chat_message_response.dart';

/// A server → client chat socket frame: either a broadcast message or an error envelope
/// (`{"status":"error","errorCode":"HS-409-0005",...}`).
sealed class ChatSocketFrame {
  const ChatSocketFrame();
}

final class ChatSocketMessage extends ChatSocketFrame {
  const ChatSocketMessage(this.message);

  final ChatMessageResponse message;
}

final class ChatSocketError extends ChatSocketFrame {
  const ChatSocketError(this.errorCode);

  final String? errorCode;
}

/// Live connection to `/ws/chat/{roomId}`. Created per chat screen; [close] it with the BLoC.
@injectable
class ChatSocketDataSource {
  ChatSocketDataSource(RealtimeSocketFactory factory)
    : _socket = factory.create();

  final RealtimeSocket _socket;

  Stream<RealtimeSocketStatus> get status => _socket.status;

  Stream<ChatSocketFrame> get frames => _socket.messages.map((json) {
    if (json['errorCode'] != null || json['status'] == 'error') {
      return ChatSocketError(json['errorCode'] as String?);
    }
    return ChatSocketMessage(ChatMessageResponse.fromJson(json));
  });

  Future<void> connect(String roomId) =>
      _socket.connect(ApiEndpoints.wsChat(roomId));

  bool send(ChatMessageRequest request) => _socket.send(request.toJson());

  Future<void> close() => _socket.close();
}
