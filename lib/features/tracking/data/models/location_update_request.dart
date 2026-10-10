import 'package:freezed_annotation/freezed_annotation.dart';

part 'location_update_request.freezed.dart';
part 'location_update_request.g.dart';

/// Body of `PUT /api/v1/technician/location`. `technicianId` is omitted on purpose — the server
/// ignores it and takes the worker from the JWT (`docs/reference/api/09-location-tracking.md`).
@freezed
abstract class LocationUpdateRequest with _$LocationUpdateRequest {
  const factory LocationUpdateRequest({required double latitude, required double longitude}) = _LocationUpdateRequest;

  factory LocationUpdateRequest.fromJson(Map<String, dynamic> json) => _$LocationUpdateRequestFromJson(json);
}
