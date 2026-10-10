import 'package:freezed_annotation/freezed_annotation.dart';

part 'price_estimate.freezed.dart';

/// Server-side price estimate: service price + platform commission = total.
@freezed
abstract class PriceEstimate with _$PriceEstimate {
  const factory PriceEstimate({
    required num estimatedPrice,
    required num commissionFee,
    required num totalEstimated,
    String? categoryName,
  }) = _PriceEstimate;
}
