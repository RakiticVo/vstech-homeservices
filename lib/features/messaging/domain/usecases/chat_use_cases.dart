import 'package:injectable/injectable.dart';
import 'package:vstech_home_services/core/error/failure.dart';
import 'package:vstech_home_services/core/error/result.dart';
import 'package:vstech_home_services/core/network/network_exception.dart';
import 'package:vstech_home_services/features/messaging/domain/entities/chat.dart';
import 'package:vstech_home_services/features/messaging/domain/repositories/chat_repository.dart';

@injectable
class OpenChatRoomUseCase {
  const OpenChatRoomUseCase(this._repository);

  final ChatRepository _repository;

  Future<Result<ChatRoom>> call(String bookingId) =>
      _repository.openRoom(bookingId);
}

@injectable
class GetChatMessagesUseCase {
  const GetChatMessagesUseCase(this._repository);

  final ChatRepository _repository;

  Future<Result<ChatHistoryPage>> call(String roomId, {int page = 0}) =>
      _repository.getMessages(roomId, page: page);
}

/// Sends a text message. Blank text is rejected locally like the server would (`HS-400-0001`,
/// `messageText` must contain a non-space character).
@injectable
class SendChatMessageUseCase {
  const SendChatMessageUseCase(this._repository);

  final ChatRepository _repository;

  Future<Result<ChatRoomMessage>> call(String roomId, String text) async {
    if (text.trim().isEmpty) {
      return const Err(
        Failure(kind: NetworkErrorKind.unknown, errorCode: 'HS-400-0001'),
      );
    }
    return await _repository.sendMessage(roomId, text);
  }
}
