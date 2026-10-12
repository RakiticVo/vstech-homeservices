import 'package:vstech_home_services/core/error/result.dart';
import 'package:vstech_home_services/features/messaging/domain/entities/chat.dart';

abstract interface class ChatRepository {
  Future<Result<ChatRoom>> openRoom(String bookingId);

  Future<Result<ChatHistoryPage>> getMessages(
    String roomId, {
    required int page,
  });

  Future<Result<ChatRoomMessage>> sendMessage(String roomId, String text);
}

/// Live connection to one room — one per chat screen.
abstract interface class ChatConnection {
  Stream<ChatLiveEvent> get events;

  Stream<ChatConnectionStatus> get status;

  Future<void> connect(String roomId);

  Future<void> close();
}
