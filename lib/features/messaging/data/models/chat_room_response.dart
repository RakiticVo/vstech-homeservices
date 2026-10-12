import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:vstech_home_services/core/utils/json_converters.dart';

part 'chat_room_response.freezed.dart';
part 'chat_room_response.g.dart';

/// `data` of `POST /api/v1/chat/rooms` (doc `07-chat.md` §1.1 — the OpenAPI spec has no schema).
/// The same `id` is used by REST and the `/ws/chat/{roomId}` socket.
@freezed
abstract class ChatRoomResponse with _$ChatRoomResponse {
  const factory ChatRoomResponse({
    @IdConverter() required String id,
    @NullableIdConverter() String? bookingId,
    @NullableIdConverter() String? customerId,
    @NullableIdConverter() String? workerId,
    String? status,
  }) = _ChatRoomResponse;

  factory ChatRoomResponse.fromJson(Map<String, dynamic> json) =>
      _$ChatRoomResponseFromJson(json);
}
