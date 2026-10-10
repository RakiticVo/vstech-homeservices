import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:vstech_home_services/core/utils/json_converters.dart';

part 'status_transition_response.freezed.dart';
part 'status_transition_response.g.dart';

/// `data` of booking state changes (cancel, dispute, accept, start, complete).
@freezed
abstract class StatusTransitionResponse with _$StatusTransitionResponse {
  const factory StatusTransitionResponse({
    @NullableIdConverter() String? requestId,
    String? previousStatus,
    String? newStatus,
    @NullableUtcDateTimeConverter() DateTime? timestamp,
  }) = _StatusTransitionResponse;

  factory StatusTransitionResponse.fromJson(Map<String, dynamic> json) => _$StatusTransitionResponseFromJson(json);
}
