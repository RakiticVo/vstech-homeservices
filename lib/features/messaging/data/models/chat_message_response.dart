import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:vstech_home_services/core/utils/json_converters.dart';

part 'chat_message_response.freezed.dart';
part 'chat_message_response.g.dart';

/// One chat message — REST responses and server → client socket frames share this shape.
@freezed
abstract class ChatMessageResponse with _$ChatMessageResponse {
  const factory ChatMessageResponse({
    @IdConverter() required String id,
    @NullableIdConverter() String? roomId,
    @NullableIdConverter() String? senderId,
    String? messageText,
    @Default([]) List<String> mediaUrls,
    bool? isRead,
    @NullableUtcDateTimeConverter() DateTime? sentAt,
  }) = _ChatMessageResponse;

  factory ChatMessageResponse.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageResponseFromJson(json);
}

/// `data` of `GET /api/v1/chat/rooms/{roomId}/messages` — a bare list with **no** paging metadata.
@freezed
abstract class ChatMessagePageResponse with _$ChatMessagePageResponse {
  const factory ChatMessagePageResponse({
    @Default([]) List<ChatMessageResponse> messages,
  }) = _ChatMessagePageResponse;

  factory ChatMessagePageResponse.fromJson(Map<String, dynamic> json) =>
      _$ChatMessagePageResponseFromJson(json);
}
