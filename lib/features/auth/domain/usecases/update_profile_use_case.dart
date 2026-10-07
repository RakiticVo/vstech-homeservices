import 'package:injectable/injectable.dart';
import 'package:vstech_home_services/core/error/result.dart';
import 'package:vstech_home_services/features/auth/domain/entities/profile_update.dart';
import 'package:vstech_home_services/features/auth/domain/entities/user_profile.dart';
import 'package:vstech_home_services/features/auth/domain/repositories/profile_repository.dart';
import 'package:vstech_home_services/features/auth/domain/usecases/phone_normalizer.dart';

@injectable
class UpdateProfileUseCase {
  const UpdateProfileUseCase(this._repository);

  final ProfileRepository _repository;

  Future<Result<UserProfile>> call(ProfileUpdate update) => _repository.updateProfile(
    ProfileUpdate(
      fullName: update.fullName?.trim(),
      phoneNumber: update.phoneNumber == null ? null : normalizePhone(update.phoneNumber!),
      email: update.email?.trim(),
      defaultAddress: update.defaultAddress?.trim(),
      lat: update.lat,
      lng: update.lng,
    ),
  );
}
