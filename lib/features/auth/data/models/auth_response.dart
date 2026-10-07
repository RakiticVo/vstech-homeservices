import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:vstech_home_services/features/auth/data/models/user_info_response.dart';

part 'auth_response.freezed.dart';
part 'auth_response.g.dart';

/// `data` of login/register (`AuthResponse`).
@freezed
abstract class AuthResponse with _$AuthResponse {
  const factory AuthResponse({
    required String accessToken,
    required String refreshToken,
    required UserInfoResponse user,
  }) = _AuthResponse;

  factory AuthResponse.fromJson(Map<String, dynamic> json) => _$AuthResponseFromJson(json);
}
