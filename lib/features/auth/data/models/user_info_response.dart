import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:vstech_home_services/core/utils/json_converters.dart';

part 'user_info_response.freezed.dart';
part 'user_info_response.g.dart';

/// `UserInfo` inside `AuthResponse`.
@freezed
abstract class UserInfoResponse with _$UserInfoResponse {
  const factory UserInfoResponse({
    @IdConverter() required String id,
    String? identityId,
    String? email,
    String? phoneNumber,
    String? fullName,
    String? role,
    String? avatarUrl,
  }) = _UserInfoResponse;

  factory UserInfoResponse.fromJson(Map<String, dynamic> json) => _$UserInfoResponseFromJson(json);
}
