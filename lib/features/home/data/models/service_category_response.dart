import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:vstech_home_services/core/utils/json_converters.dart';

part 'service_category_response.freezed.dart';
part 'service_category_response.g.dart';

/// `ServiceCategoryResponse` of `GET /api/v1/service-categories[/{id}]`. Money fields arrive as
/// numeric strings (`"200000"`) per the module doc or numbers per OpenAPI — both accepted.
@freezed
abstract class ServiceCategoryResponse with _$ServiceCategoryResponse {
  const factory ServiceCategoryResponse({
    @IdConverter() required String id,
    required String name,
    String? description,
    @NullableMoneyConverter() num? basePrice,
    @NullableMoneyConverter() num? commissionRate,
    bool? isActive,
    String? imageUrl,
  }) = _ServiceCategoryResponse;

  factory ServiceCategoryResponse.fromJson(Map<String, dynamic> json) => _$ServiceCategoryResponseFromJson(json);
}
