import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_profile_update_request.freezed.dart';
part 'user_profile_update_request.g.dart';

/// Body of `PUT /api/v1/profiles`. Only non-null fields are sent, so a partial update never
/// blanks out fields the screen didn't touch.
@freezed
abstract class UserProfileUpdateRequest with _$UserProfileUpdateRequest {
  // Freezed forwards this to the generated class — the documented way to set json options.
  // ignore: invalid_annotation_target
  @JsonSerializable(includeIfNull: false)
  const factory UserProfileUpdateRequest({
    String? fullName,
    String? avatarUrl,
    String? bio,
    String? locale,
    String? phoneNumber,
    String? email,
    String? defaultAddress,
    double? lat,
    double? lng,
    String? idCardFrontUrl,
    String? idCardBackUrl,
  }) = _UserProfileUpdateRequest;

  factory UserProfileUpdateRequest.fromJson(Map<String, dynamic> json) => _$UserProfileUpdateRequestFromJson(json);
}
