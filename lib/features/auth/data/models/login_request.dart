import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_request.freezed.dart';
part 'login_request.g.dart';

/// Body of `POST /api/v1/auth/login`. [identifier] is a phone number or an email.
@freezed
abstract class LoginRequest with _$LoginRequest {
  const factory LoginRequest({
    required String identifier,
    required String password,
  }) = _LoginRequest;

  factory LoginRequest.fromJson(Map<String, dynamic> json) => _$LoginRequestFromJson(json);
}
