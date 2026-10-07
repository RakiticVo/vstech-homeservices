import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:vstech_home_services/core/session/user_role.dart';

part 'user_profile.freezed.dart';

/// Full profile of the signed-in user (`GET /api/v1/profiles`). Worker-only fields are null for
/// customers.
@freezed
abstract class UserProfile with _$UserProfile {
  const factory UserProfile({
    required String id,
    required UserRole role,
    @Default('') String fullName,
    String? email,
    String? phoneNumber,
    String? avatarUrl,
    String? bio,
    String? locale,
    String? defaultAddress,
    double? lat,
    double? lng,
    double? rating,
    int? totalJobs,
    String? verificationStatus,
    String? kycApprovalStatus,
    int? completedJobs,
    double? cancellationRate,
    String? badgeTier,
  }) = _UserProfile;

  const UserProfile._();

  /// Up to two initials for the avatar placeholder, e.g. "Nguyễn Thị Mai" → "NM".
  String get initials {
    final parts = fullName.trim().split(RegExp(r'\s+')).where((p) => p.isNotEmpty).toList();
    if (parts.isEmpty) return '';
    String first(String word) => String.fromCharCode(word.runes.first);
    if (parts.length == 1) return first(parts.first).toUpperCase();
    return (first(parts.first) + first(parts.last)).toUpperCase();
  }
}
