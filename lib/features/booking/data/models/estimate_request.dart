import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:vstech_home_services/core/utils/json_converters.dart';

part 'estimate_request.freezed.dart';
part 'estimate_request.g.dart';

/// Body of `POST /api/v1/bookings/estimate` — both fields required.
@freezed
abstract class EstimateRequest with _$EstimateRequest {
  const factory EstimateRequest({
    @IdConverter() required String categoryId,
    required String description,
  }) = _EstimateRequest;

  factory EstimateRequest.fromJson(Map<String, dynamic> json) => _$EstimateRequestFromJson(json);
}
