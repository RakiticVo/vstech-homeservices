part of 'chat_cubit.dart';

@immutable
sealed class ChatState {
  const ChatState();
}

final class ChatLoadingState extends ChatState {
  const ChatLoadingState();
}

final class ChatErrorState extends ChatState {
  const ChatErrorState(this.failure, {this.isRoomClosed = false});

  final Failure failure;

  /// The booking's room is closed (`HS-409-0005`) — nothing to retry.
  final bool isRoomClosed;

  @override
  bool operator ==(Object other) =>
      other is ChatErrorState &&
      other.failure == failure &&
      other.isRoomClosed == isRoomClosed;

  @override
  int get hashCode => Object.hash(failure, isRoomClosed);
}

final class ChatLoadedState extends ChatState {
  const ChatLoadedState({
    required this.room,
    required this.myUserId,
    required this.messages,
    required this.page,
    required this.hasMore,
    this.connection = ChatConnectionStatus.connecting,
    this.isLoadingOlder = false,
    this.isSending = false,
    this.actionFailure,
  });

  final ChatRoom room;

  /// Profile id of the signed-in user — a message is "mine" when its `senderId` matches.
  final String myUserId;

  /// Oldest first.
  final List<ChatRoomMessage> messages;
  final int page;
  final bool hasMore;
  final ChatConnectionStatus connection;
  final bool isLoadingOlder;
  final bool isSending;

  /// One-shot failure of send / load-older / a socket error, shown as a SnackBar.
  final Failure? actionFailure;

  bool isMine(ChatRoomMessage message) => message.senderId == myUserId;

  /// Clears [actionFailure] unless a new one is passed.
  ChatLoadedState copyWith({
    ChatRoom? room,
    List<ChatRoomMessage>? messages,
    int? page,
    bool? hasMore,
    ChatConnectionStatus? connection,
    bool? isLoadingOlder,
    bool? isSending,
    Failure? actionFailure,
  }) => ChatLoadedState(
    room: room ?? this.room,
    myUserId: myUserId,
    messages: messages ?? this.messages,
    page: page ?? this.page,
    hasMore: hasMore ?? this.hasMore,
    connection: connection ?? this.connection,
    isLoadingOlder: isLoadingOlder ?? this.isLoadingOlder,
    isSending: isSending ?? this.isSending,
    actionFailure: actionFailure,
  );

  @override
  bool operator ==(Object other) =>
      other is ChatLoadedState &&
      other.room == room &&
      other.myUserId == myUserId &&
      listEquals(other.messages, messages) &&
      other.page == page &&
      other.hasMore == hasMore &&
      other.connection == connection &&
      other.isLoadingOlder == isLoadingOlder &&
      other.isSending == isSending &&
      other.actionFailure == actionFailure;

  @override
  int get hashCode => Object.hash(
    room,
    myUserId,
    Object.hashAll(messages),
    page,
    hasMore,
    connection,
    isLoadingOlder,
    isSending,
    actionFailure,
  );
}
