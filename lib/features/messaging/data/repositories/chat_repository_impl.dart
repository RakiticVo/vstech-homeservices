import 'package:injectable/injectable.dart';
import 'package:vstech_home_services/core/error/result.dart';
import 'package:vstech_home_services/core/network/realtime_socket.dart';
import 'package:vstech_home_services/features/messaging/data/datasources/chat_remote_data_source.dart';
import 'package:vstech_home_services/features/messaging/data/datasources/chat_socket_data_source.dart';
import 'package:vstech_home_services/features/messaging/data/models/chat_message_request.dart';
import 'package:vstech_home_services/features/messaging/data/models/chat_message_response.dart';
import 'package:vstech_home_services/features/messaging/data/models/create_chat_room_request.dart';
import 'package:vstech_home_services/features/messaging/domain/entities/chat.dart';
import 'package:vstech_home_services/features/messaging/domain/repositories/chat_repository.dart';

@LazySingleton(as: ChatRepository)
class ChatRepositoryImpl implements ChatRepository {
  ChatRepositoryImpl(this._remote);

  final ChatRemoteDataSource _remote;

  /// Doc default for chat history (`07-chat.md` §1.3).
  static const int pageSize = 50;

  @override
  Future<Result<ChatRoom>> openRoom(String bookingId) => Result.guard(() async {
    final r = await _remote.openRoom(
      CreateChatRoomRequest(bookingId: bookingId),
    );
    return ChatRoom(
      id: r.id,
      bookingId: r.bookingId,
      customerId: r.customerId,
      workerId: r.workerId,
      isClosed: r.status == 'CLOSED',
    );
  });

  @override
  Future<Result<ChatHistoryPage>> getMessages(
    String roomId, {
    required int page,
  }) => Result.guard(() async {
    final response = await _remote.getMessages(
      roomId,
      page: page,
      size: pageSize,
    );
    return ChatHistoryPage(
      items: [for (final m in response.messages) toMessage(m)],
      page: page,
      hasMore: response.messages.length >= pageSize,
    );
  });

  @override
  Future<Result<ChatRoomMessage>> sendMessage(String roomId, String text) =>
      Result.guard(
        () async => toMessage(
          await _remote.sendMessage(
            roomId,
            ChatMessageRequest(messageText: text.trim()),
          ),
        ),
      );

  static ChatRoomMessage toMessage(ChatMessageResponse r) => ChatRoomMessage(
    id: r.id,
    senderId: r.senderId,
    text: r.messageText ?? '',
    mediaUrls: r.mediaUrls,
    isRead: r.isRead ?? false,
    sentAt: r.sentAt,
  );
}

@Injectable(as: ChatConnection)
class ChatConnectionImpl implements ChatConnection {
  ChatConnectionImpl(this._socket);

  final ChatSocketDataSource _socket;

  @override
  Stream<ChatLiveEvent> get events => _socket.frames.map(
    (frame) => switch (frame) {
      ChatSocketMessage(:final message) => ChatLiveMessage(
        ChatRepositoryImpl.toMessage(message),
      ),
      ChatSocketError(:final errorCode) => ChatLiveError(errorCode),
    },
  );

  @override
  Stream<ChatConnectionStatus> get status => _socket.status.map(
    (status) => switch (status) {
      RealtimeSocketStatus.connecting => ChatConnectionStatus.connecting,
      RealtimeSocketStatus.connected => ChatConnectionStatus.connected,
      RealtimeSocketStatus.reconnecting => ChatConnectionStatus.reconnecting,
      RealtimeSocketStatus.closed => ChatConnectionStatus.offline,
    },
  );

  @override
  Future<void> connect(String roomId) => _socket.connect(roomId);

  @override
  Future<void> close() => _socket.close();
}
