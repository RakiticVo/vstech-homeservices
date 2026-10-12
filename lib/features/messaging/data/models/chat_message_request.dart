import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_message_request.freezed.dart';
part 'chat_message_request.g.dart';

/// Body of `POST /api/v1/chat/rooms/{roomId}/messages`, also the client → server socket frame.
@freezed
abstract class ChatMessageRequest with _$ChatMessageRequest {
  // freezed copies this onto the generated class; omit `mediaUrls` when null.
  // ignore: invalid_annotation_target
  @JsonSerializable(includeIfNull: false)
  const factory ChatMessageRequest({
    required String messageText,
    List<String>? mediaUrls,
  }) = _ChatMessageRequest;

  factory ChatMessageRequest.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageRequestFromJson(json);
}
