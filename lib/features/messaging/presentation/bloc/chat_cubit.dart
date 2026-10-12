import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:vstech_home_services/core/error/failure.dart';
import 'package:vstech_home_services/core/error/result.dart';
import 'package:vstech_home_services/core/network/network_exception.dart';
import 'package:vstech_home_services/features/auth/domain/usecases/get_profile_use_case.dart';
import 'package:vstech_home_services/features/messaging/domain/entities/chat.dart';
import 'package:vstech_home_services/features/messaging/domain/entities/voip_call.dart';
import 'package:vstech_home_services/features/messaging/domain/repositories/chat_repository.dart';
import 'package:vstech_home_services/features/messaging/domain/usecases/chat_use_cases.dart';
import 'package:vstech_home_services/features/messaging/domain/usecases/voip_use_cases.dart';

part 'chat_state.dart';

/// Chat of one booking: opens (or reuses) the room, loads history, then listens on
/// `/ws/chat/{roomId}` for live messages. Messages are sent over REST and merged by id with
/// whatever the socket broadcasts, so a message never shows twice. The socket lives and dies
/// with this cubit.
@injectable
class ChatCubit extends Cubit<ChatState> {
  ChatCubit(
    this._getProfile,
    this._openRoom,
    this._getMessages,
    this._sendMessage,
    this._getCallHistory,
    this._connection,
  ) : super(const ChatLoadingState());

  final GetProfileUseCase _getProfile;
  final OpenChatRoomUseCase _openRoom;
  final GetChatMessagesUseCase _getMessages;
  final SendChatMessageUseCase _sendMessage;
  final GetCallHistoryUseCase _getCallHistory;
  final ChatConnection _connection;

  static const String roomClosedCode = 'HS-409-0005';

  StreamSubscription<ChatLiveEvent>? _events;
  StreamSubscription<ChatConnectionStatus>? _status;
  String? _bookingId;

  Future<void> open(String bookingId) async {
    _bookingId = bookingId;
    emit(const ChatLoadingState());
    final (profile, room) = await (_getProfile(), _openRoom(bookingId)).wait;
    if (isClosed) return;
    final ChatRoom openedRoom;
    final String myUserId;
    switch ((profile, room)) {
      case (Ok(value: final p), Ok(value: final r)):
        myUserId = p.id;
        openedRoom = r;
      case (Err(:final failure), _) || (_, Err(:final failure)):
        emit(
          ChatErrorState(
            failure,
            isRoomClosed: failure.errorCode == roomClosedCode,
          ),
        );
        return;
    }
    final (history, calls) = await (
      _getMessages(openedRoom.id),
      _getCallHistory(bookingId),
    ).wait;
    switch (history) {
      case Ok(:final value):
        if (isClosed) return;
        emit(
          ChatLoadedState(
            room: openedRoom,
            myUserId: myUserId,
            messages: _sorted(value.items),
            calls: calls is Ok<List<VoipCall>> ? calls.value : const [],
            page: value.page,
            hasMore: value.hasMore,
            connection: openedRoom.isClosed
                ? ChatConnectionStatus.offline
                : ChatConnectionStatus.connecting,
          ),
        );
      case Err(:final failure):
        if (!isClosed) emit(ChatErrorState(failure));
        return;
    }
    if (!openedRoom.isClosed) await _listen(openedRoom.id);
  }

  /// Reloads the booking's call log (e.g. after returning from the call screen). Failures keep
  /// the current list — the call log is secondary to the chat.
  Future<void> refreshCalls() async {
    final bookingId = _bookingId;
    if (bookingId == null) return;
    final result = await _getCallHistory(bookingId);
    final current = state;
    if (result case Ok(:final value)
        when current is ChatLoadedState && !isClosed) {
      emit(current.copyWith(calls: value));
    }
  }

  Future<void> retry() async {
    final bookingId = _bookingId;
    if (bookingId == null) return;
    await _stopListening();
    await open(bookingId);
  }

