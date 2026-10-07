import 'package:vstech_home_services/core/error/result.dart';
import 'package:vstech_home_services/features/auth/domain/entities/profile_update.dart';
import 'package:vstech_home_services/features/auth/domain/entities/user_profile.dart';

abstract interface class ProfileRepository {
  Future<Result<UserProfile>> getProfile();

  Future<Result<UserProfile>> updateProfile(ProfileUpdate update);
}
