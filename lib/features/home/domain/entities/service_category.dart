import 'package:freezed_annotation/freezed_annotation.dart';

part 'service_category.freezed.dart';

/// A bookable service (e.g. "Sửa máy lạnh") with its starting price.
@freezed
abstract class ServiceCategory with _$ServiceCategory {
  const factory ServiceCategory({
    required String id,
    required String name,
    String? description,
    num? basePrice,
    String? imageUrl,
  }) = _ServiceCategory;
}
