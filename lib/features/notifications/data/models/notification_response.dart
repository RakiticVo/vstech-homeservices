import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:vstech_home_services/core/utils/json_converters.dart';

part 'notification_response.freezed.dart';
part 'notification_response.g.dart';

/// One item of `GET /api/v1/notifications`. Ids are int64 in the OpenAPI spec, UUIDs in the doc.
@freezed
abstract class NotificationResponse with _$NotificationResponse {
  const factory NotificationResponse({
    @IdConverter() required String id,
    @NullableIdConverter() String? userId,
    String? title,
    String? body,
    String? type,
    bool? isRead,
    @NullableUtcDateTimeConverter() DateTime? createdAt,
  }) = _NotificationResponse;

  factory NotificationResponse.fromJson(Map<String, dynamic> json) =>
      _$NotificationResponseFromJson(json);
}

/// `data` of `GET /api/v1/notifications` — a bare list with **no** paging metadata.
@freezed
abstract class NotificationPageResponse with _$NotificationPageResponse {
  const factory NotificationPageResponse({
    @Default([]) List<NotificationResponse> notifications,
  }) = _NotificationPageResponse;

  factory NotificationPageResponse.fromJson(Map<String, dynamic> json) =>
      _$NotificationPageResponseFromJson(json);
}
