import 'package:injectable/injectable.dart';
import 'package:vstech_home_services/core/network/api_client.dart';
import 'package:vstech_home_services/core/network/api_endpoints.dart';
import 'package:vstech_home_services/features/messaging/data/models/chat_message_request.dart';
import 'package:vstech_home_services/features/messaging/data/models/chat_message_response.dart';
import 'package:vstech_home_services/features/messaging/data/models/chat_room_response.dart';
import 'package:vstech_home_services/features/messaging/data/models/create_chat_room_request.dart';

/// `/api/v1/chat/*` — booking chat rooms and their message history.
@injectable
class ChatRemoteDataSource {
  const ChatRemoteDataSource(this._client);

  final ApiClient _client;

  /// Opens the room for a booking, or returns the existing one.
  Future<ChatRoomResponse> openRoom(CreateChatRoomRequest body) async {
    final response = await _client.post(
      ApiEndpoints.chatRooms,
      body: body.toJson(),
      idempotent: true,
      decode: (json) =>
          ChatRoomResponse.fromJson(json! as Map<String, dynamic>),
    );
    return response.requireData;
  }

  Future<ChatMessagePageResponse> getMessages(
    String roomId, {
    required int page,
    required int size,
  }) async {
    final response = await _client.get(
      ApiEndpoints.chatMessages(roomId),
      query: {'page': page, 'size': size},
      decode: (json) =>
          ChatMessagePageResponse.fromJson(json! as Map<String, dynamic>),
    );
    return response.requireData;
  }

  Future<ChatMessageResponse> sendMessage(
    String roomId,
    ChatMessageRequest body,
  ) async {
    final response = await _client.post(
      ApiEndpoints.chatMessages(roomId),
      body: body.toJson(),
      idempotent: true,
      decode: (json) =>
          ChatMessageResponse.fromJson(json! as Map<String, dynamic>),
    );
    return response.requireData;
  }
}