  Future<void> loadOlder() async {
    final current = state;
    if (current is! ChatLoadedState ||
        !current.hasMore ||
        current.isLoadingOlder) {
      return;
    }
    emit(current.copyWith(isLoadingOlder: true));
    final result = await _getMessages(current.room.id, page: current.page + 1);
    final latest = state;
    if (latest is! ChatLoadedState) return;
    switch (result) {
      case Ok(:final value):
        emit(
          latest.copyWith(
            messages: _merge(latest.messages, value.items),
            page: value.page,
            hasMore: value.hasMore,
            isLoadingOlder: false,
          ),
        );
      case Err(:final failure):
        emit(latest.copyWith(isLoadingOlder: false, actionFailure: failure));
    }
  }

  /// Sends [text]; returns true when the server accepted it (so the input can be cleared).
  Future<bool> send(String text) async {
    final current = state;
    if (current is! ChatLoadedState ||
        current.room.isClosed ||
        current.isSending) {
      return false;
    }
    emit(current.copyWith(isSending: true));
    final result = await _sendMessage(current.room.id, text);
    final latest = state;
    if (latest is! ChatLoadedState) return false;
    switch (result) {
      case Ok(:final value):
        emit(
          latest.copyWith(
            messages: _merge(latest.messages, [value]),
            isSending: false,
          ),
        );
        return true;
      case Err(:final failure):
        if (failure.errorCode == roomClosedCode) await _markClosed();
        final afterClose = state;
        if (afterClose is ChatLoadedState) {
          emit(afterClose.copyWith(isSending: false, actionFailure: failure));
        }
        return false;
    }
  }

  /// Reconnects the socket after it gave up.
  Future<void> reconnect() async {
    final current = state;
    if (current is! ChatLoadedState || current.room.isClosed) return;
    await _stopListening();
    emit(current.copyWith(connection: ChatConnectionStatus.connecting));
    await _listen(current.room.id);
  }

  Future<void> _listen(String roomId) async {
    _events = _connection.events.listen(_onEvent);
    _status = _connection.status.listen((status) {
      final current = state;
      if (current is ChatLoadedState && !current.room.isClosed) {
        emit(current.copyWith(connection: status));
      }
    });
    await _connection.connect(roomId);
  }

  void _onEvent(ChatLiveEvent event) {
    final current = state;
    if (current is! ChatLoadedState) return;
    switch (event) {
      case ChatLiveMessage(:final message):
        emit(current.copyWith(messages: _merge(current.messages, [message])));
      case ChatLiveError(:final errorCode):
        if (errorCode == roomClosedCode) {
          unawaited(_markClosed());
        } else {
          emit(
            current.copyWith(
              actionFailure: Failure(
                kind: NetworkErrorKind.server,
                errorCode: errorCode,
              ),
            ),
          );
        }
    }
  }

  Future<void> _markClosed() async {
    await _stopListening();
    final current = state;
    if (current is ChatLoadedState && !isClosed) {
      emit(
        current.copyWith(
          room: current.room.copyWith(isClosed: true),
          connection: ChatConnectionStatus.offline,
        ),
      );
    }
  }

  Future<void> _stopListening() async {
    await _events?.cancel();
    await _status?.cancel();
    _events = null;
    _status = null;
  }

  static List<ChatRoomMessage> _merge(
    List<ChatRoomMessage> current,
    List<ChatRoomMessage> incoming,
  ) {
    final byId = {
      for (final m in current) m.id: m,
      for (final m in incoming) m.id: m,
    };
    return _sorted(byId.values);
  }

  /// Oldest first: by `sentAt`, then numerically by id (the API does not state its order).
  static List<ChatRoomMessage> _sorted(Iterable<ChatRoomMessage> messages) {
    final list = messages.toList()
      ..sort((a, b) {
        final byTime = (a.sentAt ?? DateTime(0)).compareTo(
          b.sentAt ?? DateTime(0),
        );
        if (byTime != 0) return byTime;
        final ai = int.tryParse(a.id);
        final bi = int.tryParse(b.id);
        return ai != null && bi != null
            ? ai.compareTo(bi)
            : a.id.compareTo(b.id);
      });
    return list;
  }

  @override
  Future<void> close() async {
    await _stopListening();
    await _connection.close();
    return await super.close();
  }
}
