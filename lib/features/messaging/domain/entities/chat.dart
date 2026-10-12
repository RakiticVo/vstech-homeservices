import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat.freezed.dart';

/// The chat room of one booking. [id] is shared by REST and the socket.
@freezed
abstract class ChatRoom with _$ChatRoom {
  const factory ChatRoom({
    required String id,
    String? bookingId,
    String? customerId,
    String? workerId,
    @Default(false) bool isClosed,
  }) = _ChatRoom;
}

/// One message in a booking chat. [sentAt] is UTC.
@freezed
abstract class ChatRoomMessage with _$ChatRoomMessage {
  const factory ChatRoomMessage({
    required String id,
    String? senderId,
    @Default('') String text,
    @Default([]) List<String> mediaUrls,
    @Default(false) bool isRead,
    DateTime? sentAt,
  }) = _ChatRoomMessage;
}

/// A page of history. The API sends no paging metadata, so [hasMore] is inferred from a full page.
@freezed
abstract class ChatHistoryPage with _$ChatHistoryPage {
  const factory ChatHistoryPage({
    required List<ChatRoomMessage> items,
    required int page,
    required bool hasMore,
  }) = _ChatHistoryPage;
}

/// Something that happened on the live room connection.
sealed class ChatLiveEvent {
  const ChatLiveEvent();
}

final class ChatLiveMessage extends ChatLiveEvent {
  const ChatLiveMessage(this.message);

  final ChatRoomMessage message;
}

/// The server rejected the room (e.g. `HS-409-0005` closed, `HS-403-0004` not a participant).
final class ChatLiveError extends ChatLiveEvent {
  const ChatLiveError(this.errorCode);

  final String? errorCode;
}

enum ChatConnectionStatus { connecting, connected, reconnecting, offline }
