import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_info_response.freezed.dart';
part 'user_info_response.g.dart';

/// `UserInfo` inside `AuthResponse`.
@freezed
abstract class UserInfoResponse with _$UserInfoResponse {
  const factory UserInfoResponse({
    required int id,
    String? identityId,
    String? email,
    String? phoneNumber,
    String? fullName,
    String? role,
    String? avatarUrl,
  }) = _UserInfoResponse;

  factory UserInfoResponse.fromJson(Map<String, dynamic> json) => _$UserInfoResponseFromJson(json);
}
