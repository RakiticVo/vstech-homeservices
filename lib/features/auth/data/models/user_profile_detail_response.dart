import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_profile_detail_response.freezed.dart';
part 'user_profile_detail_response.g.dart';

/// `UserProfileDTO` — customer-specific profile fields.
@freezed
abstract class UserProfileDetailResponse with _$UserProfileDetailResponse {
  const factory UserProfileDetailResponse({
    String? defaultAddress,
    double? lat,
    double? lng,
  }) = _UserProfileDetailResponse;

  factory UserProfileDetailResponse.fromJson(Map<String, dynamic> json) => _$UserProfileDetailResponseFromJson(json);
}
