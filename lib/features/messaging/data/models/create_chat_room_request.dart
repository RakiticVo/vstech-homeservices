import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:vstech_home_services/core/utils/json_converters.dart';

part 'create_chat_room_request.freezed.dart';
part 'create_chat_room_request.g.dart';

/// Body of `POST /api/v1/chat/rooms`.
@freezed
abstract class CreateChatRoomRequest with _$CreateChatRoomRequest {
  const factory CreateChatRoomRequest({
    @IdConverter() required String bookingId,
  }) = _CreateChatRoomRequest;

  factory CreateChatRoomRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateChatRoomRequestFromJson(json);
}
