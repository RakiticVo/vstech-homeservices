import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:vstech_home_services/core/session/user_role.dart';

part 'app_user.freezed.dart';

/// The signed-in account, as returned by login/register.
@freezed
abstract class AppUser with _$AppUser {
  const factory AppUser({
    required String id,
    required UserRole role,
    String? fullName,
    String? email,
    String? phoneNumber,
    String? avatarUrl,
  }) = _AppUser;
}
