import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:vstech_home_services/core/utils/json_converters.dart';

part 'estimate_response.freezed.dart';
part 'estimate_response.g.dart';

/// `data` of `POST /api/v1/bookings/estimate`.
@freezed
abstract class EstimateResponse with _$EstimateResponse {
  const factory EstimateResponse({
    @MoneyConverter() required num estimatedPrice,
    @NullableIdConverter() String? categoryId,
    String? categoryName,
    @NullableMoneyConverter() num? commissionFee,
    @NullableMoneyConverter() num? totalEstimated,
  }) = _EstimateResponse;

  factory EstimateResponse.fromJson(Map<String, dynamic> json) => _$EstimateResponseFromJson(json);
}
